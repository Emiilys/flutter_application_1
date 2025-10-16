import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:url_launcher/url_launcher.dart';

class TelefonePage extends StatefulWidget {
  const TelefonePage({super.key});

  @override
  State<TelefonePage> createState() => _TelefonePageState();
}

class _TelefonePageState extends State<TelefonePage> {
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController numeroController = TextEditingController();
  final TextEditingController searchController = TextEditingController();

  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  // Telefones oficiais fixos
  final List<Map<String, String>> contatosFixos = [
    {'nome': 'Polícia Militar', 'numero': '190'},
    {'nome': 'SAMU', 'numero': '192'},
    {'nome': 'Bombeiros', 'numero': '193'},
    {'nome': 'Polícia Civil', 'numero': '197'},
    {'nome': 'Defesa Civil', 'numero': '199'},
    {'nome': 'Disque Denúncia', 'numero': '181'},
    {'nome': 'Mulher (Central 180)', 'numero': '180'},
    {'nome': 'Direitos Humanos (Disque 100)', 'numero': '100'},
  ];

  String filtroPesquisa = '';

  Future<void> _adicionarContato() async {
    final usuario = auth.currentUser;
    if (usuario == null) return;

    final nome = nomeController.text.trim();
    final numero = numeroController.text.trim();

    if (nome.isEmpty || numero.isEmpty) return;

    await firestore.collection('contatos').add({
      'nome': nome,
      'numero': numero,
      'favorito': false,
      'uid': usuario.uid,
      'criadoEm': FieldValue.serverTimestamp(),
    });

    nomeController.clear();
    numeroController.clear();
  }

  void _editarContato(DocumentSnapshot contato) {
    final nomeEditController = TextEditingController(text: contato['nome']);
    final numeroEditController = TextEditingController(text: contato['numero']);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Editar contato'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nomeEditController,
              decoration: const InputDecoration(labelText: 'Nome'),
            ),
            TextField(
              controller: numeroEditController,
              decoration: const InputDecoration(labelText: 'Número'),
              keyboardType: TextInputType.phone,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () async {
              await firestore.collection('contatos').doc(contato.id).update({
                'nome': nomeEditController.text.trim(),
                'numero': numeroEditController.text.trim(),
              });
              Navigator.pop(context);
            },
            child: const Text('Salvar'),
          ),
        ],
      ),
    );
  }

  void _excluirContato(DocumentSnapshot contato) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Excluir contato'),
        content: const Text('Tem certeza que deseja excluir este contato?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.redAccent,
              foregroundColor: Colors.white,
            ),
            onPressed: () async {
              await firestore.collection('contatos').doc(contato.id).delete();
              Navigator.pop(context);
            },
            child: const Text('Excluir'),
          ),
        ],
      ),
    );
  }

  void _alternarFavorito(DocumentSnapshot contato) async {
    final favoritoAtual = contato['favorito'] ?? false;
    await firestore
        .collection('contatos')
        .doc(contato.id)
        .update({'favorito': !favoritoAtual});
  }

  void _ligar(String numero) async {
    final Uri uri = Uri(scheme: 'tel', path: numero);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Não foi possível ligar para $numero')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final usuario = auth.currentUser;
    final contatosRef = firestore.collection('contatos');

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Telefones de Emergência',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF00897B),
      ),
      body: Padding(
        padding: const EdgeInsets.only(bottom: 70), // 🔹 evita que o botão sobreponha
        child: Column(
          children: [
            // 🔍 Campo de pesquisa
            Padding(
              padding: const EdgeInsets.all(12),
              child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                  hintText: 'Pesquisar por nome...',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onChanged: (value) {
                  setState(() => filtroPesquisa = value.toLowerCase());
                },
              ),
            ),

            // 🔹 Conteúdo
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                children: [
                  const Text(
                    'Emergências Oficiais',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 8),
                  ...contatosFixos.map((c) => Card(
                        color: Colors.red[50],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                          side: BorderSide(color: Colors.red.shade100),
                        ),
                        child: ListTile(
                          leading: const CircleAvatar(
                            backgroundColor: Colors.redAccent,
                            child: Icon(Icons.local_phone, color: Colors.white),
                          ),
                          title: Text(
                            c['nome']!,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.red.shade700),
                          ),
                          subtitle: Text(c['numero']!),
                          trailing: IconButton(
                            icon: const Icon(Icons.call, color: Colors.redAccent),
                            onPressed: () => _ligar(c['numero']!),
                          ),
                        ),
                      )),
                  const SizedBox(height: 20),
                  const Divider(),
                  const Text(
                    'Favoritos ⭐',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(height: 8),

                  // ⭐ Seção de favoritos
                  StreamBuilder<QuerySnapshot>(
                    stream: contatosRef
                        .where('uid', isEqualTo: usuario?.uid)
                        .where('favorito', isEqualTo: true)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return const Text('Erro ao carregar favoritos');
                      }
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                            child: CircularProgressIndicator());
                      }
                      final favoritos = snapshot.data!.docs
                          .where((doc) => doc['nome']
                              .toString()
                              .toLowerCase()
                              .contains(filtroPesquisa))
                          .toList();

                      if (favoritos.isEmpty) {
                        return const Text('Nenhum favorito ainda.');
                      }

                      return Column(
                        children: favoritos.map((contato) {
                          return _buildContatoCard(contato, true);
                        }).toList(),
                      );
                    },
                  ),

                  const SizedBox(height: 20),
                  const Divider(),
                  const Text(
                    'Seus Contatos',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(height: 8),

                  // 👤 Lista de contatos normais
                  StreamBuilder<QuerySnapshot>(
                    stream: contatosRef
                        .where('uid', isEqualTo: usuario?.uid)
                        .where('favorito', isEqualTo: false)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return const Text('Erro ao carregar contatos');
                      }
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                            child: CircularProgressIndicator());
                      }

                      final docs = snapshot.data!.docs
                          .where((doc) => doc['nome']
                              .toString()
                              .toLowerCase()
                              .contains(filtroPesquisa))
                          .toList();

                      if (docs.isEmpty) {
                        return const Padding(
                          padding: EdgeInsets.all(16),
                          child: Text(
                            'Nenhum contato adicionado ainda.',
                            style: TextStyle(color: Colors.black54),
                          ),
                        );
                      }

                      return Column(
                        children: docs.map((contato) {
                          return _buildContatoCard(contato, false);
                        }).toList(),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

      // 🔹 Botão flutuante menor e mais baixo
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: FloatingActionButton.extended(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Adicionar Contato'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: nomeController,
                      decoration: const InputDecoration(labelText: 'Nome'),
                    ),
                    TextField(
                      controller: numeroController,
                      decoration: const InputDecoration(labelText: 'Número'),
                      keyboardType: TextInputType.phone,
                    ),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cancelar'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _adicionarContato();
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF00897B),
                    ),
                    child: const Text('Salvar'),
                  ),
                ],
              ),
            );
          },
          label: const Text('Novo Contato'),
          icon: const Icon(Icons.add),
          backgroundColor: const Color(0xFF00897B),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _buildContatoCard(DocumentSnapshot contato, bool favorito) {
    return Card(
      color: Colors.green[50],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.green.shade100),
      ),
      child: ListTile(
        leading: const CircleAvatar(
          backgroundColor: Color(0xFF00897B),
          child: Icon(Icons.person, color: Colors.white),
        ),
        title: Text(
          contato['nome'],
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
        ),
        subtitle: Text(contato['numero']),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(
                contato['favorito'] == true
                    ? Icons.star
                    : Icons.star_border_outlined,
                color: contato['favorito'] == true
                    ? Colors.amber
                    : Colors.grey,
              ),
              onPressed: () => _alternarFavorito(contato),
            ),
            IconButton(
              icon: const Icon(Icons.edit, color: Colors.blueAccent),
              onPressed: () => _editarContato(contato),
            ),
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.redAccent),
              onPressed: () => _excluirContato(contato),
            ),
            IconButton(
              icon: const Icon(Icons.call, color: Color(0xFF00897B)),
              onPressed: () => _ligar(contato['numero']),
            ),
          ],
        ),
      ),
    );
  }
}

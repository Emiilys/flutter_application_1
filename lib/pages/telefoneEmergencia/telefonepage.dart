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
    final data = contato.data() as Map<String, dynamic>;
    final nomeEditController = TextEditingController(text: data['nome'] ?? '');
    final numeroEditController = TextEditingController(text: data['numero'] ?? '');

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Editar contato'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: nomeEditController, decoration: const InputDecoration(labelText: 'Nome')),
            TextField(controller: numeroEditController, decoration: const InputDecoration(labelText: 'Número'), keyboardType: TextInputType.phone),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancelar')),
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
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancelar')),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent, foregroundColor: Colors.white),
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
    final data = contato.data() as Map<String, dynamic>;
    final favoritoAtual = data['favorito'] ?? false;
    await firestore.collection('contatos').doc(contato.id).update({'favorito': !favoritoAtual});
  }

  void _ligar(String numero) async {
    final Uri uri = Uri(scheme: 'tel', path: numero);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Não foi possível ligar para $numero')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final usuario = auth.currentUser;
    final contatosRef = firestore.collection('contatos');

    final largura = MediaQuery.of(context).size.width;
    final altura = MediaQuery.of(context).size.height;
    final bool telaPequena = largura < 360;

    double fonteTitulo = telaPequena ? 18 : 22;
    double fonteSub = telaPequena ? 12 : 14;
    double paddingGeral = telaPequena ? 8 : 12;

    return Scaffold(
      backgroundColor: const Color(0xfffff5f2),

      appBar: PreferredSize(
        preferredSize: Size.fromHeight(telaPequena ? 110 : 140),
        child: AppBar(
          automaticallyImplyLeading: false,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [Color(0xFF00897B), Color(0xFF26A69A)], begin: Alignment.topLeft, end: Alignment.bottomRight),
            ),
            padding: EdgeInsets.only(top: altura * 0.045, left: 16, right: 16),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(children: [
                GestureDetector(onTap: () => Navigator.pop(context), child: const Icon(Icons.arrow_back, color: Colors.white)),
                const SizedBox(width: 12),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.white),
                  child: const Icon(Icons.phone, color: Color(0xFF00897B)),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Telefones de Emergência',
                    style: TextStyle(fontSize: fonteTitulo, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
              ]),
              const SizedBox(height: 6),
              Text(
                'Encontre e ligue rapidamente para serviços essenciais',
                style: TextStyle(fontSize: fonteSub, color: Colors.white70),
              ),
            ]),
          ),
        ),
      ),

      body: Padding(
        padding: EdgeInsets.only(bottom: 70, left: paddingGeral, right: paddingGeral),
        child: Column(
          children: [
            TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'Pesquisar por nome...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
              onChanged: (value) => setState(() => filtroPesquisa = value.toLowerCase()),
            ),
            const SizedBox(height: 12),

            Expanded(
              child: ListView(
                children: [
                  Text('Emergências Oficiais', style: TextStyle(fontWeight: FontWeight.bold, fontSize: telaPequena ? 14 : 16)),
                  const SizedBox(height: 8),

                  ...contatosFixos.map((c) => Card(
                        color: Colors.red[50],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                          side: BorderSide(color: Colors.red.shade100),
                        ),
                        child: ListTile(
                          leading: const CircleAvatar(backgroundColor: Colors.redAccent, child: Icon(Icons.local_phone, color: Colors.white)),
                          title: Text(
                            c['nome']!,
                            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red.shade700, fontSize: telaPequena ? 13 : 15),
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

                  Text('Favoritos ⭐', style: TextStyle(fontWeight: FontWeight.bold, fontSize: telaPequena ? 14 : 16)),
                  const SizedBox(height: 8),

                  if (usuario == null)
                    const Text('Faça login para ver seus contatos.'),
                  if (usuario != null)
                    StreamBuilder<QuerySnapshot>(
                      stream: contatosRef.where('uid', isEqualTo: usuario.uid).snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());

                        final favoritos = snapshot.data!.docs.where((d) {
                          final data = d.data() as Map<String, dynamic>;
                          return data['favorito'] == true &&
                              (data['nome'] ?? '').toString().toLowerCase().contains(filtroPesquisa);
                        }).toList();

                        if (favoritos.isEmpty) {
                          return const Text('Nenhum favorito ainda.');
                        }

                        return Column(
                          children: favoritos.map((c) => _buildContatoCard(c, telaPequena)).toList(),
                        );
                      },
                    ),

                  const SizedBox(height: 20),
                  const Divider(),

                  Text('Seus Contatos', style: TextStyle(fontWeight: FontWeight.bold, fontSize: telaPequena ? 14 : 16)),
                  const SizedBox(height: 8),

                  if (usuario != null)
                    StreamBuilder<QuerySnapshot>(
                      stream: contatosRef.where('uid', isEqualTo: usuario.uid).snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());

                        final docs = snapshot.data!.docs.where((d) {
                          final data = d.data() as Map<String, dynamic>;
                          return (data['favorito'] == false) &&
                              (data['nome'] ?? '').toString().toLowerCase().contains(filtroPesquisa);
                        }).toList();

                        if (docs.isEmpty) {
                          return const Text('Nenhum contato ainda.');
                        }

                        return Column(children: docs.map((c) => _buildContatoCard(c, telaPequena)).toList());
                      },
                    ),
                ],
              ),
            ),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Adicionar Contato'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(controller: nomeController, decoration: const InputDecoration(labelText: 'Nome')),
                  TextField(controller: numeroController, decoration: const InputDecoration(labelText: 'Número'), keyboardType: TextInputType.phone),
                ],
              ),
              actions: [
                TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancelar')),
                ElevatedButton(
                  onPressed: () {
                    _adicionarContato();
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF00897B)),
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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _buildContatoCard(DocumentSnapshot contato, bool telaPequena) {
    final data = contato.data() as Map<String, dynamic>;
    final nome = data['nome'] ?? '';
    final numero = data['numero'] ?? '';
    final favorito = data['favorito'] ?? false;

    return Card(
      color: Colors.green[50],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12), side: BorderSide(color: Colors.green.shade100)),
      child: ListTile(
        leading: const CircleAvatar(backgroundColor: Color(0xFF00897B), child: Icon(Icons.person, color: Colors.white)),
        title: Text(
          nome,
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: telaPequena ? 14 : 16),
        ),
        subtitle: Text(numero),
        trailing: Wrap(
          spacing: -6,
          children: [
            IconButton(icon: Icon(favorito ? Icons.star : Icons.star_border_outlined, color: favorito ? Colors.amber : Colors.grey), onPressed: () => _alternarFavorito(contato)),
            IconButton(icon: const Icon(Icons.edit, color: Colors.blueAccent), onPressed: () => _editarContato(contato)),
            IconButton(icon: const Icon(Icons.delete, color: Colors.redAccent), onPressed: () => _excluirContato(contato)),
            IconButton(icon: const Icon(Icons.call, color: Color(0xFF00897B)), onPressed: () => _ligar(numero)),
          ],
        ),
      ),
    );
  }
}

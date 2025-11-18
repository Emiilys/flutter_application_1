import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:firebase_auth/firebase_auth.dart';

class EnderecosPage extends StatefulWidget {
  const EnderecosPage({super.key});

  @override
  State<EnderecosPage> createState() => _EnderecosPageState();
}

class _EnderecosPageState extends State<EnderecosPage> {
  final categorias = [
    'Farmácia',
    'Hospital',
    'Pronto-Socorro',
    'Posto de Saúde',
    'Delegacia de Polícia',
    'Corpo de Bombeiro',
    'Centro de Assistência Social',
    'CAPS',
  ];

  String filtroCategoria = "Todas";
  List<Map<String, dynamic>> enderecosUsuario = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    carregarEnderecos();
  }

  Future<void> carregarEnderecos() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Usuário não logado')),
      );
      return;
    }
    final uid = user.uid;

    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('enderecos')
          .doc(uid)
          .collection('lista')
          .get();

      setState(() {
        enderecosUsuario = snapshot.docs.map((doc) {
          final data = doc.data();
          data['id'] = doc.id;
          return data;
        }).toList();
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao carregar endereços: $e')),
      );
    }
  }

  Future<void> adicionarEndereco() async {
    final nomeController = TextEditingController();
    final enderecoController = TextEditingController();
    final telefoneController = TextEditingController();
    String categoriaEscolhida = categorias[0];

    showDialog(
      context: context,
      builder: (_) => StatefulBuilder(
        builder: (context, setStateDialog) => AlertDialog(
          title: const Text("Novo Endereço"),
          content: SingleChildScrollView(
            child: Column(
              children: [
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(labelText: "Categoria"),
                  value: categoriaEscolhida,
                  items: categorias
                      .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                      .toList(),
                  onChanged: (v) => setStateDialog(() => categoriaEscolhida = v!),
                ),
                TextField(
                  controller: nomeController,
                  decoration: const InputDecoration(labelText: "Nome do local"),
                ),
                TextField(
                  controller: enderecoController,
                  decoration:
                      const InputDecoration(labelText: "Rua + Número"),
                ),
                TextField(
                  controller: telefoneController,
                  decoration: const InputDecoration(
                      labelText: "Telefone (somente números)"),
                  keyboardType: TextInputType.phone,
                ),
                if (_isLoading)
                  const Padding(
                    padding: EdgeInsets.only(top: 16),
                    child: CircularProgressIndicator(),
                  ),
              ],
            ),
          ),
          actions: [
            TextButton(
                onPressed: _isLoading ? null : () => Navigator.pop(context),
                child: const Text("Cancelar")),
            ElevatedButton(
              onPressed: _isLoading
                  ? null
                  : () async {
                      if (nomeController.text.trim().isEmpty ||
                          enderecoController.text.trim().isEmpty ||
                          telefoneController.text.trim().isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Preencha todos os campos')),
                        );
                        return;
                      }

                      final user = FirebaseAuth.instance.currentUser;
                      if (user == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Usuário não logado')),
                        );
                        return;
                      }

                      setStateDialog(() => _isLoading = true);

                      try {
                        final uid = user.uid;
                        final nomeFinal =
                            "${categoriaEscolhida} ${nomeController.text}".trim();

                        final data = {
                          "categoria": categoriaEscolhida,
                          "nome": nomeFinal,
                          "endereco": enderecoController.text,
                          "telefone": telefoneController.text,
                        };

                        final ref = await FirebaseFirestore.instance
                            .collection('enderecos')
                            .doc(uid)
                            .collection('lista')
                            .add(data);

                        setState(() {
                          enderecosUsuario.add({...data, "id": ref.id});
                        });

                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Endereço adicionado!')),
                        );
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Erro ao adicionar: $e')),
                        );
                      } finally {
                        setStateDialog(() => _isLoading = false);
                      }
                    },
              child: const Text("Salvar"),
            )
          ],
        ),
      ),
    );
  }

  Future<void> excluirEndereco(String id) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;
    final uid = user.uid;

    try {
      await FirebaseFirestore.instance
          .collection('enderecos')
          .doc(uid)
          .collection('lista')
          .doc(id)
          .delete();

      setState(() {
        enderecosUsuario.removeWhere((e) => e["id"] == id);
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao excluir: $e')),
      );
    }
  }

  Future<void> ligar(String numero) async {
    final uri = Uri(scheme: "tel", path: numero);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Não foi possível ligar')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final listaFiltrada = filtroCategoria == "Todas"
        ? enderecosUsuario
        : enderecosUsuario
            .where((e) => e["categoria"] == filtroCategoria)
            .toList();

    return Scaffold(
      backgroundColor: Colors.yellow[50],
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(140),
        child: AppBar(
          automaticallyImplyLeading: false,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFFFA000), Color(0xFFFFC107)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            padding: const EdgeInsets.only(top: 40, left: 16, right: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(Icons.arrow_back, color: Colors.white),
                    ),
                    const SizedBox(width: 12),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: const Icon(Icons.location_on, color: Colors.amber),
                    ),
                    const SizedBox(width: 12),
                    const Text(
                      'Endereços Importantes',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                const Text(
                  'Hospitais, farmácias e serviços essenciais',
                  style: TextStyle(color: Colors.white70),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Filtrar por categoria:",
                style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              children: [
                "Todas",
                ...categorias,
              ].map((cat) {
                final ativo = filtroCategoria == cat;
                return ChoiceChip(
                  label: Text(cat),
                  selected: ativo,
                  selectedColor: Colors.amber,
                  onSelected: (_) => setState(() => filtroCategoria = cat),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: listaFiltrada.length,
                itemBuilder: (_, i) {
                  final e = listaFiltrada[i];
                  return Card(
                    child: ListTile(
                      leading:
                          const Icon(Icons.location_on, color: Colors.amber),
                      title: Text(e["nome"]),
                      subtitle: Text("${e["endereco"]}\n${e["telefone"]}"),
                      isThreeLine: true,
                      trailing: PopupMenuButton(
                        onSelected: (value) {
                          if (value == "excluir") excluirEndereco(e["id"]);
                        },
                        itemBuilder: (_) => const [
                          PopupMenuItem(value: "excluir", child: Text("Excluir"))
                        ],
                      ),
                      onTap: () => ligar(e["telefone"]),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: adicionarEndereco,
        backgroundColor: Colors.amber[700],
        icon: const Icon(Icons.add, color: Colors.white),
        label:
            const Text("Novo Endereço", style: TextStyle(color: Colors.white)),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EnderecosPage extends StatefulWidget {
  const EnderecosPage({super.key});

  @override
  State<EnderecosPage> createState() => _EnderecosPageState();
}

class _EnderecosPageState extends State<EnderecosPage> {
  // Endereços fixos do sistema (não podem ser editados ou removidos)
  final List<Map<String, String>> enderecosFixos = [
    {
      'nome': 'Hospital Santa Maria',
      'categoria': 'Hospitais',
      'endereco': 'Rua das Flores, 123 - Centro',
      'telefone': '(11) 3333-4444'
    },
    {
      'nome': 'UPA Centro',
      'categoria': 'Prontos-socorros',
      'endereco': 'Avenida Central, 456',
      'telefone': '(11) 5555-6666'
    },
  ];

  // Categorias fixas
  final categorias = [
    'Todas',
    'Farmácias',
    'Hospitais',
    'Prontos-socorros',
    'Postos de saúde / UBS',
    'Delegacias de polícia',
    'Corpo de Bombeiros',
    'Centros de Assistência Social',
    'CAPS',
  ];

  String categoriaSelecionada = 'Todas';

  // Endereços do Firestore
  List<Map<String, dynamic>> enderecosUsuario = [];

  @override
  void initState() {
    super.initState();
    carregarEnderecos();
  }

  // Carregar endereços do Firestore
  void carregarEnderecos() async {
    final snapshot = await FirebaseFirestore.instance.collection('enderecos').get();
    final lista = snapshot.docs.map((doc) {
      final data = doc.data();
      data['id'] = doc.id; // guardando o ID para edição/exclusão
      return data;
    }).toList();

    setState(() => enderecosUsuario = lista);
  }

  // Adicionar endereço
  void adicionarEndereco(Map<String, String> novo) async {
    final docRef = await FirebaseFirestore.instance.collection('enderecos').add(novo);
    setState(() => enderecosUsuario.add({...novo, 'id': docRef.id}));
  }

  // Remover endereço
  void removerEndereco(int index) async {
    final docId = enderecosUsuario[index]['id'];
    await FirebaseFirestore.instance.collection('enderecos').doc(docId).delete();
    setState(() => enderecosUsuario.removeAt(index));
  }

  // Editar endereço
  void editarEndereco(int index, Map<String, String> atualizado) async {
    final docId = enderecosUsuario[index]['id'];
    await FirebaseFirestore.instance.collection('enderecos').doc(docId).update(atualizado);
    setState(() => enderecosUsuario[index] = {...atualizado, 'id': docId});
  }

  // Dialog para editar endereço
  void editarEnderecoDialog(int index) {
    final endereco = enderecosUsuario[index];
    final nomeController = TextEditingController(text: endereco['nome']);
    final enderecoController = TextEditingController(text: endereco['endereco']);
    final telefoneController = TextEditingController(text: endereco['telefone']);
    String categoriaAtual = endereco['categoria'];

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Editar Endereço'),
        content: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: nomeController,
                decoration: const InputDecoration(labelText: 'Nome'),
              ),
              TextField(
                controller: enderecoController,
                decoration: const InputDecoration(labelText: 'Endereço'),
              ),
              TextField(
                controller: telefoneController,
                decoration: const InputDecoration(labelText: 'Telefone'),
              ),
              DropdownButton<String>(
                value: categoriaAtual,
                items: categorias
                    .where((c) => c != 'Todas')
                    .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                    .toList(),
                onChanged: (value) {
                  if (value != null) setState(() => categoriaAtual = value);
                },
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              final atualizado = {
                'nome': nomeController.text,
                'endereco': enderecoController.text,
                'telefone': telefoneController.text,
                'categoria': categoriaAtual,
              };
              editarEndereco(index, atualizado);
              Navigator.pop(context);
            },
            child: const Text('Salvar'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Junta os fixos + os do Firestore
    final listaFiltrada = categoriaSelecionada == 'Todas'
        ? [...enderecosFixos, ...enderecosUsuario]
        : [
            ...enderecosFixos.where((e) => e['categoria'] == categoriaSelecionada),
            ...enderecosUsuario.where((e) => e['categoria'] == categoriaSelecionada),
          ];

    return Scaffold(
      backgroundColor: Colors.yellow[50],
      appBar: AppBar(
        title: const Text('Endereços Importantes'),
        backgroundColor: Colors.amber,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => adicionarEndereco({
              'nome': 'Novo Endereço',
              'categoria': 'Hospitais',
              'endereco': 'Rua Exemplo, 000',
              'telefone': '(11) 9999-9999'
            }),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('Categorias:', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: categorias.map((cat) {
              final selecionado = categoriaSelecionada == cat;
              return ChoiceChip(
                label: Text(cat),
                selected: selecionado,
                selectedColor: Colors.amber,
                backgroundColor: Colors.grey[200],
                labelStyle: TextStyle(
                  color: selecionado ? Colors.black : Colors.grey[800],
                  fontWeight: selecionado ? FontWeight.bold : FontWeight.normal,
                ),
                onSelected: (_) => setState(() => categoriaSelecionada = cat),
              );
            }).toList(),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: listaFiltrada.length,
              itemBuilder: (context, index) {
                final e = listaFiltrada[index];
                final isUsuario = enderecosUsuario.contains(e);

                return Card(
                  color: isUsuario ? Colors.white : Colors.grey[200],
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                    leading: const Icon(Icons.location_on, color: Colors.amber),
                    title: Text(e['nome']!),
                    subtitle: Text('${e['endereco']}\n${e['telefone']}'),
                    trailing: isUsuario
                        ? PopupMenuButton<String>(
                            onSelected: (value) {
                              final userIndex = enderecosUsuario.indexOf(e);
                              if (value == 'editar') editarEnderecoDialog(userIndex);
                              if (value == 'excluir') removerEndereco(userIndex);
                            },
                            itemBuilder: (context) => [
                              const PopupMenuItem(value: 'editar', child: Text('Editar')),
                              const PopupMenuItem(value: 'excluir', child: Text('Excluir')),
                            ],
                          )
                        : null,
                  ),
                );
              },
            ),
          ),
        ]),
      ),
    );
  }
}

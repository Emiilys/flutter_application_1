import 'package:flutter/material.dart';

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
      'categoria': 'UPA',
      'endereco': 'Avenida Central, 456',
      'telefone': '(11) 5555-6666'
    },
  ];

  // Endereços adicionados pelo usuário
  final List<Map<String, String>> enderecosUsuario = [];

  final categorias = [
    'Todas',
    'Hospitais',
    'UPA',
    'Clínicas',
    'Pediatria',
    'Geriatria',
    'Cardiologia'
  ];

  String categoriaSelecionada = 'Todas';

  void adicionarEndereco(Map<String, String> novo) {
    setState(() => enderecosUsuario.add(novo));
  }

  void removerEndereco(int index) {
    setState(() => enderecosUsuario.removeAt(index));
  }

  void editarEnderecoDialog(int index) {
    final endereco = enderecosUsuario[index];
    final nomeController = TextEditingController(text: endereco['nome']);
    final enderecoController = TextEditingController(text: endereco['endereco']);
    final telefoneController = TextEditingController(text: endereco['telefone']);
    String categoriaAtual = endereco['categoria']!;

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
              setState(() {
                enderecosUsuario[index] = {
                  'nome': nomeController.text,
                  'endereco': enderecoController.text,
                  'telefone': telefoneController.text,
                  'categoria': categoriaAtual,
                };
              });
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
    // Junta os fixos + os do usuário
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
            children: categorias.map((cat) {
              final selecionado = categoriaSelecionada == cat;
              return ChoiceChip(
                label: Text(cat),
                selected: selecionado,
                selectedColor: Colors.amber,
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
                              if (value == 'editar') editarEnderecoDialog(index - enderecosFixos.length);
                              if (value == 'excluir') removerEndereco(index - enderecosFixos.length);
                            },
                            itemBuilder: (context) => [
                              const PopupMenuItem(value: 'editar', child: Text('Editar')),
                              const PopupMenuItem(value: 'excluir', child: Text('Excluir')),
                            ],
                          )
                        : null, // Endereços fixos não têm opções
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

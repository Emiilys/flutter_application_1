import 'package:flutter/material.dart';

class TelefonePage extends StatefulWidget {
  const TelefonePage({super.key});

  @override
  State<TelefonePage> createState() => _TelefonePageState();
}

class _TelefonePageState extends State<TelefonePage> {
  // 🔹 Lista fixa de contatos oficiais
  final List<Map<String, String>> _contatosFixos = [
    {"nome": "SAMU", "numero": "192"},
    {"nome": "Bombeiros", "numero": "193"},
    {"nome": "Polícia Militar", "numero": "190"},
    {"nome": "Polícia Civil", "numero": "197"},
  ];

  // 🔹 Lista dinâmica (criada pelo usuário)
  final List<Map<String, String>> _contatosUsuario = [];

  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _numeroController = TextEditingController();

  void _adicionarOuEditarContato({Map<String, String>? contato}) {
    if (contato != null) {
      // Edição
      _nomeController.text = contato["nome"]!;
      _numeroController.text = contato["numero"]!;
    } else {
      _nomeController.clear();
      _numeroController.clear();
    }

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(contato == null ? 'Adicionar Contato' : 'Editar Contato'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _nomeController,
              decoration: const InputDecoration(labelText: 'Nome'),
            ),
            TextField(
              controller: _numeroController,
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
              final nome = _nomeController.text.trim();
              final numero = _numeroController.text.trim();

              if (nome.isEmpty || numero.isEmpty) return;

              setState(() {
                if (contato == null) {
                  _contatosUsuario.add({"nome": nome, "numero": numero});
                } else {
                  contato["nome"] = nome;
                  contato["numero"] = numero;
                }
              });

              Navigator.pop(context);
            },
            child: const Text('Salvar'),
          ),
        ],
      ),
    );
  }

  void _removerContato(Map<String, String> contato) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Excluir contato?'),
        content: Text('Tem certeza que deseja remover "${contato["nome"]}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() => _contatosUsuario.remove(contato));
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Excluir'),
          ),
        ],
      ),
    );
  }

  Widget _buildCard({
    required String nome,
    required String numero,
    required bool fixo,
    required Color corBorda,
    required Color corFundo,
  }) {
    return Card(
      color: corFundo,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(color: corBorda),
      ),
      child: ListTile(
        title: Text(
          nome,
          style: TextStyle(
            color: fixo ? Colors.red[700] : Colors.green[700],
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(numero),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (!fixo) ...[
              IconButton(
                icon: const Icon(Icons.edit, color: Colors.orange),
                onPressed: () =>
                    _adicionarOuEditarContato(contato: {"nome": nome, "numero": numero}),
              ),
              IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () =>
                    _removerContato({"nome": nome, "numero": numero}),
              ),
            ],
            IconButton(
              icon: Icon(Icons.phone, color: fixo ? Colors.red : Colors.green),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Ligando para $numero...')),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.red[600],
        title: const Text(
          'Telefones de Emergência',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _adicionarOuEditarContato(),
        label: const Text('Adicionar Contato'),
        icon: const Icon(Icons.add),
        backgroundColor: Colors.green,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Emergências Oficiais',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 10),
          ..._contatosFixos.map(
            (c) => _buildCard(
              nome: c["nome"]!,
              numero: c["numero"]!,
              fixo: true,
              corBorda: Colors.red[100]!,
              corFundo: Colors.red[50]!,
            ),
          ),
          const SizedBox(height: 25),
          const Text(
            'Contatos Adicionados',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 10),
          if (_contatosUsuario.isEmpty)
            const Text(
              'Nenhum contato adicionado ainda.',
              style: TextStyle(color: Colors.black54),
            ),
          ..._contatosUsuario.map(
            (c) => _buildCard(
              nome: c["nome"]!,
              numero: c["numero"]!,
              fixo: false,
              corBorda: Colors.green[100]!,
              corFundo: Colors.green[50]!,
            ),
          ),
        ],
      ),
    );
  }
}

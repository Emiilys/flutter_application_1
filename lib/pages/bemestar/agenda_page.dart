import 'package:flutter/material.dart';

class AgendaPage extends StatefulWidget {
  const AgendaPage({super.key});

  @override
  State<AgendaPage> createState() => _AgendaPageState();
}

class _AgendaPageState extends State<AgendaPage> {
  final TextEditingController _controller = TextEditingController();
  final List<String> compromissos = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Agenda')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: 'Novo compromisso',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  compromissos.add(_controller.text);
                  _controller.clear();
                });
              },
              child: const Text('Adicionar'),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: compromissos.length,
                itemBuilder: (_, i) => ListTile(
                  title: Text(compromissos[i]),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

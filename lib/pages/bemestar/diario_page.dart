import 'package:flutter/material.dart';

class DiarioPage extends StatefulWidget {
  const DiarioPage({super.key});

  @override
  State<DiarioPage> createState() => _DiarioPageState();
}

class _DiarioPageState extends State<DiarioPage> {
  final TextEditingController _controller = TextEditingController();
  final List<String> entradas = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Diário')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              maxLines: 4,
              decoration: const InputDecoration(
                labelText: 'Escreva seu dia',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  entradas.add(_controller.text);
                  _controller.clear();
                });
              },
              child: const Text('Salvar'),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: entradas.length,
                itemBuilder: (_, i) => Card(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Text(entradas[i]),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

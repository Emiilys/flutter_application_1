import 'package:flutter/material.dart';

class MetasPage extends StatefulWidget {
  const MetasPage({super.key});

  @override
  State<MetasPage> createState() => _MetasPageState();
}

class _MetasPageState extends State<MetasPage> {
  final TextEditingController _controller = TextEditingController();
  final List<String> metas = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Metas')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: 'Digite uma meta',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  metas.add(_controller.text);
                  _controller.clear();
                });
              },
              child: const Text('Adicionar'),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: metas.length,
                itemBuilder: (_, i) => ListTile(
                  title: Text(metas[i]),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

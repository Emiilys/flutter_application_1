import 'package:flutter/material.dart';

class HumorPage extends StatefulWidget {
  const HumorPage({super.key});

  @override
  State<HumorPage> createState() => _HumorPageState();
}

class _HumorPageState extends State<HumorPage> {
  String? humorSelecionado;
  final List<String> historico = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Humor')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text('Como você está se sentindo?', style: TextStyle(fontSize: 18)),
            const SizedBox(height: 12),
            Wrap(
              spacing: 10,
              children: [
                _moodButton('😄'),
                _moodButton('🙂'),
                _moodButton('😐'),
                _moodButton('😞'),
                _moodButton('😡'),
              ],
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: humorSelecionado == null
                  ? null
                  : () {
                      setState(() {
                        historico.add(humorSelecionado!);
                        humorSelecionado = null;
                      });
                    },
              child: const Text('Registrar'),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: historico.length,
                itemBuilder: (_, i) => ListTile(
                  leading: Text(historico[i], style: const TextStyle(fontSize: 22)),
                  title: Text('Registro ${i + 1}'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _moodButton(String emoji) {
    return GestureDetector(
      onTap: () => setState(() => humorSelecionado = emoji),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: humorSelecionado == emoji ? Colors.blue : Colors.grey,
            width: 2,
          ),
        ),
        child: Text(emoji, style: const TextStyle(fontSize: 28)),
      ),
    );
  }
}

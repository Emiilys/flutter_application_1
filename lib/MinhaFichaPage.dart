import 'package:flutter/material.dart';

class MinhaFichaPage extends StatelessWidget {
  final Map<String, String> usuarioLogado;

  const MinhaFichaPage({super.key, required this.usuarioLogado});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Minha Ficha"),
        backgroundColor: Colors.orange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            TextField(
              controller: TextEditingController(text: usuarioLogado['nome']),
              decoration: const InputDecoration(labelText: "Nome"),
              readOnly: true,
            ),
            TextField(
              controller: TextEditingController(text: usuarioLogado['email']),
              decoration: const InputDecoration(labelText: "Email"),
              readOnly: true,
            ),
            TextField(
              controller: TextEditingController(text: usuarioLogado['idade']),
              decoration: const InputDecoration(labelText: "Idade"),
              readOnly: true,
            ),
            // Adicione mais campos conforme sua ficha
          ],
        ),
      ),
    );
  }
}

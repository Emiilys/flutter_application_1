import 'package:flutter/material.dart';

class FichaOutraPessoaIdosoPage extends StatefulWidget {
  const FichaOutraPessoaIdosoPage({super.key});

  @override
  State<FichaOutraPessoaIdosoPage> createState() => _FichaOutraPessoaIdosoPageState();
}

class _FichaOutraPessoaIdosoPageState extends State<FichaOutraPessoaIdosoPage> {
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController idadeController = TextEditingController();
  final TextEditingController condicoesController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ficha do Idoso"),
        backgroundColor: Colors.green.shade400,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            TextField(
              controller: nomeController,
              decoration: const InputDecoration(labelText: "Nome do idoso"),
            ),
            TextField(
              controller: idadeController,
              decoration: const InputDecoration(labelText: "Idade"),
            ),
            TextField(
              controller: condicoesController,
              decoration: const InputDecoration(labelText: "Condições especiais"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                print("Nome: ${nomeController.text}");
                print("Idade: ${idadeController.text}");
                print("Condições: ${condicoesController.text}");
              },
              child: const Text("Salvar"),
            ),
          ],
        ),
      ),
    );
  }
}

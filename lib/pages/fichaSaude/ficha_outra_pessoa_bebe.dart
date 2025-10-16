import 'package:flutter/material.dart';

class FichaOutraPessoaBebePage extends StatefulWidget {
  const FichaOutraPessoaBebePage({super.key});

  @override
  State<FichaOutraPessoaBebePage> createState() => _FichaOutraPessoaBebePageState();
}

class _FichaOutraPessoaBebePageState extends State<FichaOutraPessoaBebePage> {
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController idadeController = TextEditingController();
  final TextEditingController pesoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ficha do Bebê"),
        backgroundColor: Colors.blue.shade400,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            TextField(
              controller: nomeController,
              decoration: const InputDecoration(labelText: "Nome do bebê"),
            ),
            TextField(
              controller: idadeController,
              decoration: const InputDecoration(labelText: "Idade (meses)"),
            ),
            TextField(
              controller: pesoController,
              decoration: const InputDecoration(labelText: "Peso (kg)"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                print("Nome: ${nomeController.text}");
                print("Idade: ${idadeController.text}");
                print("Peso: ${pesoController.text}");
              },
              child: const Text("Salvar"),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class FichaOutraPessoaPage extends StatefulWidget {
  const FichaOutraPessoaPage({super.key});

  @override
  State<FichaOutraPessoaPage> createState() => _FichaOutraPessoaPageState();
}

class _FichaOutraPessoaPageState extends State<FichaOutraPessoaPage> {
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController idadeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ficha para Outra Pessoa"),
        backgroundColor: Colors.orange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            TextField(
              controller: nomeController,
              decoration: const InputDecoration(labelText: "Nome"),
            ),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: "Email"),
            ),
            TextField(
              controller: idadeController,
              decoration: const InputDecoration(labelText: "Idade"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Aqui você pega os dados digitados
                print("Nome: ${nomeController.text}");
                print("Email: ${emailController.text}");
                print("Idade: ${idadeController.text}");
              },
              child: const Text("Salvar"),
            ),
          ],
        ),
      ),
    );
  }
}

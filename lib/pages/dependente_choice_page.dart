import 'package:flutter/material.dart';
import 'ficha_outra_pessoa_bebe.dart';
import 'ficha_outra_pessoa_idoso.dart';

class DependenteChoicePage extends StatelessWidget {
  const DependenteChoicePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ficha do Dependente"),
        backgroundColor: Colors.orange,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
                backgroundColor: Colors.blue.shade400,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const FichaOutraPessoaBebePage()),
                );
              },
              child: const Text("Ficha do Bebê"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
                backgroundColor: Colors.green.shade400,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const FichaOutraPessoaIdosoPage()),
                );
              },
              child: const Text("Ficha do Idoso"),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'minhafichapage.dart';
import 'fichaoutrapessoapage.dart';

class FichaPage extends StatelessWidget {
  const FichaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Ficha Personalizada",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.orange,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFFFF8E1), Color(0xFFFFF3E0)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "Tipo de Ficha",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                "Selecione o tipo de ficha para personalizar as informações",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),

              // Card 1 - Minha Ficha
              _buildFichaCard(
                context,
                color: Colors.green.shade400,
                icon: Icons.person_outline,
                title: "Minha Ficha",
                description:
                    "Ficha pessoal com suas informações de saúde e medicamentos",
              ),
              const SizedBox(height: 20),

              // Card 2 - Ficha para Outra Pessoa
              _buildFichaCard(
                context,
                color: Colors.blue.shade500,
                icon: Icons.group_outlined,
                title: "Ficha para Outra Pessoa",
                description:
                    "Ficha específica para cuidados de outra pessoa, medicamentos e condições especiais",
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFichaCard(
    BuildContext context, {
    required Color color,
    required IconData icon,
    required String title,
    required String description,
  }) {
    return GestureDetector(
      onTap: () {
  if (title == "Minha Ficha") {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => MinhaFichaPage(
          usuarioLogado: {
            'nome': 'Maria Clara',
            'email': 'maria@example.com',
            'idade': '22',
          },
        ),
      ),
    );
  } else {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const FichaOutraPessoaPage()),
    );
  }
},

      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundColor: color.withOpacity(0.15),
              child: Icon(icon, color: color, size: 36),
            ),
            const SizedBox(height: 16),
            Text(
              title,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              description,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.black54, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}

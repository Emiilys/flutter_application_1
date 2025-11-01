import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'minhafichapage.dart'; // ⬅️ importe sua tela "MinhaFichaPage"

class FichaPage extends StatelessWidget {
  final Map<String, String> usuarioLogado; // ⬅️ adiciona essa variável

  const FichaPage({super.key, required this.usuarioLogado}); // ⬅️ receba ela no construtor

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEFF3F9),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(140),
        child: AppBar(
          automaticallyImplyLeading: false,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF3A7BD5), Color(0xFF4A90E2)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            padding: const EdgeInsets.only(top: 40, left: 16, right: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
                    ),
                    const SizedBox(width: 12),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.white),
                      child: const Icon(Icons.article_outlined, color: Color(0xFF3A7BD5)),
                    ),
                    const SizedBox(width: 12),
                    Flexible(
                      child: Text(
                        'Ficha de Saúde',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          fontSize: 22,
                          color: Colors.white,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                const Text(
                  'Selecione a ficha para personalizar informações e sugestões',
                  style: TextStyle(fontSize: 14, color: Colors.white70),
                ),
              ],
            ),
          ),
        ),
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          child: Column(
            children: [
              // Card 1 - Minha Ficha
              _buildFichaCard(
                context: context,
                color: const Color(0xFF3A7BD5),
                icon: Icons.person_outline,
                title: "Minha Ficha",
                description:
                    "Acesse suas informações pessoais de saúde, medicamentos e condições médicas.",
              ),
              const SizedBox(height: 24),

              // Card 2 - Ficha para Idosos
              _buildFichaCard(
                context: context,
                color: const Color(0xFF4A90E2),
                icon: Icons.elderly_rounded,
                title: "Ficha para Idosos",
                description:
                    "Ficha específica para cuidados geriátricos, medicamentos e condições especiais.",
              ),
              const SizedBox(height: 24),

              // Card 3 - Ficha para Bebês
              _buildFichaCard(
                context: context,
                color: const Color(0xFF6EC6FF),
                icon: Icons.child_care_rounded,
                title: "Ficha para Bebês",
                description:
                    "Ficha específica para cuidados pediátricos, alergias e informações importantes.",
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFichaCard({
    required BuildContext context,
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
              builder: (context) => MinhaFichaPage(usuarioLogado: usuarioLogado),
            ),
          );
        }
        // você pode adicionar outras navegações aqui se quiser
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.blueGrey.withOpacity(0.1),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            CircleAvatar(
              radius: 34,
              backgroundColor: color.withOpacity(0.15),
              child: Icon(icon, color: color, size: 38),
            ),
            const SizedBox(height: 16),
            Text(
              title,
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: color,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              description,
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                color: Colors.blueGrey[600],
                fontSize: 14,
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FichaPage extends StatelessWidget {
  const FichaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEFF3F9),
      appBar: AppBar(
        backgroundColor: const Color(0xFF3A7BD5),
        centerTitle: true,
        elevation: 0,
        title: Text(
          "Ficha de Saúde",
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            fontSize: 22,
            color: Colors.white,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Tipo de Ficha",
                style: GoogleFonts.poppins(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF2B4C7E),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "Selecione o tipo de ficha para visualizar ou editar as informações de saúde.",
                style: GoogleFonts.poppins(
                  fontSize: 15,
                  color: Colors.blueGrey[600],
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),

              // Card 1 - Minha Ficha
              _buildFichaCard(
                color: const Color(0xFF3A7BD5),
                icon: Icons.person_outline,
                title: "Minha Ficha",
                description:
                    "Acesse suas informações pessoais de saúde, medicamentos e condições médicas.",
              ),
              const SizedBox(height: 24),

              // Card 2 - Ficha para Idosos
              _buildFichaCard(
                color: const Color(0xFF4A90E2),
                icon: Icons.elderly_rounded,
                title: "Ficha para Idosos",
                description:
                    "Ficha específica para cuidados geriátricos, medicamentos e condições especiais.",
              ),
              const SizedBox(height: 24),

              // Card 3 - Ficha para Bebês
              _buildFichaCard(
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
    required Color color,
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Container(
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
    );
  }
}

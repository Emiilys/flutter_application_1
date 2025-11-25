import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LegendRow extends StatelessWidget {
  final List<MapEntry<Color, String>> items;

  const LegendRow({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Wrap(
        spacing: 16,
        runSpacing: 10,
        children: items
            .map(
              (item) => Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 14,
                    height: 14,
                    decoration: BoxDecoration(
                      color: item.key,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    item.value,
                    style: GoogleFonts.poppins(fontSize: 14),
                  ),
                ],
              ),
            )
            .toList(),
      ),
    );
  }
}

class ResponsiveProblemCard extends StatelessWidget {
  final String emoji;
  final String titulo;
  final Color corFundo;
  final Color corBorda;
  final String tipoGravidade;
  final List<String> instrucoesFazer;
  final List<String> instrucoesNaoFazer;
  final String? descricaoExtra;

  const ResponsiveProblemCard({
    super.key,
    required this.emoji,
    required this.titulo,
    required this.corFundo,
    required this.corBorda,
    required this.tipoGravidade,
    required this.instrucoesFazer,
    required this.instrucoesNaoFazer,
    this.descricaoExtra,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: corFundo,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: corBorda, width: 2),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: Offset(0, 3),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Título + emoji
          Row(
            children: [
              Text(
                emoji,
                style: const TextStyle(fontSize: 32),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  titulo,
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          // Gravidade
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: corBorda.withOpacity(0.15),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              "Gravidade: $tipoGravidade",
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: corBorda,
              ),
            ),
          ),

          const SizedBox(height: 16),

          // O que fazer
          Text(
            "O que fazer:",
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6),
          ...instrucoesFazer.map(
            (item) => Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("• "),
                  Expanded(
                    child: Text(
                      item,
                      style: GoogleFonts.poppins(fontSize: 14),
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),

          // O que NÃO fazer
          Text(
            "O que NÃO fazer:",
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6),
          ...instrucoesNaoFazer.map(
            (item) => Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("✘ ", style: TextStyle(color: Colors.red)),
                  Expanded(
                    child: Text(
                      item,
                      style: GoogleFonts.poppins(fontSize: 14),
                    ),
                  ),
                ],
              ),
            ),
          ),

          if (descricaoExtra != null) ...[
            const SizedBox(height: 16),
            Text(
              descricaoExtra!,
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: Colors.black87,
              ),
            )
          ],
        ],
      ),
    );
  }
}

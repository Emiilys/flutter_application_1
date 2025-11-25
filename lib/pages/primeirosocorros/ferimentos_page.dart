import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// ---------------------------------------------------------------------------
///  LEGENDA — NÃO PRECISA DE PARÂMETROS
/// ---------------------------------------------------------------------------
class FerimentosLegenda extends StatelessWidget {
  const FerimentosLegenda({super.key});

  @override
  Widget build(BuildContext context) {
    const legendItems = [
      MapEntry(Colors.red, "Grave"),
      MapEntry(Colors.orange, "Moderado"),
      MapEntry(Colors.green, "Leve"),
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: legendItems
            .map(
              (item) => Row(
                children: [
                  Container(
                    width: 18,
                    height: 18,
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

/// ---------------------------------------------------------------------------
///  CARD DE PROBLEMA — COMPATÍVEL COM SEU LAYOUT FINAL
/// ---------------------------------------------------------------------------
class ResponsiveProblemCard extends StatelessWidget {
  final String emoji;
  final String titulo;
  final String tipoGravidade;
  final Color corFundo;
  final Color corBorda;

  final List<String> instrucoesFazer;
  final List<String> instrucoesNaoFazer;
  final String? descricaoExtra;

  const ResponsiveProblemCard({
    super.key,
    required this.emoji,
    required this.titulo,
    required this.tipoGravidade,
    required this.corFundo,
    required this.corBorda,
    required this.instrucoesFazer,
    required this.instrucoesNaoFazer,
    this.descricaoExtra,
  });

  @override
  Widget build(BuildContext context) {
    final largura = MediaQuery.of(context).size.width;
    final bool layoutHorizontal = largura > 650;

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: corFundo,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: corBorda, width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // título + emoji
          Row(
            children: [
              Text(emoji, style: const TextStyle(fontSize: 32)),
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

          // gravidade
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: corBorda.withOpacity(0.3),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              "Gravidade: $tipoGravidade",
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),

          const SizedBox(height: 16),

          // layout horizontal para tablets
          layoutHorizontal
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: _buildList("O que fazer", instrucoesFazer)),
                    const SizedBox(width: 16),
                    Expanded(child: _buildList("O que NÃO fazer", instrucoesNaoFazer)),
                  ],
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildList("O que fazer", instrucoesFazer),
                    const SizedBox(height: 16),
                    _buildList("O que NÃO fazer", instrucoesNaoFazer),
                  ],
                ),

          // descrição extra
          if (descricaoExtra != null) ...[
            const SizedBox(height: 16),
            Text(
              descricaoExtra!,
              style: GoogleFonts.poppins(fontSize: 15),
            ),
          ],
        ],
      ),
    );
  }

  /// bloco interno para criar listas
  Widget _buildList(String titulo, List<String> itens) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          titulo,
          style: GoogleFonts.poppins(
            fontSize: 17,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 6),
        ...itens.map(
          (i) => Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("• ", style: TextStyle(fontSize: 16)),
                Expanded(
                  child: Text(
                    i,
                    style: GoogleFonts.poppins(fontSize: 15),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

/// ---------------------------------------------------------------------------
///  PÁGINA PRINCIPAL — SEM “items”, PRONTA PARA USAR
/// ---------------------------------------------------------------------------
class FerimentosPage extends StatelessWidget {
  const FerimentosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Primeiros Socorros - Ferimentos",
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),

      body: ListView(
        children: const [
          FerimentosLegenda(),

          // EXEMPLO DE CARD – coloque os seus casos reais aqui:

          ResponsiveProblemCard(
            emoji: "🩸",
            titulo: "Corte Profundo",
            tipoGravidade: "Grave",
            corFundo: Color(0xFFFFE5E5),
            corBorda: Colors.red,
            instrucoesFazer: [
              "Pressionar o local com pano limpo.",
              "Manter o membro elevado.",
              "Procurar atendimento médico urgente.",
            ],
            instrucoesNaoFazer: [
              "Não remover objetos enfiados.",
              "Não usar algodão diretamente no ferimento.",
            ],
          ),

          ResponsiveProblemCard(
            emoji: "🔥",
            titulo: "Queimadura Leve",
            tipoGravidade: "Leve",
            corFundo: Color(0xFFE8FCE8),
            corBorda: Colors.green,
            instrucoesFazer: [
              "Lavar com água corrente fria por 10 minutos.",
              "Cobrir com gaze esterilizada.",
            ],
            instrucoesNaoFazer: [
              "Não estourar bolhas.",
              "Não passar pasta de dente, manteiga ou óleo.",
            ],
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RespiracaoAnsiedadePage extends StatelessWidget {
  const RespiracaoAnsiedadePage({Key? key}) : super(key: key);

  Widget buildProblemCard({
    required String emoji,
    required String titulo,
    required Color corFundo,
    required Color corBorda,
    required String tipoGravidade,
    required List<String> instrucoesFazer,
    required List<String> instrucoesNaoFazer,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Container(
        decoration: BoxDecoration(
          color: corFundo,
          border: Border.all(color: corBorda, width: 1.4),
          borderRadius: BorderRadius.circular(14),
          boxShadow: const [
            BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2))
          ],
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Cabeçalho
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(emoji, style: const TextStyle(fontSize: 32)),
                    const SizedBox(width: 10),
                    Text(
                      titulo,
                      style: GoogleFonts.poppins(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Container(
                  decoration: BoxDecoration(
                    color: corBorda,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.black26,
                          blurRadius: 3,
                          offset: Offset(1, 2))
                    ],
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  child: Text(
                    tipoGravidade,
                    style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 13),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),

            // Conteúdo
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // O que fazer
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('✅ O que fazer:',
                          style: GoogleFonts.poppins(
                              color: Colors.green[900],
                              fontWeight: FontWeight.bold,
                              fontSize: 16)),
                      const SizedBox(height: 6),
                      for (int i = 0; i < instrucoesFazer.length; i++)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 6),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CircleAvatar(
                                radius: 10,
                                backgroundColor: Colors.green[200],
                                child: Text('${i + 1}',
                                    style: GoogleFonts.poppins(
                                        fontSize: 12,
                                        color: Colors.green[900],
                                        fontWeight: FontWeight.bold)),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                  child: Text(instrucoesFazer[i],
                                      style: GoogleFonts.poppins(fontSize: 14))),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
                const SizedBox(width: 20),
                // O que NÃO fazer
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('❌ O que NÃO fazer:',
                          style: GoogleFonts.poppins(
                              color: Colors.red[900],
                              fontWeight: FontWeight.bold,
                              fontSize: 16)),
                      const SizedBox(height: 6),
                      for (final item in instrucoesNaoFazer)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 6),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const CircleAvatar(
                                  radius: 10,
                                  backgroundColor: Color(0xFFFFCDD2),
                                  child: Icon(Icons.close,
                                      size: 12, color: Colors.redAccent)),
                              const SizedBox(width: 8),
                              Expanded(
                                  child: Text(item,
                                      style: GoogleFonts.poppins(fontSize: 14))),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget legenda() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: const [
              BoxShadow(color: Colors.black12, blurRadius: 5, offset: Offset(0, 2)),
            ]),
        padding: const EdgeInsets.all(12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: const [
            _LegendaCor(cor: Colors.blue, texto: 'Leve'),
            _LegendaCor(cor: Colors.green, texto: 'Moderado'),
            _LegendaCor(cor: Colors.orange, texto: 'Grave'),
            _LegendaCor(cor: Colors.red, texto: 'Crítico'),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2FAFF),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Cabeçalho
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 32),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                    colors: [Color(0xFF1976D2), Color(0xFF42A5F5)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter),
                boxShadow: [
                  BoxShadow(color: Colors.black26, blurRadius: 6, offset: Offset(0, 3))
                ],
              ),
              child: Row(
                children: [
                  IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () => Navigator.pop(context)),
                  const SizedBox(width: 6),
                  const Icon(Icons.air, color: Colors.white, size: 36),
                  const SizedBox(width: 10),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Respiração & Ansiedade',
                            style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold)),
                        Text('Técnicas, guias e primeiros socorros',
                            style: GoogleFonts.poppins(
                                color: Colors.white70, fontSize: 13)),
                      ]),
                ],
              ),
            ),

            // Legenda
            legenda(),

            // Bloco branco — lembrete
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: const [
                    BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 3))
                  ],
                ),
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                child: Column(
                  children: [
                    Text("Para se acalmar 🌿",
                        style: GoogleFonts.poppins(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Text(
                      "Tente a técnica de respiração 4-4-4:\nInspire por 4 segundos, segure por 4 segundos e expire por 4 segundos. "
                      "Repita até sentir o corpo relaxar.",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Lista de problemas
            const Divider(thickness: 2),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text("Situações relacionadas (Respiração & Ansiedade)",
                    style: GoogleFonts.poppins(
                        fontSize: 18, fontWeight: FontWeight.bold)),
              ),
            ),
            const SizedBox(height: 8),

            // Engasgo
            buildProblemCard(
              emoji: '🤐',
              titulo: 'Engasgo (Manobra de Heimlich)',
              corFundo: const Color(0xFFFFE5E5),
              corBorda: Colors.redAccent,
              tipoGravidade: 'CRÍTICO',
              instrucoesFazer: const [
                'Se a pessoa não consegue tossir, aplique a manobra de Heimlich.',
                'Peça para a vítima tentar tossir se conseguir.',
                'Se inconsciente, inicie reanimação e chame o socorro (192).',
              ],
              instrucoesNaoFazer: const [
                'Não dê tapas nas costas se a pessoa estiver consciente com obstrução completa sem orientação.',
                'Não coloque os dedos na garganta sem visão clara do objeto.',
                'Não deixe a pessoa sozinha se estiver engasgada.',
              ],
            ),

            // Ansiedade
            buildProblemCard(
              emoji: '😰',
              titulo: 'Crise de Ansiedade',
              corFundo: const Color(0xFFFFF7E0),
              corBorda: Colors.orangeAccent,
              tipoGravidade: 'GRAVE',
              instrucoesFazer: const [
                'Leve a pessoa a um local calmo e ventilado.',
                'Oriente a técnica 4-4-4 (respiração guiada).',
                'Ofereça apoio verbal e mantenha a calma.',
              ],
              instrucoesNaoFazer: const [
                'Não minimize os sentimentos da pessoa.',
                'Não force respirações rápidas.',
                'Não a deixe sozinha se estiver muito agitada.',
              ],
            ),

            // Hiperventilação
            buildProblemCard(
              emoji: '💨',
              titulo: 'Hiperventilação',
              corFundo: const Color(0xFFFFF0E0),
              corBorda: Colors.deepOrange,
              tipoGravidade: 'GRAVE',
              instrucoesFazer: const [
                'Oriente respirações lentas e controladas (4-4-4).',
                'Respirar pelo nariz e soltar o ar pela boca lentamente.',
                'Sente a pessoa e observe se melhora.',
              ],
              instrucoesNaoFazer: const [
                'Não ofereça um saco plástico sem orientação médica.',
                'Não incentive respirações rápidas.',
                'Não ignore sinais de fraqueza ou desmaio.',
              ],
            ),

            // Desmaios leves
            buildProblemCard(
              emoji: '😵',
              titulo: 'Desmaios leves / Tontura',
              corFundo: const Color(0xFFE7F4E4),
              corBorda: Colors.green,
              tipoGravidade: 'MODERADO',
              instrucoesFazer: const [
                'Deite a pessoa e eleve as pernas.',
                'Afrouxe roupas e mantenha o ambiente ventilado.',
                'Chame ajuda se não melhorar em poucos minutos.',
              ],
              instrucoesNaoFazer: const [
                'Não dê nada para beber se estiver inconsciente.',
                'Não deixe sozinha enquanto estiver tonta.',
                'Não force a se levantar rapidamente.',
              ],
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}

class _LegendaCor extends StatelessWidget {
  final Color cor;
  final String texto;
  const _LegendaCor({required this.cor, required this.texto});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(radius: 8, backgroundColor: cor),
        const SizedBox(width: 6),
        Text(texto,
            style:
                GoogleFonts.poppins(fontSize: 14, color: Colors.black87)),
      ],
    );
  }
}

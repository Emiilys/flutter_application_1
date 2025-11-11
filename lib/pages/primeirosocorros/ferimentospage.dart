import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FerimentosPage extends StatelessWidget {
  const FerimentosPage({Key? key}) : super(key: key);

  Widget buildProblemCard({
    required String emoji,
    required String titulo,
    required Color corFundo,
    required Color corBorda,
    required String tipoGravidade,
    required List<String> instrucoesFazer,
    required List<String> instrucoesNaoFazer,
    String? descricaoExtra,
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

            // O que fazer e não fazer
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

            // Descrição extra (opcional)
            if (descricaoExtra != null) ...[
              const SizedBox(height: 12),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: corBorda.withOpacity(0.6)),
                ),
                padding: const EdgeInsets.all(12),
                child: Text(
                  descricaoExtra,
                  textAlign: TextAlign.left,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Colors.black87,
                  ),
                ),
              ),
            ],
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
      backgroundColor: const Color(0xFFFFF9F0),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Cabeçalho
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 32),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                    colors: [Color(0xFFD84315), Color(0xFFFF7043)],
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
                  const Icon(Icons.healing, color: Colors.white, size: 36),
                  const SizedBox(width: 10),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Ferimentos & Cuidados',
                            style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold)),
                        Text('Primeiros socorros e observações visuais',
                            style: GoogleFonts.poppins(
                                color: Colors.white70, fontSize: 13)),
                      ]),
                ],
              ),
            ),

            // Legenda
            legenda(),

            const SizedBox(height: 8),

            // Título geral
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text("Situações relacionadas (Ferimentos & Cuidados)",
                    style: GoogleFonts.poppins(
                        fontSize: 18, fontWeight: FontWeight.bold)),
              ),
            ),
            const SizedBox(height: 8),

            // Ferimentos profundos
            buildProblemCard(
              emoji: '🩸',
              titulo: 'Ferimentos Profundos',
              corFundo: const Color(0xFFFFE5E5),
              corBorda: Colors.redAccent,
              tipoGravidade: 'CRÍTICO',
              instrucoesFazer: const [
                'Comprima o local com pano limpo para conter o sangramento.',
                'Eleve o membro, se possível.',
                'Procure socorro imediatamente (192).',
              ],
              instrucoesNaoFazer: const [
                'Não retire objetos presos à ferida.',
                'Não aplique pó, álcool ou pomadas.',
                'Não lave ferimentos muito profundos.',
              ],
            ),

            // Queimaduras leves
            buildProblemCard(
              emoji: '🔥',
              titulo: 'Queimaduras Leves',
              corFundo: const Color(0xFFFFF3E0),
              corBorda: Colors.orangeAccent,
              tipoGravidade: 'MODERADO',
              instrucoesFazer: const [
                'Lave a área com água corrente fria por 10 minutos.',
                'Cubra com pano limpo e seco.',
                'Se doer muito, procure um posto de saúde.',
              ],
              instrucoesNaoFazer: const [
                'Não estoure bolhas.',
                'Não aplique pasta de dente, manteiga ou óleos.',
                'Não cubra com algodão ou curativos grudantes.',
              ],
            ),

            // Fratura
            buildProblemCard(
              emoji: '🦴',
              titulo: 'Fratura (Suspeita ou Confirmada)',
              corFundo: const Color(0xFFE3F2FD),
              corBorda: Colors.blueAccent,
              tipoGravidade: 'GRAVE',
              instrucoesFazer: const [
                'Imobilize a área sem tentar alinhar o osso.',
                'Use uma tábua, revista ou pano dobrado para estabilizar.',
                'Procure atendimento médico urgente.',
              ],
              instrucoesNaoFazer: const [
                'Não tente “colocar o osso no lugar”.',
                'Não movimente o membro desnecessariamente.',
                'Não ignore se houver deformação ou dor intensa.',
              ],
            ),

            // Batidas e hematomas + descrição colorida
            buildProblemCard(
              emoji: '🤕',
              titulo: 'Batidas e Hematomas',
              corFundo: const Color(0xFFE8F5E9),
              corBorda: Colors.green,
              tipoGravidade: 'LEVE',
              instrucoesFazer: const [
                'Aplique compressa fria nas primeiras 24h.',
                'Após 2 dias, use compressas mornas para ajudar na absorção.',
                'Observe a mudança da cor conforme a recuperação.',
              ],
              instrucoesNaoFazer: const [
                'Não massageie o local logo após a batida.',
                'Não aplique pomadas sem orientação médica.',
                'Não ignore se o inchaço aumentar ou houver dor intensa.',
              ],
              descricaoExtra:
                  "🩹 Cores dos hematomas e o que indicam:\n\n"
                  "🟣 Roxo ou azul-escuro → Hematoma recente (1º a 3º dia).\n"
                  "🟢 Esverdeado → Cicatrização intermediária (4º a 7º dia).\n"
                  "🟡 Amarelado → Fase final de cura (após o 7º dia).\n\n"
                  "⚠️ Se houver aumento de dor, calor local ou endurecimento, procure atendimento médico.",
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
            style: GoogleFonts.poppins(fontSize: 14, color: Colors.black87)),
      ],
    );
  }
}

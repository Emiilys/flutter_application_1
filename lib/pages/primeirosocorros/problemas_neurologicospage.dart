import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProblemasNeurologicosPage extends StatelessWidget {
  const ProblemasNeurologicosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Cabeçalho
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF7B1FA2), Color(0xFF6A1B9A)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 6,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const Icon(Icons.psychology, color: Colors.white, size: 40),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Problemas Neurológicos',
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Guias específicos para esta categoria',
                        style: GoogleFonts.poppins(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Legenda
            Padding(
              padding: const EdgeInsets.all(16),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 5,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
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
            ),

            // ----- CONVULSÃO -----
            _ProblemaCard(
              emoji: '🧠',
              titulo: 'Convulsão',
              corFundo: const Color(0xFFFFEAEA),
              corBorda: Colors.redAccent,
              tipoGravidade: 'ALTO',
              instrucoesFazer: const [
                'Proteja a cabeça da pessoa.',
                'Afaste objetos perigosos ao redor.',
                'Deixe a pessoa de lado após parar a convulsão.',
                'Cronometre a duração da crise.',
              ],
              instrucoesNaoFazer: const [
                'Não segure a pessoa.',
                'Não coloque nada na boca.',
                'Não jogue água.',
              ],
            ),

            // ----- DESMAIO -----
            _ProblemaCard(
              emoji: '😵‍💫',
              titulo: 'Desmaio',
              corFundo: const Color(0xFFFFF8E1),
              corBorda: Colors.orange,
              tipoGravidade: 'MÉDIO',
              instrucoesFazer: const [
                'Deite a pessoa e eleve as pernas.',
                'Afrouxe roupas apertadas.',
                'Ventile o ambiente.',
                'Verifique se a pessoa responde após 1 minuto.',
              ],
              instrucoesNaoFazer: const [
                'Não jogue água no rosto.',
                'Não dê nada para beber enquanto desacordada.',
                'Não balance a pessoa bruscamente.',
              ],
            ),

            // ----- AVC -----
            _ProblemaCard(
              emoji: '🩸',
              titulo: 'AVC (Acidente Vascular Cerebral)',
              corFundo: const Color(0xFFFFE0E0),
              corBorda: Colors.red,
              tipoGravidade: 'CRÍTICO',
              instrucoesFazer: const [
                'Ligue 192 imediatamente.',
                'Observe sinais como fala enrolada e fraqueza em um lado do corpo.',
                'Deixe a pessoa deitada de lado, cabeça ligeiramente elevada.',
              ],
              instrucoesNaoFazer: const [
                'Não ofereça alimentos ou líquidos.',
                'Não tente medicar sem orientação.',
                'Não ignore sintomas que desaparecem rapidamente.',
              ],
            ),

            // ----- ENXAQUECA INTENSA -----
            _ProblemaCard(
              emoji: '🤯',
              titulo: 'Enxaqueca Intensa',
              corFundo: const Color(0xFFE8F5E9),
              corBorda: Colors.green,
              tipoGravidade: 'MODERADO',
              instrucoesFazer: const [
                'Leve a pessoa a um ambiente escuro e silencioso.',
                'Ofereça água e mantenha o repouso.',
                'Aplique compressa fria na testa.',
              ],
              instrucoesNaoFazer: const [
                'Não exponha à luz forte ou barulhos.',
                'Não insista para que continue atividades.',
                'Não ofereça remédios sem orientação médica.',
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ------------------- WIDGETS AUXILIARES -------------------

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
        Text(
          texto,
          style: GoogleFonts.poppins(
            fontSize: 14,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }
}

class _ProblemaCard extends StatelessWidget {
  final String emoji;
  final String titulo;
  final Color corFundo;
  final Color corBorda;
  final String tipoGravidade;
  final List<String> instrucoesFazer;
  final List<String> instrucoesNaoFazer;

  const _ProblemaCard({
    required this.emoji,
    required this.titulo,
    required this.corFundo,
    required this.corBorda,
    required this.tipoGravidade,
    required this.instrucoesFazer,
    required this.instrucoesNaoFazer,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Container(
        decoration: BoxDecoration(
          color: corFundo,
          border: Border.all(color: corBorda, width: 1.4),
          borderRadius: BorderRadius.circular(14),
          boxShadow: const [
            BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2)),
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
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
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
                        offset: Offset(1, 2),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  child: Text(
                    tipoGravidade,
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),

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
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              radius: 10,
                              backgroundColor: Colors.green[200],
                              child: Text(
                                '${i + 1}',
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  color: Colors.green[900],
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                instrucoesFazer[i],
                                style: GoogleFonts.poppins(fontSize: 14),
                              ),
                            ),
                          ],
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
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const CircleAvatar(
                              radius: 10,
                              backgroundColor: Color(0xFFFFCDD2),
                              child: Icon(Icons.close,
                                  size: 12, color: Colors.redAccent),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                item,
                                style: GoogleFonts.poppins(fontSize: 14),
                              ),
                            ),
                          ],
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
}

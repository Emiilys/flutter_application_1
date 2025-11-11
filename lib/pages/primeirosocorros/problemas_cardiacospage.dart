import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProblemasCardiacosPage extends StatelessWidget {
  const ProblemasCardiacosPage({super.key});

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
                  colors: [Color(0xFFE53935), Color(0xFFD32F2F)],
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
                  const Icon(Icons.favorite, color: Colors.white, size: 40),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Problemas Cardíacos',
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

            // Cards existentes
            _ProblemaCard(
              emoji: '💔',
              titulo: 'Parada Cardíaca',
              corFundo: const Color(0xFFFFE5E5),
              corBorda: Colors.redAccent,
              tipoGravidade: 'CRÍTICO',
              instrucoesFazer: const [
                'Ligue 192 imediatamente',
                'Inicie massagem cardíaca',
                'Comprima o peito 30 vezes',
                'Faça 2 respirações',
              ],
              instrucoesNaoFazer: const [
                'Não dê água',
                'Não mova a pessoa desnecessariamente',
                'Não desista antes dos socorros chegarem',
              ],
            ),

            _ProblemaCard(
              emoji: '💖',
              titulo: 'Infarto',
              corFundo: const Color(0xFFFFF0E0),
              corBorda: Colors.deepOrange,
              tipoGravidade: 'GRAVE',
              instrucoesFazer: const [
                'Ligue 192 imediatamente',
                'Afrouxe roupas apertadas',
                'Deixe a pessoa confortável',
                'Permaneça calmo e monitore a respiração',
              ],
              instrucoesNaoFazer: const [
                'Não ofereça comida nem bebida',
                'Não deixe a pessoa sozinha',
                'Não ignore sintomas leves repetitivos',
              ],
            ),

            // --- Novos Problemas ---

            _ProblemaCard(
              emoji: '💨',
              titulo: 'Edema Agudo de Pulmão (EAP)',
              corFundo: const Color(0xFFFFE8E8),
              corBorda: Colors.redAccent,
              tipoGravidade: 'CRÍTICO',
              instrucoesFazer: const [
                'Ligue 192 imediatamente',
                'Deixe a pessoa sentada para facilitar a respiração',
                'Afrouxe roupas apertadas',
                'Mantenha a calma e evite que a pessoa deite',
              ],
              instrucoesNaoFazer: const [
                'Não deite a pessoa',
                'Não ofereça líquidos',
                'Não deixe a pessoa sozinha',
              ],
            ),

            _ProblemaCard(
              emoji: '🩸',
              titulo: 'Hipertensão Arterial',
              corFundo: const Color(0xFFE7F4E4),
              corBorda: Colors.green,
              tipoGravidade: 'MODERADO',
              instrucoesFazer: const [
                'Mantenha a pessoa em repouso',
                'Verifique se tomou medicação regular',
                'Acompanhe sintomas como dor de cabeça ou tontura',
              ],
              instrucoesNaoFazer: const [
                'Não ofereça remédios sem prescrição',
                'Não permita esforço físico',
                'Não ignore sintomas persistentes',
              ],
            ),

            _ProblemaCard(
              emoji: '💢',
              titulo: 'Angina de Peito',
              corFundo: const Color(0xFFFFF7E0),
              corBorda: Colors.orangeAccent,
              tipoGravidade: 'GRAVE',
              instrucoesFazer: const [
                'Faça a pessoa descansar imediatamente',
                'Afrouxe roupas apertadas',
                'Ligue 192 se a dor não passar em até 5 minutos',
              ],
              instrucoesNaoFazer: const [
                'Não deixe a pessoa sozinha',
                'Não ofereça comida ou bebida',
                'Não ignore dor torácica recorrente',
              ],
            ),

            _ProblemaCard(
              emoji: '💓',
              titulo: 'Taquicardia Leve',
              corFundo: const Color(0xFFE3F2FD),
              corBorda: Colors.blueAccent,
              tipoGravidade: 'LEVE',
              instrucoesFazer: const [
                'Peça para a pessoa respirar profundamente e devagar',
                'Afaste fatores de estresse',
                'Deixe a pessoa em ambiente ventilado',
              ],
              instrucoesNaoFazer: const [
                'Não provoque mais agitação',
                'Não ofereça estimulantes (café, energético)',
                'Não ignore se for recorrente — procure médico',
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

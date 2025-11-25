import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../widgets/responsive_widgets.dart';

class ProblemasNeurologicosPage extends StatelessWidget {
  const ProblemasNeurologicosPage({super.key});

  @override
  Widget build(BuildContext context) {
    final legend = const [
      MapEntry(Colors.blue, 'Leve'),
      MapEntry(Colors.green, 'Moderado'),
      MapEntry(Colors.orange, 'Grave'),
      MapEntry(Colors.red, 'Crítico'),
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              decoration: const BoxDecoration(
                gradient: LinearGradient(colors: [Color(0xFF7B1FA2), Color(0xFF6A1B9A)], begin: Alignment.topCenter, end: Alignment.bottomCenter),
                boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 6, offset: Offset(0, 3))],
              ),
              child: Row(children: [
                IconButton(icon: const Icon(Icons.arrow_back, color: Colors.white), onPressed: () => Navigator.pop(context)),
                const Icon(Icons.psychology, color: Colors.white, size: 40),
                const SizedBox(width: 10),
                Flexible(
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text('Problemas Neurológicos', style: GoogleFonts.poppins(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
                    Text('Guias específicos para esta categoria', style: GoogleFonts.poppins(color: Colors.white70, fontSize: 14)),
                  ]),
                ),
              ]),
            ),

            LegendRow(items: legend),

            ResponsiveProblemCard(
              emoji: '🧠',
              titulo: 'Convulsão',
              corFundo: const Color(0xFFFFEAEA),
              corBorda: Colors.redAccent,
              tipoGravidade: 'ALTO',
              instrucoesFazer: const ['Proteja a cabeça da pessoa.', 'Afaste objetos perigosos ao redor.', 'Deixe a pessoa de lado após parar a convulsão.', 'Cronometre a duração da crise.'],
              instrucoesNaoFazer: const ['Não segure a pessoa.', 'Não coloque nada na boca.', 'Não jogue água.'],
            ),

            ResponsiveProblemCard(
              emoji: '😵‍💫',
              titulo: 'Desmaio',
              corFundo: const Color(0xFFFFF8E1),
              corBorda: Colors.orange,
              tipoGravidade: 'MÉDIO',
              instrucoesFazer: const ['Deite a pessoa e eleve as pernas.', 'Afrouxe roupas apertadas.', 'Ventile o ambiente.', 'Verifique se a pessoa responde após 1 minuto.'],
              instrucoesNaoFazer: const ['Não jogue água no rosto.', 'Não dê nada para beber enquanto desacordada.', 'Não balance a pessoa bruscamente.'],
            ),

            ResponsiveProblemCard(
              emoji: '🩸',
              titulo: 'AVC (Acidente Vascular Cerebral)',
              corFundo: const Color(0xFFFFE0E0),
              corBorda: Colors.red,
              tipoGravidade: 'CRÍTICO',
              instrucoesFazer: const ['Ligue 192 imediatamente.', 'Observe sinais como fala enrolada e fraqueza em um lado do corpo.', 'Deixe a pessoa deitada de lado, cabeça ligeiramente elevada.'],
              instrucoesNaoFazer: const ['Não ofereça alimentos ou líquidos.', 'Não tente medicar sem orientação.', 'Não ignore sintomas que desaparecem rapidamente.'],
            ),

            ResponsiveProblemCard(
              emoji: '🤯',
              titulo: 'Enxaqueca Intensa',
              corFundo: const Color(0xFFE8F5E9),
              corBorda: Colors.green,
              tipoGravidade: 'MODERADO',
              instrucoesFazer: const ['Leve a pessoa a um ambiente escuro e silencioso.', 'Ofereça água e mantenha o repouso.', 'Aplique compressa fria na testa.'],
              instrucoesNaoFazer: const ['Não exponha à luz forte ou barulhos.', 'Não insista para que continue atividades.', 'Não ofereça remédios sem orientação médica.'],
            ),

            const SizedBox(height: 30),
          ]),
        ),
      ),
    );
  }
}

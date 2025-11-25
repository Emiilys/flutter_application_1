import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../widgets/responsive_widgets.dart';

class ProblemasCardiacosPage extends StatelessWidget {
  const ProblemasCardiacosPage({super.key});

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
                gradient: LinearGradient(colors: [Color(0xFFE53935), Color(0xFFD32F2F)], begin: Alignment.topCenter, end: Alignment.bottomCenter),
                boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 6, offset: Offset(0, 3))],
              ),
              child: Row(children: [
                IconButton(icon: const Icon(Icons.arrow_back, color: Colors.white), onPressed: () => Navigator.pop(context)),
                const Icon(Icons.favorite, color: Colors.white, size: 40),
                const SizedBox(width: 10),
                Flexible(
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text('Problemas Cardíacos', style: GoogleFonts.poppins(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
                    Text('Guias específicos para esta categoria', style: GoogleFonts.poppins(color: Colors.white70, fontSize: 14)),
                  ]),
                ),
              ]),
            ),

            LegendRow(items: legend),

            ResponsiveProblemCard(
              emoji: '💔',
              titulo: 'Parada Cardíaca',
              corFundo: const Color(0xFFFFE5E5),
              corBorda: Colors.redAccent,
              tipoGravidade: 'CRÍTICO',
              instrucoesFazer: const ['Ligue 192 imediatamente', 'Inicie massagem cardíaca', 'Comprima o peito 30 vezes', 'Faça 2 respirações'],
              instrucoesNaoFazer: const ['Não dê água', 'Não mova a pessoa desnecessariamente', 'Não desista antes dos socorros chegarem'],
            ),

            ResponsiveProblemCard(
              emoji: '💖',
              titulo: 'Infarto',
              corFundo: const Color(0xFFFFF0E0),
              corBorda: Colors.deepOrange,
              tipoGravidade: 'GRAVE',
              instrucoesFazer: const ['Ligue 192 imediatamente', 'Afrouxe roupas apertadas', 'Deixe a pessoa confortável', 'Permaneça calmo e monitore a respiração'],
              instrucoesNaoFazer: const ['Não ofereça comida nem bebida', 'Não deixe a pessoa sozinha', 'Não ignore sintomas leves repetitivos'],
            ),

            ResponsiveProblemCard(
              emoji: '💨',
              titulo: 'Edema Agudo de Pulmão (EAP)',
              corFundo: const Color(0xFFFFE8E8),
              corBorda: Colors.redAccent,
              tipoGravidade: 'CRÍTICO',
              instrucoesFazer: const ['Ligue 192 imediatamente', 'Deixe a pessoa sentada para facilitar a respiração', 'Afrouxe roupas apertadas', 'Mantenha a calma e evite que a pessoa deite'],
              instrucoesNaoFazer: const ['Não deite a pessoa', 'Não ofereça líquidos', 'Não deixe a pessoa sozinha'],
            ),

            ResponsiveProblemCard(
              emoji: '🩸',
              titulo: 'Hipertensão Arterial',
              corFundo: const Color(0xFFE7F4E4),
              corBorda: Colors.green,
              tipoGravidade: 'MODERADO',
              instrucoesFazer: const ['Mantenha a pessoa em repouso', 'Verifique se tomou medicação regular', 'Acompanhe sintomas como dor de cabeça ou tontura'],
              instrucoesNaoFazer: const ['Não ofereça remédios sem prescrição', 'Não permita esforço físico', 'Não ignore sintomas persistentes'],
            ),

            ResponsiveProblemCard(
              emoji: '💢',
              titulo: 'Angina de Peito',
              corFundo: const Color(0xFFFFF7E0),
              corBorda: Colors.orangeAccent,
              tipoGravidade: 'GRAVE',
              instrucoesFazer: const ['Faça a pessoa descansar imediatamente', 'Afrouxe roupas apertadas', 'Ligue 192 se a dor não passar em até 5 minutos'],
              instrucoesNaoFazer: const ['Não deixe a pessoa sozinha', 'Não ofereça comida ou bebida', 'Não ignore dor torácica recorrente'],
            ),

            ResponsiveProblemCard(
              emoji: '💓',
              titulo: 'Taquicardia Leve',
              corFundo: const Color(0xFFE3F2FD),
              corBorda: Colors.blueAccent,
              tipoGravidade: 'LEVE',
              instrucoesFazer: const ['Peça para a pessoa respirar profundamente e devagar', 'Afaste fatores de estresse', 'Deixe a pessoa em ambiente ventilado'],
              instrucoesNaoFazer: const ['Não provoque mais agitação', 'Não ofereça estimulantes (café, energético)', 'Não ignore se for recorrente — procure médico'],
            ),

            const SizedBox(height: 30),
          ]),
        ),
      ),
    );
  }
}

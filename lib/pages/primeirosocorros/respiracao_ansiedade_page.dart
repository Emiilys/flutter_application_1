// lib/pages/respiracao_ansiedadepage.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../widgets/responsive_widgets.dart';

class RespiracaoAnsiedadePage extends StatelessWidget {
  const RespiracaoAnsiedadePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final legend = const [
      MapEntry(Colors.blue, 'Leve'),
      MapEntry(Colors.green, 'Moderado'),
      MapEntry(Colors.orange, 'Grave'),
      MapEntry(Colors.red, 'Crítico'),
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF2FAFF),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // header
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF1976D2), Color(0xFF42A5F5)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 6, offset: Offset(0, 3))],
                ),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () => Navigator.pop(context),
                    ),
                    const SizedBox(width: 6),
                    const Icon(Icons.air, color: Colors.white, size: 36),
                    const SizedBox(width: 10),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Respiração & Ansiedade',
                              style: GoogleFonts.poppins(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                          Text('Técnicas, guias e primeiros socorros',
                              style: GoogleFonts.poppins(color: Colors.white70, fontSize: 13)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // legend
              LegendRow(items: legend),

              const SizedBox(height: 8),

              // reminder card (breathing technique)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 3))],
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
                  child: Column(
                    children: [
                      Text("Para se acalmar 🌿",
                          style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      Text(
                        "Tente a técnica de respiração 4-4-4:\nInspire por 4 segundos, segure por 4 segundos e expire por 4 segundos. Repita até sentir o corpo relaxar.",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 18),

              // section title
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Situações relacionadas (Respiração & Ansiedade)",
                      style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold)),
                ),
              ),

              const SizedBox(height: 8),

              // problems list (responsive cards)
              ResponsiveProblemCard(
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

              ResponsiveProblemCard(
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

              ResponsiveProblemCard(
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

              ResponsiveProblemCard(
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
      ),
    );
  }
}

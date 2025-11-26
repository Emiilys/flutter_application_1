import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../widgets/responsive_widgets.dart';

class FerimentosPage extends StatelessWidget {
  const FerimentosPage({super.key});

  @override
  Widget build(BuildContext context) {
    const legend = [
      MapEntry(Colors.red, 'Grave'),
      MapEntry(Colors.orange, 'Moderado'),
      MapEntry(Colors.green, 'Leve'),
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
            
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFFB71C1C), Color(0xFFD32F2F)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  boxShadow: [
                    BoxShadow(color: Colors.black26, blurRadius: 6, offset: Offset(0, 3)),
                  ],
                ),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () => Navigator.pop(context),
                    ),
                    const Icon(Icons.health_and_safety, color: Colors.white, size: 40),
                    const SizedBox(width: 10),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Primeiros Socorros - Ferimentos',
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Guias específicos para esta categoria',
                            style: GoogleFonts.poppins(color: Colors.white70, fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

            
              LegendRow(items: legend),

             

              ResponsiveProblemCard(
                emoji: "🩸",
                titulo: "Corte Profundo",
                tipoGravidade: "Grave",
                corFundo: const Color(0xFFFFE5E5),
                corBorda: Colors.red,
                instrucoesFazer: const [
                  "Pressionar o local com pano limpo.",
                  "Manter o membro elevado.",
                  "Procurar atendimento médico urgente.",
                ],
                instrucoesNaoFazer: const [
                  "Não remover objetos enfiados.",
                  "Não usar algodão diretamente no ferimento.",
                ],
              ),

              ResponsiveProblemCard(
                emoji: "🔥",
                titulo: "Queimadura Leve",
                tipoGravidade: "Leve",
                corFundo: const Color(0xFFE8FCE8),
                corBorda: Colors.green,
                instrucoesFazer: const [
                  "Lavar com água corrente fria por 10 minutos.",
                  "Cobrir com gaze esterilizada.",
                ],
                instrucoesNaoFazer: const [
                  "Não estourar bolhas.",
                  "Não passar pasta de dente, manteiga ou óleo.",
                ],
              ),

              ResponsiveProblemCard(
                emoji: "🩹",
                titulo: "Escoriação",
                tipoGravidade: "Leve",
                corFundo: const Color(0xFFE6FFEF),
                corBorda: Colors.green,
                instrucoesFazer: const [
                  "Lavar a área com água e sabão neutro.",
                  "Secar sem esfregar.",
                  "Aplicar pomada cicatrizante se necessário.",
                ],
                instrucoesNaoFazer: const [
                  "Não usar álcool diretamente.",
                  "Não arrancar casquinhas.",
                ],
              ),

              ResponsiveProblemCard(
                emoji: "🤕",
                titulo: "Hematoma / Contusão",
                tipoGravidade: "Moderado",
                corFundo: const Color(0xFFFFF3E0),
                corBorda: Colors.orange,
                instrucoesFazer: const [
                  "Aplicar gelo por 20 minutos.",
                  "Elevar a região afetada.",
                ],
                instrucoesNaoFazer: const [
                  "Não aplicar calor nas primeiras 48h.",
                ],
              ),

              ResponsiveProblemCard(
                emoji: "🦴",
                titulo: "Fratura",
                tipoGravidade: "Grave",
                corFundo: const Color(0xFFFFE5E5),
                corBorda: Colors.red,
                instrucoesFazer: const [
                  "Imobilizar o membro.",
                  "Manter a pessoa calma e imóvel.",
                  "Chamar ajuda médica imediatamente.",
                ],
                instrucoesNaoFazer: const [
                  "Não tentar colocar o osso no lugar.",
                  "Não mover o membro quebrado.",
                ],
              ),

              ResponsiveProblemCard(
                emoji: "⚠️",
                titulo: "Ferimento Profundo",
                tipoGravidade: "Grave",
                corFundo: const Color(0xFFFFE5E5),
                corBorda: Colors.red,
                instrucoesFazer: const [
                  "Controlar o sangramento com compressão.",
                  "Evitar contaminação.",
                ],
                instrucoesNaoFazer: const [
                  "Não remover objetos presos.",
                ],
                descricaoExtra:
                    "Ferimentos profundos podem atingir músculos, tendões e vasos importantes.",
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
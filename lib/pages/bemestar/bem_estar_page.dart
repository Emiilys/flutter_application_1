import 'package:flutter/material.dart';
import 'agenda_page.dart';
import 'diario_page.dart';
import 'humor_page.dart';
import 'metas_page.dart';

class BemEstarPage extends StatefulWidget {
  const BemEstarPage({Key? key}) : super(key: key);

  @override
  State<BemEstarPage> createState() => _BemEstarPageState();
}

class _BemEstarPageState extends State<BemEstarPage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = const [
    AgendaPage(),
    DiarioPage(),
    HumorPage(),
    MetasPage(),
  ];

  final List<String> _titles = [
    "Agenda do Dia",
    "Diário Pessoal",
    "Humor",
    "Metas"
  ];

  final List<String> _tabs = [
    "Agenda",
    "Humor",
    "Diário",
    "Metas",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF00C27D),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(140),
        child: AppBar(
          automaticallyImplyLeading: false,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF00C27D), Color(0xFF00E48C)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            padding: const EdgeInsets.only(top: 40, left: 16, right: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
                    ),
                    const SizedBox(width: 12),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: const Icon(Icons.favorite, color: Color(0xFF00C27D)),
                    ),
                    const SizedBox(width: 12),
                    Flexible(
                      child: Text(
                        'Bem Estar',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                          color: Colors.white,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                const Text(
                  'Monitore seu bem-estar e dia a dia',
                  style: TextStyle(fontSize: 14, color: Colors.white70),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          // 🔹 Barra de abas similar ao primeiro código
          Container(
            color: Colors.transparent,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(_tabs.length, (index) {
                return GestureDetector(
                  onTap: () => setState(() => _selectedIndex = index),
                  child: Text(
                    _tabs[index],
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: _selectedIndex == index ? FontWeight.bold : FontWeight.normal,
                      fontSize: 16,
                    ),
                  ),
                );
              }),
            ),
          ),

          // 🔹 Conteúdo principal com fundo arredondado
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: Color(0xFFEFFAF3),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
              ),
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // 🔹 Título e data igual ao primeiro código
                  Text(
                    _titles[_selectedIndex],
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.grey[800],
                    ),
                  ),
                  const SizedBox(height: 4),
                  const SizedBox(height: 16),

                  // 🔹 Página selecionada
                  Expanded(child: _pages[_selectedIndex]),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

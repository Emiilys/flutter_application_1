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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEFFAF3),
      appBar: AppBar(
        backgroundColor: const Color(0xFF00C27D),
        title: Text(
          _titles[_selectedIndex],
          style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: const Color(0xFF00C27D),
        unselectedItemColor: Colors.grey,
        onTap: (index) => setState(() => _selectedIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.event_note), label: 'Agenda'),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Diário'),
          BottomNavigationBarItem(icon: Icon(Icons.emoji_emotions), label: 'Humor'),
          BottomNavigationBarItem(icon: Icon(Icons.flag), label: 'Metas'),
        ],
      ),
    );
  }
}

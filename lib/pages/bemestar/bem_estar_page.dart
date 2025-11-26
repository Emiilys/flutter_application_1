// 📌 bem_estar_page.dart (tela inicial com abas)
import 'package:flutter/material.dart';
import 'agenda_page.dart';
import 'humor_page.dart';
import 'diario_page.dart';
import 'metas_page.dart';

class BemEstarPage extends StatefulWidget {
  const BemEstarPage({super.key});

  @override
  State<BemEstarPage> createState() => _BemEstarPageState();
}

class _BemEstarPageState extends State<BemEstarPage> {
  int currentIndex = 0;

  final pages = const [
    BemEstarAgendaPage(),
    BemEstarHumorPage(),
    BemEstarDiarioPage(),
    BemEstarMetasPage(),
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
<<<<<<< HEAD
      appBar: AppBar(
        title: const Text("Bem Estar"),
        centerTitle: true,
        backgroundColor: const Color(0xff00b894),
      ),
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        selectedItemColor: const Color(0xff00b894),
        unselectedItemColor: Colors.grey,
        onTap: (index) => setState(() => currentIndex = index),
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.calendar_month), label: "Agenda"),
          BottomNavigationBarItem(
              icon: Icon(Icons.emoji_emotions), label: "Humor"),
          BottomNavigationBarItem(
              icon: Icon(Icons.book), label: "Diário"),
          BottomNavigationBarItem(
              icon: Icon(Icons.flag), label: "Metas"),
        ],
      ),
    );
  }
}

// =========================================================
// 📌 Agenda (somente visual, ainda sem função)
// =========================================================
class BemEstarAgendaPage extends StatelessWidget {
  const BemEstarAgendaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(color: Colors.black12, blurRadius: 4),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Agenda do Dia",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text("Terça-feira, 24 de Junho de 2025",
                        style: TextStyle(color: Colors.grey)),
                    Icon(Icons.add_circle, color: Color(0xff00b894), size: 30),
                  ],
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xffffefef),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: const [
                      Icon(Icons.medication, color: Colors.red),
                      SizedBox(width: 10),
                      Expanded(child: Text("Tomar remédio - Melatonina")),
                      Text("20:30"),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// =========================================================
// 📌 Humor
// =========================================================
class BemEstarHumorPage extends StatelessWidget {
  const BemEstarHumorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Como você está se sentindo?",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          GridView.count(
            shrinkWrap: true,
            crossAxisCount: 3,
            childAspectRatio: 1.2,
            physics: const NeverScrollableScrollPhysics(),
            children: const [
              _HumorItem(label: "Feliz", emoji: "😊"),
              _HumorItem(label: "Animado", emoji: "😄"),
              _HumorItem(label: "Calmo", emoji: "😌"),
              _HumorItem(label: "Pensativo", emoji: "🤔"),
              _HumorItem(label: "Triste", emoji: "😢"),
              _HumorItem(label: "Ansioso", emoji: "😟"),
              _HumorItem(label: "Estressado", emoji: "😫"),
              _HumorItem(label: "Irritado", emoji: "😠"),
              _HumorItem(label: "Cansado", emoji: "🥱"),
              _HumorItem(label: "Motivado", emoji: "🚀"),
              _HumorItem(label: "Grato", emoji: "🙏"),
              _HumorItem(label: "Esperançoso", emoji: "🌟"),
            ],
          ),
        ],
      ),
    );
  }
}

class _HumorItem extends StatelessWidget {
  final String label;
  final String emoji;
  const _HumorItem({required this.label, required this.emoji});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: const Color(0xffe8fff5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(emoji, style: const TextStyle(fontSize: 28)),
          const SizedBox(height: 6),
          Text(label,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}

// =========================================================
// 📌 Diário
// =========================================================
class BemEstarDiarioPage extends StatelessWidget {
  const BemEstarDiarioPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Diário Pessoal",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
            ),
            child: Column(
              children: const [
                TextField(
                  decoration: InputDecoration(
                    labelText: "Como foi seu dia?",
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 4,
                ),
                SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: null,
                    child: Text("Salvar Entrada"),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 20),
          const Text("Entradas Recentes:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          _entryItem("24/06/2025", "Escrevi artigo do TCC"),
          _entryItem("23/06/2025", "Foi legal, estudei bastante!"),
        ],
      ),
    );
  }

  Widget _entryItem(String date, String text) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xfff7f7f7),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          const Icon(Icons.bookmark, color: Colors.teal),
          const SizedBox(width: 12),
          Expanded(child: Text("$date - $text")),
        ],
      ),
    );
  }
}

// =========================================================
// 📌 Metas
// =========================================================
class BemEstarMetasPage extends StatelessWidget {
  const BemEstarMetasPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Metas do Dia",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
            ),
            child: Column(
              children: const [
                TextField(
                  decoration: InputDecoration(
                    labelText: "Nova meta",
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 12),
                TextField(
                  decoration: InputDecoration(
                    labelText: "Horário (opcional)",
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: null,
                    child: Text("Adicionar Meta"),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 20),
          const Text("Suas Metas:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          _metaItem("Beber 2L de água", "12:00"),
        ],
      ),
    );
  }

  Widget _metaItem(String title, String hour) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xffe8fff5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          const Icon(Icons.check_circle, color: Colors.teal),
          const SizedBox(width: 12),
          Expanded(child: Text(title, style: const TextStyle(fontSize: 16))),
          Text(hour, style: const TextStyle(color: Colors.grey)),
=======
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
>>>>>>> 7fda7c3e2fe4d53f5954856d7642673c0c578add
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'problemas_cardiacospage.dart';
import 'respiracao_ansiedadepage.dart';
import 'ferimentospage.dart';
import 'problemas_neurologicospage.dart';

class PrimeirosSocorrosPage extends StatefulWidget {
  const PrimeirosSocorrosPage({Key? key}) : super(key: key);

  @override
  State<PrimeirosSocorrosPage> createState() => _PrimeirosSocorrosPageState();
}

class _PrimeirosSocorrosPageState extends State<PrimeirosSocorrosPage> {
  final TextEditingController _searchController = TextEditingController();
  List<String> _sugestoes = [];

  final List<String> _todasSugestoes = [
    'Infarto',
    'Dor no peito',
    'Falta de ar',
    'Ansiedade',
    'Respiração difícil',
    'Sangramento',
    'Ferimento profundo',
    'Queimadura leve',
    'Fratura',
    'Batida / Hematoma',
    'Desmaio',
    'Convulsão',
    'AVC',
    'Dor de cabeça forte',
  ];

  void _pesquisar(BuildContext context) {
    final termo = _searchController.text.trim().toLowerCase();

    if (termo.isEmpty) return;

    // 🔍 Sistema completo de reconhecimento de termos
    if (termo.contains('coração') ||
        termo.contains('infarto') ||
        termo.contains('dor no peito') ||
        termo.contains('fraqueza') ||
        termo.contains('cardíaco')) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const ProblemasCardiacosPage()));
    } else if (termo.contains('respiração') ||
        termo.contains('ansiedade') ||
        termo.contains('agitação') ||
        termo.contains('inquetação') ||
        termo.contains('tosse com sangue') ||
        termo.contains('dificuldade de respirar') ||
        termo.contains('falta de ar')) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const RespiracaoAnsiedadePage()));
    } else if (termo.contains('ferimento') ||
        termo.contains('queimadura') ||
        termo.contains('hematoma') ||
        termo.contains('batida') ||
        termo.contains('bati') ||
        termo.contains('machucado') ||
        termo.contains('sangramento') ||
        termo.contains('fratura')) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const FerimentosPage()));
    } else if (termo.contains('avc') ||
        termo.contains('convulsão') ||
        termo.contains('desmaio') ||
        termo.contains('epilepsia') ||
        termo.contains('dor de cabeça') ||
        termo.contains('confusão mental') ||
        termo.contains('neurológico')) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const ProblemasNeurologicosPage()));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('⚠️ Nenhum resultado encontrado.'),
          backgroundColor: Colors.redAccent,
        ),
      );
    }

    _searchController.clear();
    setState(() => _sugestoes = []);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfffff5f2),
      appBar: AppBar(
        toolbarHeight: 140,
        elevation: 0,
        automaticallyImplyLeading: false,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xffff6b6b), Color(0xffff8e53)],
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
                    child: const Icon(Icons.arrow_back, color: Colors.white),
                  ),
                  const SizedBox(width: 12),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    child: const Icon(Icons.add, color: Colors.red),
                  ),
                  const SizedBox(width: 12),
                  Flexible(
                    child: Text(
                      'Primeiros Socorros',
                      style: GoogleFonts.poppins(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              const Text(
                'Guia rápido de emergência',
                style: TextStyle(fontSize: 14, color: Colors.white70),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🔍 Barra de pesquisa funcional
            Container(
              margin: const EdgeInsets.only(top: 12, bottom: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: Colors.blue, width: 1.5),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                children: [
                  const Icon(Icons.search, color: Colors.blue),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      onChanged: (value) {
                        setState(() {
                          _sugestoes = _todasSugestoes
                              .where((s) => s.toLowerCase().contains(value.toLowerCase()))
                              .toList();
                        });
                      },
                      onSubmitted: (_) => _pesquisar(context),
                      decoration: const InputDecoration(
                        hintText: 'Pesquisar sintomas ou emergências...',
                        border: InputBorder.none,
                        isDense: true,
                        contentPadding: EdgeInsets.symmetric(vertical: 12),
                      ),
                      style: const TextStyle(fontSize: 14),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.arrow_forward_ios,
                        color: Colors.blue, size: 18),
                    onPressed: () => _pesquisar(context),
                  ),
                ],
              ),
            ),

            // 🧠 Sugestões rápidas
            if (_sugestoes.isNotEmpty)
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.blueAccent, width: 1),
                ),
                padding: const EdgeInsets.all(8),
                margin: const EdgeInsets.only(bottom: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: _sugestoes.map((s) {
                    return ListTile(
                      dense: true,
                      leading: const Icon(Icons.medical_information, color: Colors.blue),
                      title: Text(s),
                      onTap: () {
                        _searchController.text = s;
                        _pesquisar(context);
                      },
                    );
                  }).toList(),
                ),
              ),

            // 🧩 Categorias
            Text(
              'Categorias de Emergência',
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),

            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              crossAxisCount: 2,
              childAspectRatio: 3,
              children: [
                GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ProblemasCardiacosPage()),
                  ),
                  child: _categoriaCard('Problemas Cardíacos', '❤️',
                      Colors.red.shade50, Colors.red, Colors.red.shade700),
                ),
                GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const RespiracaoAnsiedadePage()),
                  ),
                  child: _categoriaCard('Respiração & Ansiedade', '💨',
                      Colors.blue.shade50, Colors.blue, Colors.blue.shade700),
                ),
                GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const FerimentosPage()),
                  ),
                  child: _categoriaCard('Ferimentos & Trauma', '🩸',
                      Colors.orange.shade50, Colors.orange, Colors.orange.shade700),
                ),
                GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ProblemasNeurologicosPage()),
                  ),
                  child: _categoriaCard('Problemas Neurológicos', '🧠',
                      Colors.purple.shade50, Colors.purple, Colors.purple.shade700),
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  static Widget _categoriaCard(String title, String emoji, Color bgColor,
      Color emojiBg, Color textColor) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: textColor, width: 1.5),
      ),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 4,
                    offset: const Offset(0, 2))
              ],
            ),
            padding: const EdgeInsets.all(12),
            child: Text(emoji, style: const TextStyle(fontSize: 28)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(title,
                    style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: textColor)),
                Text('Clique para ver mais',
                    style: TextStyle(
                        fontSize: 12, color: textColor.withOpacity(0.7))),
              ],
            ),
          ),
          const Icon(Icons.arrow_forward_ios, size: 16),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PrimeirosSocorrosPage extends StatelessWidget {
  const PrimeirosSocorrosPage({Key? key}) : super(key: key);

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
                      style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
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
            // Barra de pesquisa customizada
            Container(
              margin: const EdgeInsets.only(top: 12, bottom: 16),
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
                      decoration: const InputDecoration(
                        hintText: 'Pesquisar...',
                        border: InputBorder.none,
                        isDense: true,
                        contentPadding: EdgeInsets.symmetric(vertical: 12),
                      ),
                      style: const TextStyle(fontSize: 14),
                    ),
                  ),
                ],
              ),
            ),

            // Categorias
            const Text(
              'Categorias de Emergência',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
                _categoriaCard('Problemas Cardíacos', '❤️',
                    Colors.red.shade50, Colors.red, Colors.red.shade700),
                _categoriaCard('Respiração & Ansiedade', '💨',
                    Colors.blue.shade50, Colors.blue, Colors.blue.shade700),
                _categoriaCard('Ferimentos & Trauma', '🩸',
                    Colors.orange.shade50, Colors.orange, Colors.orange.shade700),
                _categoriaCard('Problemas Neurológicos', '🧠',
                    Colors.purple.shade50, Colors.purple, Colors.purple.shade700),
              ],
            ),
            const SizedBox(height: 20),

            // Telefones de emergência
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                _EmergencyCard('📞', '193', 'Bombeiros'),
                _EmergencyCard('📞', '190', 'Polícia'),
                _EmergencyCard('📞', '192', 'SAMU'),
              ],
            ),
            const SizedBox(height: 20),

            // Lembretes
            const Text(
              'Lembre-se sempre:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                _LembreteCard(
                    '1. Avalie a situação', '🚨', Colors.orange, 'Verifique se é seguro se aproximar'),
                _LembreteCard(
                    '2. Ligue para emergência', '📞', Colors.green, '192 - SAMU sempre primeiro'),
                _LembreteCard(
                    '3. Preste os primeiros socorros', '🤝', Colors.orangeAccent, 'Siga as instruções das categorias'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _categoriaCard(String title, String emoji, Color bgColor,
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
            child: Text(
              emoji,
              style: GoogleFonts.notoColorEmoji(fontSize: 28),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(title,
                    style: GoogleFonts.notoColorEmoji(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: textColor)),
                Text('Clique para ver mais',
                    style: GoogleFonts.notoColorEmoji(
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

class _LembreteCard extends StatelessWidget {
  final String title;
  final String emoji;
  final Color color;
  final String subtitle;

  const _LembreteCard(this.title, this.emoji, this.color, this.subtitle);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: color, width: 1.5),
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.black12,
                      blurRadius: 4,
                      offset: Offset(0, 2))
                ],
              ),
              child: Text(emoji, style: GoogleFonts.notoColorEmoji(fontSize: 28)),
            ),
            const SizedBox(height: 8),
            Text(title,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 14, color: color)),
            const SizedBox(height: 4),
            Text(subtitle,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 12, color: Colors.white)),
          ],
        ),
      ),
    );
  }
}

class _EmergencyCard extends StatelessWidget {
  final String emoji;
  final String number;
  final String description;

  const _EmergencyCard(this.emoji, this.number, this.description);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            Text(emoji, style: GoogleFonts.notoColorEmoji(fontSize: 28)),
            const SizedBox(height: 4),
            Text(number,
                style: const TextStyle(
                    fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
            const SizedBox(height: 2),
            Text(description,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 12, color: Colors.white)),
          ],
        ),
      ),
    );
  }
}

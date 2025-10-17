import 'package:flutter/material.dart';

class PrimeirosSocorrosPage extends StatelessWidget {
  const PrimeirosSocorrosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffff6b6b),
        title: const Text('Primeiros Socorros'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Campo de busca
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.blue.shade100),
              ),
              child: const TextField(
                enabled: false, // por enquanto não funcional
                decoration: InputDecoration(
                  icon: Icon(Icons.search, color: Colors.blue),
                  hintText: 'Buscar situação de emergência...',
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Categorias de emergência
            const Text(
              'Categorias de Emergência',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 8),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              children: [
                _emergencyButton('Problemas Cardíacos', Icons.favorite, Colors.red.shade100),
                _emergencyButton('Respiração & Ansiedade', Icons.air, Colors.blue.shade100),
                _emergencyButton('Ferimentos & Trauma', Icons.bloodtype, Colors.orange.shade100),
                _emergencyButton('Problemas Neurológicos', Icons.psychology, Colors.purple.shade100),
              ],
            ),
            const SizedBox(height: 16),

            // Telefones de emergência
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.red.shade50,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text('Ligar para Emergência', style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(height: 8),
                  _EmergencyPhone(number: '192', name: 'SAMU', description: 'Emergências médicas'),
                  _EmergencyPhone(number: '193', name: 'Bombeiros', description: 'Incêndio e resgates'),
                  _EmergencyPhone(number: '190', name: 'Polícia', description: 'Emergências policiais'),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Legenda de níveis de gravidade
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Níveis de Gravidade', style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      _LevelIndicator(color: Colors.red, label: 'Crítico'),
                      _LevelIndicator(color: Colors.orange, label: 'Alto'),
                      _LevelIndicator(color: Colors.yellow, label: 'Médio'),
                      _LevelIndicator(color: Colors.green, label: 'Baixo'),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Lembrete
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text(
                'Lembre-se sempre: Mantenha a calma, avalie a situação, ligue para a emergência se necessário e preste primeiros socorros com segurança.',
                style: TextStyle(color: Colors.black87),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _emergencyButton(String title, IconData icon, Color color) {
    return ElevatedButton(
      onPressed: null, // por enquanto não funcional
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: Colors.black87,
        padding: const EdgeInsets.all(12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 36),
          const SizedBox(height: 8),
          Text(title, textAlign: TextAlign.center),
        ],
      ),
    );
  }
}

class _EmergencyPhone extends StatelessWidget {
  final String number;
  final String name;
  final String description;

  const _EmergencyPhone({
    required this.number,
    required this.name,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          const Icon(Icons.phone, color: Colors.red),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('$number - $name', style: const TextStyle(fontWeight: FontWeight.bold)),
              Text(description, style: const TextStyle(fontSize: 12)),
            ],
          ),
        ],
      ),
    );
  }
}

class _LevelIndicator extends StatelessWidget {
  final Color color;
  final String label;

  const _LevelIndicator({required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(width: 20, height: 20, color: color),
        const SizedBox(width: 4),
        Text(label),
      ],
    );
  }
}

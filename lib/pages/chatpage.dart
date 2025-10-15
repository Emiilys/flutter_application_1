import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff9c79d8),
        title: const Text('Chat com Especialistas'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: Icon(Icons.chat_bubble_outline),
          )
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(40),
          child: Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: const Text(
              'Tire suas dúvidas com profissionais qualificados',
              style: TextStyle(
                color: Color.fromARGB(238, 255, 255, 255),
                fontSize: 18,
              ),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          // Título perguntas rápidas
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: const Text(
              'Perguntas Rápidas por Categoria',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),

          // Grid com categorias coloridas e ícones
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                childAspectRatio: 3.8,
                children: [
                  _categoryButton(
                    color: Colors.red.shade400,
                    icon: Icons.phone,
                    label: 'Emergência',
                  ),
                  _categoryButton(
                    color: Colors.blue.shade500,
                    icon: Icons.favorite_border,
                    label: 'Cuidados com Idosos',
                  ),
                  _categoryButton(
                    color: Colors.pink.shade400,
                    icon: Icons.child_friendly,
                    label: 'Cuidados com Bebês',
                  ),
                  _categoryButton(
                    color: Colors.green.shade500,
                    icon: Icons.favorite,
                    label: 'Bem-estar',
                  ),
                  _categoryButton(
                    color: Colors.purple.shade400,
                    icon: Icons.location_on,
                    label: 'Localização',
                  ),
                  _categoryButton(
                    color: Colors.orange.shade600,
                    icon: Icons.book,
                    label: 'Orientações',
                  ),
                ],
              ),
            ),
          ),

          // Mensagem de boas vindas (fake chat bubble)
          Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Olá! Sou um especialista em cuidados. Como posso ajudá-lo hoje?',
                   style: TextStyle(fontSize: 20, color: Color.fromARGB(197, 0, 0, 0)),
                ),
                SizedBox(height: 10),
                Text(
                  '11:14',
                  style: TextStyle(fontSize: 18, color: Colors.black54),
                ),
              ],
            ),
          ),

          // Campo para digitar a pergunta + botão enviar
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Digite sua pergunta...',
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 16),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.grey.shade100,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xff9c79d8),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.send, color: Colors.white),
                    onPressed: () {
                      // Aqui ficará a ação para enviar a pergunta (não funcional)
                    },
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _categoryButton({
    required Color color,
    required IconData icon,
    required String label,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        children: [
          Container(
            height: 44,
            decoration: BoxDecoration(
              color: color,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            ),
            child: Center(
              child: Icon(icon, color: Colors.white),
            ),
          ),
          Expanded(
            child: Center(
              child: Text(
                label,
                textAlign: TextAlign.center,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
          )
        ],
      ),
    );
  }
}
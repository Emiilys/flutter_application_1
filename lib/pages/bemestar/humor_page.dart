import 'package:flutter/material.dart';

class HumorPage extends StatefulWidget {
  const HumorPage({Key? key}) : super(key: key);

  @override
  State<HumorPage> createState() => _HumorPageState();
}

class _HumorPageState extends State<HumorPage> {
  List<Map<String, String>> selectedEmojis = [];

  final List<Map<String, String>> availableEmojis = [
    {'emoji': '😄', 'label': 'Feliz'},
    {'emoji': '😢', 'label': 'Triste'},
    {'emoji': '😡', 'label': 'Bravo'},
    {'emoji': '😴', 'label': 'Cansado'},
    {'emoji': '😱', 'label': 'Assustado'},
    {'emoji': '🤯', 'label': 'Estressado'},
    {'emoji': '😍', 'label': 'Apaixonado'},
    {'emoji': '😐', 'label': 'Neutro'},
    {'emoji': '🤗', 'label': 'Acolhido'},
  ];

  void toggleEmoji(Map<String, String> emoji) {
    setState(() {
      if (selectedEmojis.contains(emoji)) {
        selectedEmojis.remove(emoji);
      } else {
        selectedEmojis.add(emoji);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF00C27D),
      appBar: AppBar(
        backgroundColor: const Color(0xFF00C27D),
        elevation: 0,
        title: const Text('Humor', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Volta para a tela anterior (agenda)
          },
        ),
      ),
      body: Column(
        children: [
          // Área de emojis selecionados
          Container(
            color: const Color(0xFF00C27D),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: selectedEmojis.isEmpty
                ? const Text('Nenhum humor selecionado', style: TextStyle(color: Colors.white))
                : Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: selectedEmojis.map((e) {
                      return GestureDetector(
                        onTap: () => toggleEmoji(e),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Text("${e['emoji']} ${e['label']}"),
                        ),
                      );
                    }).toList(),
                  ),
          ),

          // Grid de emojis
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
              child: GridView.builder(
                itemCount: availableEmojis.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 3,
                ),
                itemBuilder: (context, index) {
                  final emoji = availableEmojis[index];
                  final isSelected = selectedEmojis.contains(emoji);

                  return GestureDetector(
                    onTap: () => toggleEmoji(emoji),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        color: isSelected ? const Color(0xFF00C27D) : Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: isSelected ? Colors.green : Colors.grey.shade300,
                          width: 2,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(emoji['emoji']!, style: const TextStyle(fontSize: 20)),
                          const SizedBox(width: 8),
                          Text(
                            emoji['label']!,
                            style: TextStyle(
                              color: isSelected ? Colors.white : Colors.grey[800],
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

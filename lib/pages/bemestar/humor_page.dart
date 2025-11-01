import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HumorPage extends StatefulWidget {
  const HumorPage({Key? key}) : super(key: key);

  @override
  State<HumorPage> createState() => _HumorPageState();
}

class _HumorPageState extends State<HumorPage> {
  final user = FirebaseAuth.instance.currentUser;
  late String today;
  String? selectedMood;

  final List<Map<String, String>> moods = [
    {'emoji': '😄', 'label': 'Feliz'},
    {'emoji': '😢', 'label': 'Triste'},
    {'emoji': '😡', 'label': 'Bravo'},
    {'emoji': '😴', 'label': 'Cansado'},
    {'emoji': '🤯', 'label': 'Estressado'},
    {'emoji': '😍', 'label': 'Apaixonado'},
    {'emoji': '😐', 'label': 'Neutro'},
  ];

  @override
  void initState() {
    super.initState();
    today = DateFormat('dd/MM/yyyy').format(DateTime.now());
  }

  Future<void> _saveMood(String mood) async {
    await FirebaseFirestore.instance
        .collection('bem_estar')
        .doc('humor')
        .collection(user!.uid)
        .doc(today)
        .set({
      'mood': mood,
      'date': today,
      'timestamp': FieldValue.serverTimestamp(),
    });

    setState(() => selectedMood = mood);
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: moods.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
      ),
      itemBuilder: (context, index) {
        final mood = moods[index];
        final isSelected = selectedMood == mood['label'];

        return GestureDetector(
          onTap: () => _saveMood(mood['label']!),
          child: Container(
            decoration: BoxDecoration(
              color: isSelected ? const Color(0xFF00C27D) : Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isSelected ? Colors.green : Colors.grey.shade300,
                width: 2,
              ),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(mood['emoji']!, style: const TextStyle(fontSize: 28)),
                  const SizedBox(height: 8),
                  Text(
                    mood['label']!,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: isSelected ? Colors.white : Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

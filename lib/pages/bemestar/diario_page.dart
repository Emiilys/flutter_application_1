import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DiarioPage extends StatefulWidget {
  const DiarioPage({Key? key}) : super(key: key);

  @override
  State<DiarioPage> createState() => _DiarioPageState();
}

class _DiarioPageState extends State<DiarioPage> {
  final user = FirebaseAuth.instance.currentUser;
  final TextEditingController _textController = TextEditingController();
  late String today;

  @override
  void initState() {
    super.initState();
    today = DateFormat('dd/MM/yyyy').format(DateTime.now());
  }

  Future<void> _saveEntry() async {
    if (_textController.text.isEmpty) return;

    await FirebaseFirestore.instance
        .collection('bem_estar')
        .doc('diario')
        .collection(user!.uid)
        .add({
      'text': _textController.text,
      'date': today,
      'timestamp': FieldValue.serverTimestamp(),
    });

    _textController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: const Color(0xFF00C27D),
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          child: Text(
            "Data: $today",
            style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextField(
            controller: _textController,
            maxLines: 6,
            decoration: const InputDecoration(
              hintText: "Como foi seu dia?",
              border: OutlineInputBorder(),
            ),
          ),
        ),
        ElevatedButton(
          onPressed: _saveEntry,
          style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF00C27D)),
          child: const Text("Salvar"),
        ),
      ],
    );
  }
}

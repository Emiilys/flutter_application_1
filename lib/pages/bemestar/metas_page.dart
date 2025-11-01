import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MetasPage extends StatefulWidget {
  const MetasPage({Key? key}) : super(key: key);

  @override
  State<MetasPage> createState() => _MetasPageState();
}

class _MetasPageState extends State<MetasPage> {
  final user = FirebaseAuth.instance.currentUser;
  final TextEditingController _goalController = TextEditingController();

  Future<void> _addGoal() async {
    if (_goalController.text.isEmpty) return;

    await FirebaseFirestore.instance
        .collection('bem_estar')
        .doc('metas')
        .collection(user!.uid)
        .add({
      'goal': _goalController.text,
      'completed': false,
      'timestamp': FieldValue.serverTimestamp(),
    });

    _goalController.clear();
  }

  Stream<QuerySnapshot> _getGoals() {
    return FirebaseFirestore.instance
        .collection('bem_estar')
        .doc('metas')
        .collection(user!.uid)
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _goalController,
                  decoration: const InputDecoration(
                    labelText: "Nova meta",
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: _addGoal,
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF00C27D)),
                child: const Icon(Icons.add, color: Colors.white),
              )
            ],
          ),
        ),
        Expanded(
          child: StreamBuilder<QuerySnapshot>(
            stream: _getGoals(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }

              final metas = snapshot.data!.docs;

              if (metas.isEmpty) {
                return const Center(child: Text("Nenhuma meta adicionada."));
              }

              return ListView(
                children: metas.map((doc) {
                  final data = doc.data() as Map<String, dynamic>;
                  return CheckboxListTile(
                    title: Text(data['goal']),
                    value: data['completed'],
                    onChanged: (val) {
                      doc.reference.update({'completed': val});
                    },
                  );
                }).toList(),
              );
            },
          ),
        ),
      ],
    );
  }
}

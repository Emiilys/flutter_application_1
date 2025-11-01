import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AgendaPage extends StatefulWidget {
  const AgendaPage({Key? key}) : super(key: key);

  @override
  State<AgendaPage> createState() => _AgendaPageState();
}

class _AgendaPageState extends State<AgendaPage> {
  final TextEditingController _taskController = TextEditingController();
  final user = FirebaseAuth.instance.currentUser;
  late String today;

  @override
  void initState() {
    super.initState();
    today = DateFormat('dd/MM/yyyy').format(DateTime.now());
  }

  Future<void> _addTask() async {
    if (_taskController.text.isEmpty) return;

    await FirebaseFirestore.instance
        .collection('bem_estar')
        .doc('agenda')
        .collection(user!.uid)
        .add({
      'task': _taskController.text,
      'date': today,
      'timestamp': FieldValue.serverTimestamp(),
    });

    _taskController.clear();
  }

  Stream<QuerySnapshot> _getTasks() {
    return FirebaseFirestore.instance
        .collection('bem_estar')
        .doc('agenda')
        .collection(user!.uid)
        .where('date', isEqualTo: today)
        .orderBy('timestamp', descending: true)
        .snapshots();
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
            "Hoje: $today",
            style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _taskController,
                  decoration: const InputDecoration(
                    labelText: "Nova atividade",
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: _addTask,
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF00C27D)),
                child: const Icon(Icons.add, color: Colors.white),
              )
            ],
          ),
        ),
        Expanded(
          child: StreamBuilder<QuerySnapshot>(
            stream: _getTasks(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }

              final tasks = snapshot.data!.docs;

              if (tasks.isEmpty) {
                return const Center(child: Text("Nenhuma atividade para hoje."));
              }

              return ListView(
                children: tasks.map((doc) {
                  final data = doc.data() as Map<String, dynamic>;
                  return ListTile(
                    title: Text(data['task']),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () => doc.reference.delete(),
                    ),
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

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MetasPage extends StatefulWidget {
  const MetasPage({Key? key}) : super(key: key);

  @override
  State<MetasPage> createState() => _MetasPageState();
}

class _MetasPageState extends State<MetasPage> {
  final TextEditingController metaController = TextEditingController();
  TimeOfDay? horarioSelecionado;
  String? editingDocumentId;

  final CollectionReference metasCollection =
      FirebaseFirestore.instance.collection('metas');

  // Função para escolher horário
  Future<void> escolherHorario() async {
    final TimeOfDay? horario = await showTimePicker(
      context: context,
      initialTime: horarioSelecionado ?? TimeOfDay.now(),
    );

    if (horario != null) {
      setState(() {
        horarioSelecionado = horario;
      });
    }
  }

  void salvarMeta() async {
    if (metaController.text.isEmpty) return;

    try {
      Timestamp? horarioTimestamp;
      if (horarioSelecionado != null) {
        final now = DateTime.now();
        final dateTime = DateTime(
          now.year,
          now.month,
          now.day,
          horarioSelecionado!.hour,
          horarioSelecionado!.minute,
        );
        horarioTimestamp = Timestamp.fromDate(dateTime);
      }

      if (editingDocumentId == null) {
        await metasCollection.add({
          'texto': metaController.text,
          'horario': horarioTimestamp,
          'concluida': false,
        });
      } else {
        await metasCollection.doc(editingDocumentId).update({
          'texto': metaController.text,
          'horario': horarioTimestamp,
        });
      }

      metaController.clear();
      horarioSelecionado = null;
      editingDocumentId = null;
      setState(() {});
    } catch (e) {
      print("Erro ao salvar no Firebase: $e");
    }
  }

  void editarMeta(String docId, String texto, Timestamp? horario) {
    setState(() {
      metaController.text = texto;
      if (horario != null) {
        final dt = horario.toDate();
        horarioSelecionado = TimeOfDay(hour: dt.hour, minute: dt.minute);
      } else {
        horarioSelecionado = null;
      }
      editingDocumentId = docId;
    });
  }

  void excluirMeta(String docId) async {
    await metasCollection.doc(docId).delete();
  }

  void toggleConcluida(String docId, bool concluida) async {
    await metasCollection.doc(docId).update({'concluida': !concluida});
  }

  String formatarHorario(TimeOfDay? horario) {
    if (horario == null) return '';
    final hour = horario.hour.toString().padLeft(2, '0');
    final minute = horario.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bem Estar - Metas'),
        backgroundColor: const Color(0xFF00C27D),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      backgroundColor: const Color(0xFFEFFAF3),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Metas do Dia',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: metaController,
              decoration: InputDecoration(
                hintText: 'Ex: Beber 2L de água',
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              ),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: escolherHorario,
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF00C27D)),
              child: Text(horarioSelecionado != null
                  ? 'Horário: ${formatarHorario(horarioSelecionado)}'
                  : 'Selecionar Horário (opcional)'),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: salvarMeta,
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF00C27D)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.add),
                  const SizedBox(width: 8),
                  Text(editingDocumentId == null
                      ? 'Adicionar Meta'
                      : 'Atualizar Meta'),
                ],
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Suas Metas:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: metasCollection.snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return const Center(child: Text('Nenhuma meta encontrada'));
                  }

                  final metas = snapshot.data!.docs;

                  return ListView.builder(
                    itemCount: metas.length,
                    itemBuilder: (context, index) {
                      final doc = metas[index];
                      final texto = doc['texto'] ?? '';
                      final Timestamp? horarioTimestamp = doc['horario'];
                      final bool concluida = doc['concluida'] ?? false;

                      TimeOfDay? horarioDoc;
                      if (horarioTimestamp != null) {
                        final dt = horarioTimestamp.toDate();
                        horarioDoc = TimeOfDay(hour: dt.hour, minute: dt.minute);
                      }

                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 6),
                        child: ListTile(
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                          leading: Checkbox(
                            value: concluida,
                            onChanged: (_) => toggleConcluida(doc.id, concluida),
                          ),
                          title: Text(
                            texto,
                            style: TextStyle(
                              decoration: concluida
                                  ? TextDecoration.lineThrough
                                  : null,
                              fontSize: 16,
                            ),
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              if (horarioDoc != null)
                                Row(
                                  children: [
                                    const Icon(Icons.access_time,
                                        size: 16, color: Colors.green),
                                    const SizedBox(width: 4),
                                    Text(
                                      formatarHorario(horarioDoc),
                                      style: const TextStyle(
                                          fontSize: 14, color: Colors.green),
                                    ),
                                    const SizedBox(width: 8),
                                  ],
                                ),
                              IconButton(
                                icon: const Icon(Icons.edit, color: Colors.blue),
                                onPressed: () =>
                                    editarMeta(doc.id, texto, horarioTimestamp),
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete, color: Colors.red),
                                onPressed: () => excluirMeta(doc.id),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

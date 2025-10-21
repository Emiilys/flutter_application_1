import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DiarioPage extends StatefulWidget {
  const DiarioPage({Key? key}) : super(key: key);

  @override
  State<DiarioPage> createState() => _DiarioPageState();
}

class _DiarioPageState extends State<DiarioPage> {
  final TextEditingController entradaController = TextEditingController();
  String? editingDocumentId;

  // Conexão com a coleção "diario" no Firebase
  final CollectionReference diarioCollection =
      FirebaseFirestore.instance.collection('diario');

  void salvarEntrada() async {
    if (entradaController.text.isEmpty) return;

    try {
      if (editingDocumentId == null) {
        // Adiciona nova entrada
        await diarioCollection.add({
          'texto': entradaController.text,
          'data': Timestamp.now(),
        });
      } else {
        // Edita entrada existente
        await diarioCollection.doc(editingDocumentId).update({
          'texto': entradaController.text,
          'data': Timestamp.now(),
        });
      }

      // Limpa campos e reseta edição
      entradaController.clear();
      editingDocumentId = null;
      setState(() {});
    } catch (e) {
      print("Erro ao salvar no Firebase: $e");
    }
  }

  void editarEntrada(String docId, String texto) {
    setState(() {
      entradaController.text = texto;
      editingDocumentId = docId;
    });
  }

  void excluirEntrada(String docId) async {
    await diarioCollection.doc(docId).delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bem Estar - Diário'),
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
              'Como foi seu dia?',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: entradaController,
              maxLines: 3,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8)),
                hintText: 'Escreva sobre seus sentimentos, experiências do dia...',
              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: salvarEntrada,
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF00C27D)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.add),
                  const SizedBox(width: 8),
                  Text(editingDocumentId == null
                      ? 'Salvar Entrada'
                      : 'Atualizar Entrada'),
                ],
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Entradas Recentes:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream:
                    diarioCollection.orderBy('data', descending: true).snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return const Center(
                        child: Text('Nenhuma entrada encontrada'));
                  }

                  final entradas = snapshot.data!.docs;

                  return ListView.builder(
                    itemCount: entradas.length,
                    itemBuilder: (context, index) {
                      final doc = entradas[index];
                      final texto = doc['texto'] ?? '';
                      final timestamp = doc['data'] as Timestamp;
                      final data = timestamp.toDate();

                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 6),
                        child: ListTile(
                          title: Text(texto),
                          subtitle: Text(
                              '${data.day}/${data.month}/${data.year} ${data.hour.toString().padLeft(2,'0')}:${data.minute.toString().padLeft(2,'0')}'),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.edit, color: Colors.blue),
                                onPressed: () => editarEntrada(doc.id, texto),
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete, color: Colors.red),
                                onPressed: () => excluirEntrada(doc.id),
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

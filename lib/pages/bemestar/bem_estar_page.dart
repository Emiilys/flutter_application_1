import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/pages/bemEstar/humor_page.dart';
import 'package:flutter_application_1/pages/bemEstar/metaspage.dart';
import 'diaro_page.dart';

class BemEstarPage extends StatefulWidget {
  const BemEstarPage({Key? key}) : super(key: key);

  @override
  State<BemEstarPage> createState() => _BemEstarPageState();
}

class _BemEstarPageState extends State<BemEstarPage> {
  bool showForm = false;

  final TextEditingController titleController = TextEditingController();
  final TextEditingController timeController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  String selectedType = 'Pessoal';
  final List<String> types = ['Pessoal', 'Medicação', 'Consulta', 'Exercícios', 'Refeição'];

  String? editingDocumentId;

  final CollectionReference agendamentosCollection =
      FirebaseFirestore.instance.collection('agendamentos');

  final Map<String, Color> categoriaColors = {
    'Pessoal': Colors.purple,
    'Medicação': Colors.red,
    'Consulta': Colors.blue,
    'Exercícios': Colors.green,
    'Refeição': Colors.orange,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF00C27D),

      // 🔹 Cabeçalho personalizado
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(140),
        child: AppBar(
          automaticallyImplyLeading: false,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF00C27D), Color(0xFF00E48C)],
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
                      child: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
                    ),
                    const SizedBox(width: 12),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: const Icon(Icons.favorite, color: Color(0xFF00C27D)),
                    ),
                    const SizedBox(width: 12),
                    Flexible(
                      child: Text(
                        'Bem Estar',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                          color: Colors.white,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                const Text(
                  'Monitore seu bem-estar e dia a dia',
                  style: TextStyle(fontSize: 14, color: Colors.white70),
                ),
              ],
            ),
          ),
        ),
      ),

      body: Column(
        children: [
          // Guias do topo
          Container(
            color: Colors.transparent,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      showForm = false;
                    });
                  },
                  child: const Text(
                    'Agenda',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const HumorPage()),
                    );
                  },
                  child: const Text(
                    'Humor',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const DiarioPage()),
                    );
                  },
                  child: const Text(
                    'Diário',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const MetasPage()),
                    );
                  },
                  child: const Text(
                    'Metas',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),

          // Corpo principal
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
              child: showForm ? _buildForm() : _buildAgendaList(),
            ),
          ),
        ],
      ),
    );
  }

  // 🔹 Mantém a lista de agendamentos igual
  Widget _buildAgendaList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Agenda do Dia',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Colors.grey[800],
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Terça-Feira, 21 De Outubro De 2025',
          style: TextStyle(fontSize: 14, color: Colors.grey[600]),
        ),
        const SizedBox(height: 16),
        Expanded(
          child: StreamBuilder<QuerySnapshot>(
            stream: agendamentosCollection.orderBy('data').snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Icon(Icons.calendar_today, size: 50, color: Colors.grey),
                      SizedBox(height: 16),
                      Text('Nenhum item agendado para hoje', style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                );
              }

              final agendamentos = snapshot.data!.docs;
              final totalConcluidos = agendamentos.where((doc) => doc['concluido'] == true).length;

              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: agendamentos.length,
                      itemBuilder: (context, index) {
                        final doc = agendamentos[index];
                        final dataHora = (doc['data'] as Timestamp).toDate();
                        final horaFormatada =
                            "${dataHora.hour.toString().padLeft(2, '0')}:${dataHora.minute.toString().padLeft(2, '0')}";
                        final concluido = doc['concluido'] ?? false;
                        final categoria = doc['categoria'] ?? 'Pessoal';
                        final corCategoria = categoriaColors[categoria] ?? Colors.grey;

                        return Container(
                          margin: const EdgeInsets.symmetric(vertical: 6),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.grey.shade300),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  await agendamentosCollection.doc(doc.id).update({
                                    'concluido': !concluido,
                                  });
                                },
                                child: Container(
                                  width: 24,
                                  height: 24,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: concluido ? Colors.green : Colors.transparent,
                                    border: Border.all(color: corCategoria, width: 2),
                                  ),
                                  child: concluido
                                      ? const Icon(Icons.check, size: 16, color: Colors.white)
                                      : null,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                          decoration: BoxDecoration(
                                            color: corCategoria.withOpacity(0.2),
                                            borderRadius: BorderRadius.circular(4),
                                          ),
                                          child: Text(
                                            categoria,
                                            style: TextStyle(
                                              color: corCategoria,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        Text(
                                          horaFormatada,
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.grey[600],
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      doc['titulo'],
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                        decoration: concluido ? TextDecoration.lineThrough : null,
                                      ),
                                    ),
                                    if (doc['descricao'] != null && doc['descricao'].toString().isNotEmpty)
                                      Text(
                                        doc['descricao'],
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey[700],
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete, color: Colors.red),
                                onPressed: () async {
                                  await agendamentosCollection.doc(doc.id).delete();
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      "$totalConcluidos de ${agendamentos.length} itens concluídos",
                      style: TextStyle(color: Colors.grey[700], fontSize: 12),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: ElevatedButton.icon(
            onPressed: () {
              setState(() {
                showForm = true;
                editingDocumentId = null;
                titleController.clear();
                timeController.clear();
                descriptionController.clear();
                selectedType = 'Pessoal';
              });
            },
            icon: const Icon(Icons.add),
            label: const Text('Novo'),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF00C27D),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildForm() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Agenda do Dia',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.grey[800],
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Terça-Feira, 21 De Outubro De 2025',
            style: TextStyle(fontSize: 14, color: Colors.grey[600]),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: titleController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Título',
              hintText: 'Ex: Tomar remédio',
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: timeController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Horário',
              hintText: '--:--',
              suffixIcon: Icon(Icons.access_time),
            ),
          ),
          const SizedBox(height: 12),
          DropdownButtonFormField<String>(
            value: selectedType,
            items: types.map((type) {
              return DropdownMenuItem(
                value: type,
                child: Text(type),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                selectedType = value!;
              });
            },
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Categoria',
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: descriptionController,
            maxLines: 3,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Descrição (opcional)',
              hintText: 'Detalhes adicionais...',
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () async {
                    if (titleController.text.isEmpty || timeController.text.isEmpty) return;
                    try {
                      final dataHora = DateTime.parse("2025-10-22 ${timeController.text}:00");
                      if (editingDocumentId == null) {
                        await agendamentosCollection.add({
                          'titulo': titleController.text,
                          'descricao': descriptionController.text,
                          'data': Timestamp.fromDate(dataHora),
                          'concluido': false,
                          'categoria': selectedType,
                        });
                      } else {
                        await agendamentosCollection.doc(editingDocumentId).update({
                          'titulo': titleController.text,
                          'descricao': descriptionController.text,
                          'data': Timestamp.fromDate(dataHora),
                          'categoria': selectedType,
                        });
                      }

                      titleController.clear();
                      timeController.clear();
                      descriptionController.clear();
                      selectedType = 'Pessoal';
                      editingDocumentId = null;

                      setState(() {
                        showForm = false;
                      });
                    } catch (e) {
                      print("Erro ao salvar no Firebase: $e");
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF00C27D),
                  ),
                  child: Text(editingDocumentId == null ? 'Adicionar' : 'Salvar'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    setState(() {
                      showForm = false;
                      editingDocumentId = null;
                    });
                  },
                  child: const Text('Cancelar'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

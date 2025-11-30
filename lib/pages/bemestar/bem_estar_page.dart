// bem_estar_page_firestore.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter/services.dart';

class BemEstarPage extends StatefulWidget {
  const BemEstarPage({super.key});

  @override
  State<BemEstarPage> createState() => _BemEstarPageState();
}

class _BemEstarPageState extends State<BemEstarPage> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  // dados carregados em memória para evitar leituras repetidas
  Map<String, Map<String, dynamic>> dias = {};

  final diarioController = TextEditingController();
  final metaController = TextEditingController();
  final horaMetaController = TextEditingController();

  bool _loadingDay = false; // loading ao buscar/guardar dia

  final List<Map<String, String>> humores = [
    {'nome': 'Feliz', 'emoji': '😄'},
    {'nome': 'Triste', 'emoji': '😢'},
    {'nome': 'Ansioso', 'emoji': '😰'},
    {'nome': 'Cansado', 'emoji': '😴'},
    {'nome': 'Animado', 'emoji': '🤩'},
    {'nome': 'Bravo', 'emoji': '😠'},
    {'nome': 'Calmo', 'emoji': '😌'},
    {'nome': 'Estressado', 'emoji': '😫'},
  ];

  final List<String> humoresSelecionados = [];

  FirebaseFirestore get _db => FirebaseFirestore.instance;
  User? get _user => FirebaseAuth.instance.currentUser;

  // ---------------- util ----------------
  bool _isSameDate(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;

  bool _isBeforeDate(DateTime a, DateTime b) {
    if (a.year != b.year) return a.year < b.year;
    if (a.month != b.month) return a.month < b.month;
    return a.day < b.day;
  }

  String _dateKey(DateTime d) => '${d.year}-${d.month}-${d.day}';

  DocumentReference<Map<String, dynamic>> _diaDocRef(String uid, DateTime d) {
    final key = _dateKey(d);
    return _db.collection('bemestar').doc(uid).collection('dias').doc(key);
  }

  // ---------------- FIRESTORE ----------------

  /// Carrega o documento do dia. Se existir, retorna o mapa.
  /// Se não existir, retorna null (não cria).
  Future<Map<String, dynamic>?> carregarDiaNoBanco(DateTime dia) async {
    final usuario = _user;
    if (usuario == null) throw Exception('Usuário não autenticado');

    final docRef = _diaDocRef(usuario.uid, dia);
    final snap = await docRef.get();
    if (snap.exists) return snap.data();
    return null;
  }

  /// Cria o dia com campos vazios (usado quando usuário seleciona hoje/futuro)
  Future<void> criarDiaSeNaoExistir(DateTime dia) async {
    final usuario = _user;
    if (usuario == null) throw Exception('Usuário não autenticado');

    final docRef = _diaDocRef(usuario.uid, dia);
    final snap = await docRef.get();
    if (!snap.exists) {
      await docRef.set({
        'diario': '',
        'metas': <Map<String, dynamic>>[],
        'humores': <String>[],
        'createdAt': FieldValue.serverTimestamp(),
      });
    }
  }

  Future<void> salvarDiarioNoBanco(DateTime dia, String texto) async {
    final usuario = _user;
    if (usuario == null) throw Exception('Usuário não autenticado');

    final docRef = _diaDocRef(usuario.uid, dia);
    await docRef.set({'diario': texto, 'updatedAt': FieldValue.serverTimestamp()},
        SetOptions(merge: true));
  }

  Future<void> salvarMetasNoBanco(DateTime dia, List<Map<String, dynamic>> metas) async {
    final usuario = _user;
    if (usuario == null) throw Exception('Usuário não autenticado');

    final docRef = _diaDocRef(usuario.uid, dia);
    await docRef.set({'metas': metas, 'updatedAt': FieldValue.serverTimestamp()},
        SetOptions(merge: true));
  }

  Future<void> salvarHumoresNoBanco(DateTime dia, List<String> humores) async {
    final usuario = _user;
    if (usuario == null) throw Exception('Usuário não autenticado');

    final docRef = _diaDocRef(usuario.uid, dia);
    await docRef.set({'humores': humores, 'updatedAt': FieldValue.serverTimestamp()},
        SetOptions(merge: true));
  }

  // ---------------- UI & integração ----------------

  @override
  void dispose() {
    diarioController.dispose();
    metaController.dispose();
    horaMetaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar com botão de voltar
      appBar: AppBar(
        backgroundColor: const Color(0xFF4DD6C0),
        foregroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.favorite, color: Colors.white),
            SizedBox(width: 8),
            Text('Bem Estar'),
          ],
        ),
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFEFFFFA),
              Color(0xFFDFF7F2),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _section("Calendário"),
                const SizedBox(height: 8),
                _buildCalendar(),
                const SizedBox(height: 24),
                if (_loadingDay) const Center(child: CircularProgressIndicator()),
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: _selectedDay != null
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _section("Diário"),
                            const SizedBox(height: 8),
                            _card(child: _buildDiario()),
                            const SizedBox(height: 24),
                            _section("Metas"),
                            const SizedBox(height: 8),
                            _card(child: _buildMetas()),
                            const SizedBox(height: 24),
                            _section("Humor"),
                            const SizedBox(height: 8),
                            _card(child: _buildHumor()),
                            const SizedBox(height: 24),
                          ],
                        )
                      : const SizedBox(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _section(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 4),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: Color(0xFF1C6B5A),
        ),
      ),
    );
  }

  Widget _card({required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 10,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: child,
    );
  }

  // ---------------- CALENDAR ----------------
  Widget _buildCalendar() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 3))
        ],
      ),
      child: TableCalendar(
        focusedDay: _focusedDay,
        firstDay: DateTime(2020),
        lastDay: DateTime(2030),
        availableCalendarFormats: const {CalendarFormat.month: 'Mês'},
        selectedDayPredicate: (day) =>
            _selectedDay != null && _isSameDate(day, _selectedDay!),
        headerStyle: const HeaderStyle(
          formatButtonVisible: false,
          titleCentered: true,
          titleTextStyle: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1C6B5A),
          ),
          leftChevronIcon: Icon(Icons.chevron_left, size: 26),
          rightChevronIcon: Icon(Icons.chevron_right, size: 26),
        ),
        calendarStyle: CalendarStyle(
          selectedDecoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF4DD6C0), Color(0xFF3CB7A6)],
            ),
            shape: BoxShape.circle,
          ),
          todayDecoration: BoxDecoration(
            color: const Color(0xFF4DD6C0).withOpacity(0.4),
            shape: BoxShape.circle,
          ),
        ),
        onDaySelected: (selected, focused) async {
          // ao selecionar dia, carregamos do banco (ou criamos se for hoje/futuro)
          setState(() => _loadingDay = true);

          try {
            final hoje = DateTime(
                DateTime.now().year, DateTime.now().month, DateTime.now().day);
            final key = _dateKey(selected);

            final usuario = _user;
            if (usuario == null) {
              throw Exception('Usuário não autenticado');
            }

            // toggle: se clicar no mesmo dia selecionado, fecha
            if (_selectedDay != null && _isSameDate(selected, _selectedDay!)) {
              setState(() {
                _selectedDay = null;
                diarioController.clear();
                humoresSelecionados.clear();
                _loadingDay = false;
              });
              return;
            }

            // se dia passado e não tem dados -> bloqueia seleção
            final doc = await _diaDocRef(usuario.uid, selected).get();
            if (_isBeforeDate(selected, hoje) && !doc.exists) {
              // não permite selecionar dia passado sem dados
              setState(() => _loadingDay = false);
              return;
            }

            // se for hoje/futuro e não existe -> cria vazio
            if (!doc.exists) {
              await _diaDocRef(usuario.uid, selected).set({
                'diario': '',
                'metas': <Map<String, dynamic>>[],
                'humores': <String>[],
                'createdAt': FieldValue.serverTimestamp(),
              });
            }

            // carrega documento (agora existe)
            final fresh = await _diaDocRef(usuario.uid, selected).get();
            final data = fresh.data() ?? {'diario': '', 'metas': [], 'humores': []};

            // salva em cache local
            setState(() {
              dias[key] = Map<String, dynamic>.from(data);
              _selectedDay = selected;
              _focusedDay = focused;

              diarioController.text = dias[key]!['diario'] ?? '';
              humoresSelecionados
                ..clear()
                ..addAll(List<String>.from(dias[key]!['humores'] ?? []));
            });
          } catch (e) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Erro ao carregar dia.')),
            );
          } finally {
            setState(() => _loadingDay = false);
          }
        },
      ),
    );
  }

  // ---------------- DIÁRIO ----------------
  Widget _buildDiario() {
    if (_selectedDay == null) return const SizedBox.shrink();
    final key = _dateKey(_selectedDay!);

    // garante texto atual do cache
    final diarioTexto = dias[key]?['diario'] ?? '';
    diarioController.text = diarioTexto;

    return Column(
      children: [
        TextField(
          controller: diarioController,
          maxLines: 5,
          decoration: _inputDecoration("Escreva sobre seu dia..."),
        ),
        const SizedBox(height: 14),
        if (!_isBeforeDate(
            _selectedDay!, DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day)))
          _button("Salvar Diário", () async {
            // salva local e no banco
            final key = _dateKey(_selectedDay!);
            final texto = diarioController.text;
            setState(() {
              dias[key]!['diario'] = texto;
            });
            try {
              await salvarDiarioNoBanco(_selectedDay!, texto);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Diário salvo.')),
              );
            } catch (e) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Erro ao salvar diário.')),
              );
            }
          }),
      ],
    );
  }

  // ---------------- METAS ----------------
  Widget _buildMetas() {
    if (_selectedDay == null) return const SizedBox.shrink();
    final key = _dateKey(_selectedDay!);
    final metas = List<Map<String, dynamic>>.from(dias[key]?['metas'] ?? []);

    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: metaController,
                decoration: _inputDecoration("Nova meta"),
              ),
            ),
            const SizedBox(width: 8),
            SizedBox(
              width: 90,
              child: TextField(
                controller: horaMetaController,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9:]')),
                ],
                decoration: _inputDecoration("HH:MM"),
              ),
            ),
            if (!_isBeforeDate(
                _selectedDay!, DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day)))
              IconButton(
                icon: const Icon(Icons.add, color: Color(0xFF4DD6C0), size: 30),
                onPressed: () async {
                  final nova = {
                    'texto': metaController.text,
                    'hora': horaMetaController.text,
                    'feito': false,
                  };
                  metas.add(nova);
                  dias[key]!['metas'] = metas;
                  metaController.clear();
                  horaMetaController.clear();
                  setState(() {});

                  // salva no banco
                  try {
                    await salvarMetasNoBanco(_selectedDay!, metas);
                    ScaffoldMessenger.of(context)
                        .showSnackBar(const SnackBar(content: Text('Meta adicionada.')));
                  } catch (e) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text('Erro ao salvar meta.')));
                  }
                },
              ),
          ],
        ),
        const SizedBox(height: 16),
        ...metas.map((meta) {
          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                )
              ],
            ),
            child: Row(
              children: [
                Checkbox(
                  value: meta['feito'] ?? false,
                  activeColor: const Color(0xFF4DD6C0),
                  onChanged: (v) async {
                    meta['feito'] = v ?? false;
                    dias[key]!['metas'] = metas;
                    setState(() {});

                    // salva alteração no banco
                    try {
                      await salvarMetasNoBanco(_selectedDay!, metas);
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Erro ao atualizar meta.')));
                    }
                  },
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        meta['texto'] ?? '',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        "Hora: ${meta['hora'] ?? ''}",
                        style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        }).toList(),
      ],
    );
  }

  // ---------------- HUMOR ----------------
  Widget _buildHumor() {
    if (_selectedDay == null) return const SizedBox.shrink();
    final key = _dateKey(_selectedDay!);

    return Wrap(
      spacing: 12,
      runSpacing: 12,
      alignment: WrapAlignment.center,
      children: humores.map((h) {
        final nome = h['nome']!;
        final emoji = h['emoji']!;
        final selecionado = (dias[key]?['humores'] ?? []).contains(nome);

        return ChoiceChip(
          label: Text("$emoji  $nome"),
          selected: selecionado,
          selectedColor: const Color(0xFF4DD6C0),
          backgroundColor: Colors.white,
          labelStyle: TextStyle(
            color: selecionado ? Colors.white : Colors.black,
            fontWeight: FontWeight.w600,
          ),
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          onSelected: (v) async {
            // não permite editar dias passados
            if (_isBeforeDate(
                _selectedDay!, DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day))) {
              return;
            }

            final lista = List<String>.from(dias[key]!['humores'] ?? []);
            if (v) {
              if (!lista.contains(nome)) lista.add(nome);
            } else {
              lista.remove(nome);
            }
            dias[key]!['humores'] = lista;
            setState(() {});

            try {
              await salvarHumoresNoBanco(_selectedDay!, lista);
            } catch (e) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text('Erro ao salvar humor.')));
            }
          },
        );
      }).toList(),
    );
  }

  // ---------------- helpers UI ----------------
  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide.none,
      ),
    );
  }

  Widget _button(String text, VoidCallback onTap) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 3,
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          backgroundColor: const Color(0xFF4DD6C0),
          foregroundColor: Colors.white,
        ),
        onPressed: onTap,
        child: Text(
          text,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

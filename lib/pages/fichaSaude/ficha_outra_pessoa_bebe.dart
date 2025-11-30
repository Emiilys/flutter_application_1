import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FichaBebePage extends StatefulWidget {
  const FichaBebePage({super.key});

  @override
  State<FichaBebePage> createState() => _FichaBebePageState();
}

class _FichaBebePageState extends State<FichaBebePage>
    with SingleTickerProviderStateMixin {
  // ---------------- Controladores ----------------
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController idadeController = TextEditingController();
  final TextEditingController alergiasController = TextEditingController();
  final TextEditingController cuidadosEspecificosController =
      TextEditingController();
  final TextEditingController rotinaSonoController = TextEditingController();
  final TextEditingController alimentacaoController = TextEditingController();
  final TextEditingController responsavel1Controller = TextEditingController();
  final TextEditingController responsavel2Controller = TextEditingController();

  // ---------------- Temas ----------------
  Color temaAtual = const Color(0xFFEFEFEF);
  final Color rosaBebe = const Color(0xFFF7C9D7);
  final Color azulBebe = const Color(0xFFC7DFF9);

  String? generoSelecionado;
  String? dormeBem;
  String? tomaLeiteMaterno;
  String? tomaRemedios;
  String? andaSozinho;

  // ---------------- Vacinas ----------------
  bool vacinaBCG = false;
  bool vacinaHepatiteB = false;
  bool vacinaPentavalente = false;
  bool vacinaPolio = false;
  bool vacinaRotavirus = false;

  // ---------------- Marcos ----------------
  bool marcoEngatinha = false;
  bool marcoSustentaCabeca = false;
  bool marcoSorri = false;
  bool marcoBalbucia = false;

  // ---------------- UI / animações ----------------
  bool _loading = true;
  bool _manualExpanded = false;
  double _dropdownScale = 1.0;
  final int _sectionAnimationDuration = 350;
  bool _modoEdicao = false; // Começa em visualização

  @override
  void initState() {
    super.initState();
    _carregarFicha();
  }

  @override
  void dispose() {
    nomeController.dispose();
    idadeController.dispose();
    alergiasController.dispose();
    cuidadosEspecificosController.dispose();
    rotinaSonoController.dispose();
    alimentacaoController.dispose();
    responsavel1Controller.dispose();
    responsavel2Controller.dispose();
    super.dispose();
  }

  // ---------------- Funções ----------------
  void _atualizarTemaPorGenero(String? genero) {
    setState(() {
      _dropdownScale = 0.95;
    });
    Future.delayed(const Duration(milliseconds: 120), () {
      if (!mounted) return;
      setState(() {
        _dropdownScale = 1.0;
        generoSelecionado = genero;
        if (genero == "Menina") {
          temaAtual = rosaBebe;
        } else if (genero == "Menino") {
          temaAtual = azulBebe;
        } else {
          temaAtual = const Color(0xFFEFEFEF);
        }
      });
    });
  }

  Future<void> _salvarFicha() async {
    final Map<String, dynamic> ficha = {
      'nome': nomeController.text.trim(),
      'idade': idadeController.text.trim(),
      'genero': generoSelecionado,
      'dormeBem': dormeBem,
      'tomaLeiteMaterno': tomaLeiteMaterno,
      'tomaRemedios': tomaRemedios,
      'andaSozinho': andaSozinho,
      'alergias': alergiasController.text.trim(),
      'rotinaSono': rotinaSonoController.text.trim(),
      'alimentacao': alimentacaoController.text.trim(),
      'cuidadosEspecificos': cuidadosEspecificosController.text.trim(),
      'responsavel1': responsavel1Controller.text.trim(),
      'responsavel2': responsavel2Controller.text.trim(),
      'vacinas': {
        'BCG': vacinaBCG,
        'HepatiteB': vacinaHepatiteB,
        'Pentavalente': vacinaPentavalente,
        'Polio': vacinaPolio,
        'Rotavirus': vacinaRotavirus,
      },
      'marcos': {
        'engatinha': marcoEngatinha,
        'sustentaCabeca': marcoSustentaCabeca,
        'sorri': marcoSorri,
        'balbucia': marcoBalbucia,
      },
      'ultimaAtualizacao': FieldValue.serverTimestamp(),
    };

    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) return;

      await FirebaseFirestore.instance
          .collection('fichas')
          .doc('bebeFicha')
          .collection('usuarios')
          .doc(user.uid)
          .set(ficha, SetOptions(merge: true));

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Ficha do bebê salva com sucesso.')),
      );

      setState(() => _modoEdicao = false);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao salvar ficha.')),
      );
    }
  }

  Future<void> _carregarFicha() async {
    setState(() => _loading = true);
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) return;

      final doc = await FirebaseFirestore.instance
          .collection('fichas')
          .doc('bebeFicha')
          .collection('usuarios')
          .doc(user.uid)
          .get();

      if (!doc.exists) {
        setState(() => _loading = false);
        return;
      }

      final data = doc.data()!;
      setState(() {
        nomeController.text = data['nome'] ?? '';
        idadeController.text = data['idade'] ?? '';
        generoSelecionado = data['genero'];
        dormeBem = data['dormeBem'];
        tomaLeiteMaterno = data['tomaLeiteMaterno'];
        tomaRemedios = data['tomaRemedios'];
        andaSozinho = data['andaSozinho'];
        alergiasController.text = data['alergias'] ?? '';
        rotinaSonoController.text = data['rotinaSono'] ?? '';
        alimentacaoController.text = data['alimentacao'] ?? '';
        cuidadosEspecificosController.text = data['cuidadosEspecificos'] ?? '';
        responsavel1Controller.text = data['responsavel1'] ?? '';
        responsavel2Controller.text = data['responsavel2'] ?? '';

        final vacinas = data['vacinas'] ?? {};
        vacinaBCG = vacinas['BCG'] ?? false;
        vacinaHepatiteB = vacinas['HepatiteB'] ?? false;
        vacinaPentavalente = vacinas['Pentavalente'] ?? false;
        vacinaPolio = vacinas['Polio'] ?? false;
        vacinaRotavirus = vacinas['Rotavirus'] ?? false;

        final marcos = data['marcos'] ?? {};
        marcoEngatinha = marcos['engatinha'] ?? false;
        marcoSustentaCabeca = marcos['sustentaCabeca'] ?? false;
        marcoSorri = marcos['sorri'] ?? false;
        marcoBalbucia = marcos['balbucia'] ?? false;

        _atualizarTemaPorGenero(generoSelecionado);
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao carregar ficha.')),
      );
    } finally {
      setState(() => _loading = false);
    }
  }

  // ---------------- Helpers de animação ----------------
  Widget _animatedSection({required Widget child, required int index}) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: Duration(milliseconds: _sectionAnimationDuration),
      curve: Curves.easeOut,
      builder: (context, value, _) {
        final opacity = value;
        final translateY = (1 - value) * 12.0;
        return Opacity(
          opacity: opacity,
          child: Transform.translate(
            offset: Offset(0, translateY),
            child: child,
          ),
        );
      },
    );
  }

  // ---------------- Build ----------------
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeInOut,
      color: temaAtual,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: temaAtual,
          elevation: 0,
          centerTitle: true,
          foregroundColor:
              temaAtual.computeLuminance() > 0.5 ? Colors.black : Colors.white,
          leading: IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => Navigator.of(context).pop(),
          ),
          actions: [
            IconButton(
              icon: Icon(_modoEdicao ? Icons.check : Icons.edit),
              onPressed: () {
                if (_modoEdicao) {
                  _salvarFicha();
                } else {
                  setState(() => _modoEdicao = true);
                }
              },
            ),
          ],
          title: const Text(
            'Ficha do Bebê',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
        ),
        body: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _animatedSection(
                    index: 0,
                    child: _buildSection(
                      title: 'Dados Básicos',
                      children: [
                        _buildGeneroDropdown(),
                        _buildTextField('Nome do bebê', 'Seu nome preferido', nomeController),
                        _buildTextField('Idade (meses)', 'Ex: 6', idadeController),
                      ],
                    ),
                  ),
                  _animatedSection(
                    index: 1,
                    child: _buildSection(
                      title: 'Rotina e Hábitos',
                      children: [
                        _buildSimNao('O bebê dorme bem?', dormeBem, (v) => setState(() => dormeBem = v)),
                        _buildSimNao('Toma leite materno?', tomaLeiteMaterno, (v) => setState(() => tomaLeiteMaterno = v)),
                        _buildSimNao('Toma remédios regularmente?', tomaRemedios, (v) => setState(() => tomaRemedios = v)),
                        _buildTextField('Como é a rotina de sono?', 'Ex: cochilos, horário noturno', rotinaSonoController, maxLines: 3),
                        _buildTextField('Alimentação (horários, alimentos preferidos)', 'Descreva', alimentacaoController, maxLines: 3),
                      ],
                    ),
                  ),
                  _animatedSection(
                    index: 2,
                    child: _buildSection(
                      title: 'Saúde e Cuidados',
                      children: [
                        _buildTextField('Alergias', 'Ex: leite, ovo, etc.', alergiasController),
                        _buildTextField('Cuidados específicos', 'Observações médicas', cuidadosEspecificosController, maxLines: 3),
                      ],
                    ),
                  ),
                  _animatedSection(
                    index: 3,
                    child: _buildSection(
                      title: 'Responsáveis',
                      children: [
                        _buildTextField('Responsável 1 (nome)', 'Nome completo', responsavel1Controller),
                        _buildTextField('Responsável 2 (opcional)', 'Nome ou telefone', responsavel2Controller),
                      ],
                    ),
                  ),
                  _animatedSection(
                    index: 4,
                    child: _buildSection(
                      title: 'Vacinas',
                      children: [
                        _buildVacinaCheck('BCG', vacinaBCG, (v) => setState(() => vacinaBCG = v)),
                        _buildVacinaCheck('Hepatite B', vacinaHepatiteB, (v) => setState(() => vacinaHepatiteB = v)),
                        _buildVacinaCheck('Pentavalente', vacinaPentavalente, (v) => setState(() => vacinaPentavalente = v)),
                        _buildVacinaCheck('Poliomielite', vacinaPolio, (v) => setState(() => vacinaPolio = v)),
                        _buildVacinaCheck('Rotavírus', vacinaRotavirus, (v) => setState(() => vacinaRotavirus = v)),
                      ],
                    ),
                  ),
                  _animatedSection(
                    index: 5,
                    child: _buildSection(
                      title: 'Marcos de Desenvolvimento',
                      children: [
                        _buildMarcoCheck('Engatinha', marcoEngatinha, (v) => setState(() => marcoEngatinha = v)),
                        _buildMarcoCheck('Sustenta a cabeça', marcoSustentaCabeca, (v) => setState(() => marcoSustentaCabeca = v)),
                        _buildMarcoCheck('Sorri socialmente', marcoSorri, (v) => setState(() => marcoSorri = v)),
                        _buildMarcoCheck('Balbucia sons', marcoBalbucia, (v) => setState(() => marcoBalbucia = v)),
                      ],
                    ),
                  ),
                  _animatedSection(index: 6, child: _buildMiniManualAnimated()),
                  const SizedBox(height: 30),
                ],
              ),
            ),
            if (_loading)
              Positioned.fill(
                child: Container(
                  color: Colors.black.withOpacity(0.25),
                  child: const Center(child: CircularProgressIndicator()),
                ),
              ),
          ],
        ),
      ),
    );
  }

  // ---------------- Widgets auxiliares ----------------
  Widget _buildSection({required String title, required List<Widget> children}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8, offset: const Offset(0, 3))],
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: temaAtual.computeLuminance() > 0.5 ? Colors.black87 : Colors.white)),
        const SizedBox(height: 12),
        ...children,
      ]),
    );
  }

  Widget _buildGeneroDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Gênero do bebê', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
        const SizedBox(height: 8),
        AnimatedScale(
          scale: _dropdownScale,
          duration: const Duration(milliseconds: 180),
          curve: Curves.easeOutBack,
          child: DropdownButtonFormField<String>(
            value: generoSelecionado,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            ),
            items: const [
              DropdownMenuItem(value: 'Menino', child: Text('Menino')),
              DropdownMenuItem(value: 'Menina', child: Text('Menina')),
              DropdownMenuItem(value: 'Outro', child: Text('Outro / Não definido')),
            ],
            onChanged: _modoEdicao ? _atualizarTemaPorGenero : null,
          ),
        ),
      ],
    );
  }

  Widget _buildTextField(String label, String hint, TextEditingController controller, {int maxLines = 1}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(label, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          maxLines: maxLines,
          enabled: _modoEdicao,
          decoration: InputDecoration(
            hintText: hint,
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          ),
        ),
      ]),
    );
  }

  Widget _buildSimNao(String pergunta, String? valorSelecionado, Function(String?) onChanged) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(pergunta, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
        Row(children: [
          Expanded(child: RadioListTile<String>(title: const Text('Sim'), value: 'Sim', groupValue: valorSelecionado, onChanged: _modoEdicao ? onChanged : null, activeColor: temaAtual.computeLuminance() > 0.5 ? Colors.black : Colors.white)),
          Expanded(child: RadioListTile<String>(title: const Text('Não'), value: 'Não', groupValue: valorSelecionado, onChanged: _modoEdicao ? onChanged : null, activeColor: temaAtual.computeLuminance() > 0.5 ? Colors.black : Colors.white)),
        ])
      ]),
    );
  }

  Widget _buildVacinaCheck(String label, bool value, Function(bool) onChanged) {
    return CheckboxListTile(
      title: Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
      value: value,
      onChanged: _modoEdicao ? (v) => onChanged(v ?? false) : null,
      activeColor: temaAtual,
      controlAffinity: ListTileControlAffinity.leading,
    );
  }

  Widget _buildMarcoCheck(String label, bool value, Function(bool) onChanged) {
    return CheckboxListTile(
      title: Text(label),
      value: value,
      onChanged: _modoEdicao ? (v) => onChanged(v ?? false) : null,
      activeColor: temaAtual,
      controlAffinity: ListTileControlAffinity.leading,
    );
  }

  Widget _buildMiniManualAnimated() {
    return AnimatedCrossFade(
      firstChild: _buildMiniManualHeader(),
      secondChild: _buildMiniManualFull(),
      crossFadeState: _manualExpanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
      duration: const Duration(milliseconds: 300),
      firstCurve: Curves.easeOut,
      secondCurve: Curves.easeIn,
      sizeCurve: Curves.easeInOut,
    );
  }

  Widget _buildMiniManualHeader() {
    return InkWell(
      onTap: () => setState(() => _manualExpanded = true),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8, offset: const Offset(0, 3))]),
        child: Row(children: [
          Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: temaAtual.withOpacity(0.2), borderRadius: BorderRadius.circular(8)), child: Icon(Icons.favorite, color: temaAtual.computeLuminance() > 0.5 ? Colors.black : Colors.white)),
          const SizedBox(width: 12),
          const Expanded(child: Text('Mini Manual de Cuidados', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),
          const Icon(Icons.keyboard_arrow_down),
        ]),
      ),
    );
  }

  Widget _buildMiniManualFull() {
    return InkWell(
      onTap: () => setState(() => _manualExpanded = false),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8, offset: const Offset(0, 3))]),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: const [
          Text('Mini Manual de Cuidados', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          Text('1. Mantenha o bebê sempre limpo e seco.'),
          Text('2. Respeite os horários de sono e cochilos.'),
          Text('3. Amamente conforme orientação do pediatra ou fórmula adequada.'),
          Text('4. Observe sinais de alergias ou desconforto após alimentação.'),
          Text('5. Estimule movimentos: engatinhar, rolar, sentar com apoio.'),
          Text('6. Use fraldas limpas e troque regularmente.'),
          Text('7. Verifique e atualize vacinas conforme calendário.'),
          Text('8. Fique atento ao desenvolvimento: sorriso, balbucio, engatinhar.'),
          SizedBox(height: 6),
          Text('Toque neste card para fechar o manual.', style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic)),
        ]),
      ),
    );
  }
}

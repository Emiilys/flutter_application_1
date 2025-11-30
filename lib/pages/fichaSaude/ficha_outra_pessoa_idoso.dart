import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FichaOutraPessoaIdosoPage extends StatefulWidget {
  const FichaOutraPessoaIdosoPage({super.key});

  @override
  State<FichaOutraPessoaIdosoPage> createState() => _FichaOutraPessoaIdosoPageState();
}

class _FichaOutraPessoaIdosoPageState extends State<FichaOutraPessoaIdosoPage> {
  //  controladores 
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController idadeController = TextEditingController();
  final TextEditingController condicoesController = TextEditingController();
  final TextEditingController rotinaController = TextEditingController();
  final TextEditingController medicacoesController = TextEditingController();
  final TextEditingController cuidadosController = TextEditingController();
  final TextEditingController responsavel1Controller = TextEditingController();
  final TextEditingController responsavel2Controller = TextEditingController();

  //  UI 
  final Color temaVioleta = const Color(0xFF9C27B0); // Cor fixa violeta
  bool _modoEdicao = false; // Começa em visualização
  bool _manualExpanded = false;
  final int _sectionAnimationDuration = 350;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _carregarFicha();
  }

  @override
  void dispose() {
    nomeController.dispose();
    idadeController.dispose();
    condicoesController.dispose();
    rotinaController.dispose();
    medicacoesController.dispose();
    cuidadosController.dispose();
    responsavel1Controller.dispose();
    responsavel2Controller.dispose();
    super.dispose();
  }

  //  firestore 
  Future<void> _carregarFicha() async {
    setState(() => _loading = true);
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) return;

      final doc = await FirebaseFirestore.instance
          .collection('fichas')
          .doc('fichaIdoso')
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
        condicoesController.text = data['condicoes'] ?? '';
        rotinaController.text = data['rotina'] ?? '';
        medicacoesController.text = data['medicacoes'] ?? '';
        cuidadosController.text = data['cuidados'] ?? '';
        responsavel1Controller.text = data['responsavel1'] ?? '';
        responsavel2Controller.text = data['responsavel2'] ?? '';
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao carregar ficha.')),
      );
    } finally {
      setState(() => _loading = false);
    }
  }

  Future<void> _salvarFicha() async {
    final Map<String, dynamic> ficha = {
      'nome': nomeController.text.trim(),
      'idade': idadeController.text.trim(),
      'condicoes': condicoesController.text.trim(),
      'rotina': rotinaController.text.trim(),
      'medicacoes': medicacoesController.text.trim(),
      'cuidados': cuidadosController.text.trim(),
      'responsavel1': responsavel1Controller.text.trim(),
      'responsavel2': responsavel2Controller.text.trim(),
      'ultimaAtualizacao': FieldValue.serverTimestamp(),
    };

    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) return;

      await FirebaseFirestore.instance
          .collection('fichas')
          .doc('fichaIdoso')
          .collection('usuarios')
          .doc(user.uid)
          .set(ficha, SetOptions(merge: true));

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Ficha do idoso salva com sucesso.')),
      );

      setState(() => _modoEdicao = false);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao salvar ficha.')),
      );
    }
  }

  //  helpers 
  Widget _animatedSection({required Widget child}) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: Duration(milliseconds: _sectionAnimationDuration),
      curve: Curves.easeOut,
      builder: (context, value, _) {
        final opacity = value;
        final translateY = (1 - value) * 12.0;
        return Opacity(
          opacity: opacity,
          child: Transform.translate(offset: Offset(0, translateY), child: child),
        );
      },
    );
  }

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
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: temaVioleta.computeLuminance() > 0.5 ? Colors.black87 : Colors.white,
          ),
        ),
        const SizedBox(height: 12),
        ...children,
      ]),
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
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8, offset: const Offset(0, 3))],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(color: temaVioleta.withOpacity(0.2), borderRadius: BorderRadius.circular(8)),
              child: Icon(Icons.favorite, color: temaVioleta.computeLuminance() > 0.5 ? Colors.black : Colors.white),
            ),
            const SizedBox(width: 12),
            const Expanded(child: Text('Mini Manual de Cuidados', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),
            const Icon(Icons.keyboard_arrow_down),
          ],
        ),
      ),
    );
  }

  Widget _buildMiniManualFull() {
    return InkWell(
      onTap: () => setState(() => _manualExpanded = false),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8, offset: const Offset(0, 3))],
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: const [
          Text('Mini Manual de Cuidados', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          Text('1. Mantenha o idoso sempre limpo e confortável.'),
          Text('2. Ajude na rotina de exercícios leves e alongamentos.'),
          Text('3. Administre medicações conforme prescrição.'),
          Text('4. Observe sinais de alterações físicas ou cognitivas.'),
          Text('5. Auxilie nas refeições e hidratação.'),
          Text('6. Garanta segurança em ambientes domésticos.'),
          Text('7. Promova atividades de socialização e lazer.'),
          SizedBox(height: 6),
          Text('Toque neste card para fechar o manual.', style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic)),
        ]),
      ),
    );
  }

  //  build 
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeInOut,
      color: temaVioleta.withOpacity(0.1),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: temaVioleta,
          elevation: 0,
          centerTitle: true,
          foregroundColor: Colors.white,
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
          title: const Text('Ficha do Idoso', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        ),
        body: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _animatedSection(
                    child: _buildSection(
                      title: 'Dados Básicos',
                      children: [
                        _buildTextField('Nome do idoso', 'Nome completo', nomeController),
                        _buildTextField('Idade', 'Ex: 70', idadeController),
                        _buildTextField('Condições especiais', 'Doenças ou limitações', condicoesController),
                      ],
                    ),
                  ),
                  _animatedSection(
                    child: _buildSection(
                      title: 'Rotina e Hábitos',
                      children: [
                        _buildTextField('Rotina diária', 'Ex: exercícios, horários', rotinaController, maxLines: 3),
                        _buildTextField('Medicações', 'Medicações atuais e horários', medicacoesController, maxLines: 3),
                        _buildTextField('Cuidados adicionais', 'Necessidades especiais', cuidadosController, maxLines: 3),
                      ],
                    ),
                  ),
                  _animatedSection(
                    child: _buildSection(
                      title: 'Responsáveis',
                      children: [
                        _buildTextField('Responsável 1 (nome/contato)', 'Nome ou telefone', responsavel1Controller),
                        _buildTextField('Responsável 2 (opcional)', 'Nome ou telefone', responsavel2Controller),
                      ],
                    ),
                  ),
                  _animatedSection(child: _buildMiniManualAnimated()),
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
}

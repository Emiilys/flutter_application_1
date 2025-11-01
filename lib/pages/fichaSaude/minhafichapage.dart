import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MinhaFichaPage extends StatefulWidget {
  final Map<String, String> usuarioLogado;

  const MinhaFichaPage({super.key, required this.usuarioLogado});

  @override
  State<MinhaFichaPage> createState() => _MinhaFichaPageState();
}

class _MinhaFichaPageState extends State<MinhaFichaPage> {
  final Color verdeEscuro = const Color(0xFF2E7D32);
  final Color azulEsverdeado = const Color(0xFF4DB6AC);

  final TextEditingController nomeController = TextEditingController();
  final TextEditingController idadeController = TextEditingController();
  final TextEditingController pesoController = TextEditingController();
  final TextEditingController alturaController = TextEditingController();

  String? pronomeSelecionado;
  String? generoSelecionado;
  String? frequenciaAtividade;
  String? qualidadeSono;
  String? alimentacao;
  String? frequenciaConteudo;

  bool? temCondicaoCronica;
  bool? fuma;
  bool? bebe;

  Map<String, bool> conteudosSelecionados = {
    "Dicas de saúde física": false,
    "Exercícios e meditação": false,
    "Aconselhamento emocional": false,
    "Notícias ou artigos sobre bem-estar": false,
    "Grupos e comunidades": false,
  };

  bool _editavel = true;
  bool _carregando = true;

  @override
  void initState() {
    super.initState();
    carregarFicha();
  }

  // 🔹 Agora a ficha é buscada em fichas/minhaFicha/usuarios/{uid}
  Future<void> carregarFicha() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) return;

      final doc = await FirebaseFirestore.instance
          .collection('fichas')
          .doc('minhaFicha')
          .collection('usuarios')
          .doc(user.uid)
          .get();

      if (doc.exists) {
        final data = doc.data();
        setState(() {
          nomeController.text = data?['nome'] ?? '';
          idadeController.text = data?['idade'] ?? '';
          pesoController.text = data?['peso'] ?? '';
          alturaController.text = data?['altura'] ?? '';

          pronomeSelecionado = data?['pronome'];
          generoSelecionado = data?['genero'];
          frequenciaAtividade = data?['frequenciaAtividade'];
          qualidadeSono = data?['qualidadeSono'];
          alimentacao = data?['alimentacao'];
          frequenciaConteudo = data?['frequenciaConteudo'];

          temCondicaoCronica = data?['temCondicaoCronica'];
          fuma = data?['fuma'];
          bebe = data?['bebe'];

          if (data?['conteudosSelecionados'] != null) {
            Map<String, dynamic> conteudos =
                Map<String, dynamic>.from(data!['conteudosSelecionados']);
            conteudosSelecionados.updateAll(
                (key, value) => conteudos[key] ?? false);
          }

          _editavel = false;
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao carregar ficha: $e')),
      );
    } finally {
      setState(() => _carregando = false);
    }
  }

  // 🔹 Agora salva em fichas/minhaFicha/usuarios/{uid}
  Future<void> salvarFicha() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) return;

      await FirebaseFirestore.instance
          .collection('fichas')
          .doc('minhaFicha')
          .collection('usuarios')
          .doc(user.uid)
          .set({
        'nome': nomeController.text.trim(),
        'idade': idadeController.text.trim(),
        'peso': pesoController.text.trim(),
        'altura': alturaController.text.trim(),
        'pronome': pronomeSelecionado,
        'genero': generoSelecionado,
        'frequenciaAtividade': frequenciaAtividade,
        'qualidadeSono': qualidadeSono,
        'alimentacao': alimentacao,
        'frequenciaConteudo': frequenciaConteudo,
        'temCondicaoCronica': temCondicaoCronica,
        'fuma': fuma,
        'bebe': bebe,
        'conteudosSelecionados': conteudosSelecionados,
        'ultimaAtualizacao': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));

      setState(() {
        _editavel = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Ficha salva com sucesso! ✅')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao salvar ficha: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_carregando) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Minha Ficha de Saúde",
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: azulEsverdeado,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildSection(
              title: "Dados Pessoais Básicos",
              children: [
                _buildTextField("Como gostaria de ser chamado?",
                    "Seu nome preferido", nomeController),
                _buildDropdown(
                  label: "Pronomes?",
                  hint: "Selecione os seus pronomes",
                  value: pronomeSelecionado,
                  items: ["Ele/Dele", "Ela/Dela", "Elu/Delu", "Prefiro não dizer"],
                  onChanged: _editavel
                      ? (v) => setState(() => pronomeSelecionado = v)
                      : null,
                ),
                _buildTextField(
                    "Qual a sua idade?", "Ex: 30", idadeController),
                _buildDropdown(
                  label: "Qual o seu gênero?",
                  hint: "Selecione",
                  value: generoSelecionado,
                  items: [
                    "Masculino",
                    "Feminino",
                    "Não-binário",
                    "Outro",
                    "Prefiro não dizer"
                  ],
                  onChanged: _editavel
                      ? (v) => setState(() => generoSelecionado = v)
                      : null,
                ),
                _buildTextField(
                    "Qual o seu peso atual? (kg)", "Ex: 70", pesoController),
                _buildTextField(
                    "Qual a sua altura? (cm)", "Ex: 170", alturaController),
                _buildSimNao(
                  "Você tem alguma condição médica crônica?",
                  valorSelecionado: temCondicaoCronica,
                  onChanged: (v) =>
                      _editavel ? setState(() => temCondicaoCronica = v) : null,
                ),
                _buildDropdown(
                  label: "Com que frequência você pratica atividade física?",
                  hint: "Selecione a frequência",
                  value: frequenciaAtividade,
                  items: [
                    "Sempre",
                    "Geralmente",
                    "Frequentemente",
                    "Às vezes",
                    "Ocasionalmente",
                    "Raramente"
                  ],
                  onChanged: _editavel
                      ? (v) => setState(() => frequenciaAtividade = v)
                      : null,
                ),
              ],
            ),
            const SizedBox(height: 20),
            _buildSection(
              title: "Hábitos e Estilo de Vida",
              children: [
                _buildDropdown(
                  label: "Como você classificaria a qualidade do seu sono?",
                  hint: "Selecione a qualidade",
                  value: qualidadeSono,
                  items: ["Ruim", "Moderada", "Boa", "Ótima"],
                  onChanged:
                      _editavel ? (v) => setState(() => qualidadeSono = v) : null,
                ),
                _buildSimNao(
                  "Você fuma ou usa algum tipo de cigarro?",
                  valorSelecionado: fuma,
                  onChanged: (v) =>
                      _editavel ? setState(() => fuma = v) : null,
                ),
                _buildSimNao(
                  "Consome bebidas alcoólicas?",
                  valorSelecionado: bebe,
                  onChanged: (v) =>
                      _editavel ? setState(() => bebe = v) : null,
                ),
                _buildDropdown(
                  label: "Qual sua alimentação predominante?",
                  hint: "Selecione sua alimentação",
                  value: alimentacao,
                  items: [
                    "Muito saudável",
                    "Equilibrada",
                    "Moderada",
                    "Pouco saudável",
                    "Não saudável"
                  ],
                  onChanged:
                      _editavel ? (v) => setState(() => alimentacao = v) : null,
                ),
              ],
            ),
            const SizedBox(height: 20),
            _buildSection(
              title: "Escolha as suas mensagens diárias",
              children: [
                Text(
                  "Que tipo de conteúdo você gostaria de ver no App? (selecione todos que quiser)",
                  style: GoogleFonts.poppins(
                    color: verdeEscuro,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                ...conteudosSelecionados.keys.map((key) {
                  return CheckboxListTile(
                    title: Text(key,
                        style: GoogleFonts.poppins(color: verdeEscuro)),
                    activeColor: azulEsverdeado,
                    value: conteudosSelecionados[key],
                    onChanged: _editavel
                        ? (v) =>
                            setState(() => conteudosSelecionados[key] = v ?? false)
                        : null,
                  );
                }).toList(),
                const SizedBox(height: 10),
                _buildDropdown(
                  label:
                      "Com que frequência você gostaria de receber os conteúdos?",
                  hint: "Selecione a frequência",
                  value: frequenciaConteudo,
                  items: [
                    "Todos os dias",
                    "A cada 2 dias",
                    "Semanalmente",
                    "A cada 15 dias",
                    "Mensalmente"
                  ],
                  onChanged: _editavel
                      ? (v) => setState(() => frequenciaConteudo = v)
                      : null,
                ),
              ],
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (_editavel)
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: azulEsverdeado,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 14),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                    ),
                    onPressed: salvarFicha,
                    child: Text(
                      "Salvar",
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                if (!_editavel)
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: azulEsverdeado,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 14),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                    ),
                    onPressed: () => setState(() => _editavel = true),
                    child: Text(
                      "Editar",
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
              ],
            )
          ],
        ),
      ),
    );
  }

  // ---------------- Widgets auxiliares ----------------
  Widget _buildSection({required String title, required List<Widget> children}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: azulEsverdeado, width: 2),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 6,
              offset: const Offset(0, 3)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.poppins(
              color: verdeEscuro,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          ...children,
        ],
      ),
    );
  }

  Widget _buildTextField(
      String label, String hint, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        controller: controller,
        enabled: _editavel,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          labelStyle: GoogleFonts.poppins(color: verdeEscuro),
          hintStyle: GoogleFonts.poppins(color: Colors.grey),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: azulEsverdeado),
            borderRadius: BorderRadius.circular(12),
          ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
    );
  }

  Widget _buildDropdown({
    required String label,
    required String hint,
    required List<String> items,
    required String? value,
    required void Function(String?)? onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          labelText: label,
          labelStyle: GoogleFonts.poppins(color: verdeEscuro),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: azulEsverdeado),
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        dropdownColor: Colors.white,
        hint: Text(hint, style: GoogleFonts.poppins(color: Colors.grey)),
        value: value,
        items:
            items.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
        onChanged: onChanged,
      ),
    );
  }

  Widget _buildSimNao(String pergunta,
      {required bool? valorSelecionado,
      required Function(bool) onChanged}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(pergunta,
              style: GoogleFonts.poppins(
                  color: verdeEscuro, fontWeight: FontWeight.w500)),
          Row(
            children: [
              Expanded(
                child: RadioListTile<bool>(
                  title: Text("Sim",
                      style: GoogleFonts.poppins(color: verdeEscuro)),
                  activeColor: azulEsverdeado,
                  value: true,
                  groupValue: valorSelecionado,
                  onChanged: _editavel ? (v) => onChanged(v!) : null,
                ),
              ),
              Expanded(
                child: RadioListTile<bool>(
                  title: Text("Não",
                      style: GoogleFonts.poppins(color: verdeEscuro)),
                  activeColor: azulEsverdeado,
                  value: false,
                  groupValue: valorSelecionado,
                  onChanged: _editavel ? (v) => onChanged(v!) : null,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

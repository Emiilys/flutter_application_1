import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MinhaFichaPage extends StatefulWidget {
  final Map<String, String> usuarioLogado;

  const MinhaFichaPage({super.key, required this.usuarioLogado});

  @override
  State<MinhaFichaPage> createState() => _MinhaFichaPageState();
}

class _MinhaFichaPageState extends State<MinhaFichaPage> {
  // Cores principais
  final Color verdeEscuro = const Color(0xFF2E7D32);
  final Color azulEsverdeado = const Color(0xFF4DB6AC);

  // Campos de seleção
  String? pronomeSelecionado;
  String? generoSelecionado;
  String? frequenciaAtividade;
  String? qualidadeSono;
  String? alimentacao;
  String? frequenciaConteudo;

  // Variáveis dos campos de Sim/Não
  bool? temCondicaoCronica;
  bool? fuma;
  bool? bebe;

  // Opções das checkboxes
  Map<String, bool> conteudosSelecionados = {
    "Dicas de saúde física": false,
    "Exercícios e meditação": false,
    "Aconselhamento emocional": false,
    "Notícias ou artigos sobre bem-estar": false,
    "Grupos e comunidades": false,
  };

  @override
  Widget build(BuildContext context) {
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
        elevation: 3,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildSection(
              title: "Dados Pessoais Básicos",
              children: [
                _buildTextField("Como gostaria de ser chamado?", "Seu nome preferido"),
                _buildDropdown(
                  label: "Pronomes?",
                  hint: "Selecione os seus pronomes",
                  value: pronomeSelecionado,
                  items: ["Ele/Dele", "Ela/Dela", "Elu/Delu", "Prefiro não dizer"],
                  onChanged: (v) => setState(() => pronomeSelecionado = v),
                ),
                _buildTextField("Qual a sua idade?", "Ex: 30"),
                _buildDropdown(
                  label: "Qual o seu gênero?",
                  hint: "Selecione",
                  value: generoSelecionado,
                  items: ["Masculino", "Feminino", "Não-binário", "Outro", "Prefiro não dizer"],
                  onChanged: (v) => setState(() => generoSelecionado = v),
                ),
                _buildTextField("Qual o seu peso atual? (kg)", "Ex: 70"),
                _buildTextField("Qual a sua altura? (cm)", "Ex: 170"),
                _buildSimNao(
                  "Você tem alguma condição médica crônica?",
                  valorSelecionado: temCondicaoCronica,
                  onChanged: (v) => setState(() => temCondicaoCronica = v),
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
                  onChanged: (v) => setState(() => frequenciaAtividade = v),
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
                  onChanged: (v) => setState(() => qualidadeSono = v),
                ),
                _buildSimNao(
                  "Você fuma ou usa algum tipo de cigarro?",
                  valorSelecionado: fuma,
                  onChanged: (v) => setState(() => fuma = v),
                ),
                _buildSimNao(
                  "Consome bebidas alcoólicas?",
                  valorSelecionado: bebe,
                  onChanged: (v) => setState(() => bebe = v),
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
                  onChanged: (v) => setState(() => alimentacao = v),
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
                    title: Text(key, style: GoogleFonts.poppins(color: verdeEscuro)),
                    activeColor: azulEsverdeado,
                    value: conteudosSelecionados[key],
                    onChanged: (v) {
                      setState(() => conteudosSelecionados[key] = v ?? false);
                    },
                  );
                }).toList(),
                const SizedBox(height: 10),
                _buildDropdown(
                  label: "Com que frequência você gostaria de receber os conteúdos?",
                  hint: "Selecione a frequência",
                  value: frequenciaConteudo,
                  items: [
                    "Todos os dias",
                    "A cada 2 dias",
                    "Semanalmente",
                    "A cada 15 dias",
                    "Mensalmente"
                  ],
                  onChanged: (v) => setState(() => frequenciaConteudo = v),
                ),
              ],
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: azulEsverdeado,
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                elevation: 3,
              ),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      "Ficha salva com sucesso! ✅",
                      style: GoogleFonts.poppins(color: Colors.white),
                    ),
                    backgroundColor: verdeEscuro,
                  ),
                );
              },
              child: Text(
                "Salvar e obter a Ficha de Saúde",
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ----- Widgets auxiliares -----

  Widget _buildSection({required String title, required List<Widget> children}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: azulEsverdeado, width: 2),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.grey.withOpacity(0.1), blurRadius: 6, offset: const Offset(0, 3)),
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

  Widget _buildTextField(String label, String hint) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
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
    required void Function(String?) onChanged,
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
        items: items.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
        onChanged: onChanged,
      ),
    );
  }

  Widget _buildSimNao(String pergunta,
      {required bool? valorSelecionado, required Function(bool) onChanged}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(pergunta, style: GoogleFonts.poppins(color: verdeEscuro, fontWeight: FontWeight.w500)),
          Row(
            children: [
              Expanded(
                child: RadioListTile<bool>(
                  title: Text("Sim", style: GoogleFonts.poppins(color: verdeEscuro)),
                  activeColor: azulEsverdeado,
                  value: true,
                  groupValue: valorSelecionado,
                  onChanged: (v) => onChanged(v!),
                ),
              ),
              Expanded(
                child: RadioListTile<bool>(
                  title: Text("Não", style: GoogleFonts.poppins(color: verdeEscuro)),
                  activeColor: azulEsverdeado,
                  value: false,
                  groupValue: valorSelecionado,
                  onChanged: (v) => onChanged(v!),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

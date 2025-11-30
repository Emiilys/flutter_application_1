import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  /// criar usuário principal
  Future<String> cadastrarUsuario({
    required String nomeCompleto,
    required String email,
    required String senha,
  }) async {
    final docRef = await _db.collection("usuarios").add({
      "nomeCompleto": nomeCompleto,
      "email": email,
      "senha": senha,
    });
    return docRef.id; // retorna o ID do usuário criado
  }

  /// login (busca no Firestore)
  Future<bool> login(String email, String senha) async {
    final query = await _db
        .collection("usuarios")
        .where("email", isEqualTo: email)
        .where("senha", isEqualTo: senha)
        .get();

    return query.docs.isNotEmpty;
  }

//subcolecoes

  Future<void> adicionarBemEstar(String usuarioId,
      {required String humorDiario,
      required String diarioPessoal,
      required List<String> metas}) async {
    await _db.collection("usuarios/$usuarioId/bemEstar").add({
      "humorDiario": humorDiario,
      "diarioPessoal": diarioPessoal,
      "metas": metas,
    });
  }

  Future<void> adicionarManualPrimeirosSocorros(String usuarioId) async {
    await _db
        .collection("usuarios/$usuarioId/manualPrimeirosSocorros")
        .add({});
  }

  Future<void> iniciarConversaChat(String usuarioId) async {
    await _db.collection("usuarios/$usuarioId/chat").add({
      "mensagens": [],
    });
  }

  Future<void> adicionarLembrete(String usuarioId,
      {required String descricao, required DateTime horario}) async {
    await _db.collection("usuarios/$usuarioId/lembrete").add({
      "descricao": descricao,
      "horario": Timestamp.fromDate(horario),
    });
  }

  Future<void> adicionarContatoEmergencia(String usuarioId,
      {required String nome, required String numero}) async {
    await _db.collection("usuarios/$usuarioId/contatoEmergencia").add({
      "nome": nome,
      "numero": numero,
    });
  }

  Future<void> adicionarMeta(String usuarioId,
      {required String descricao, required DateTime horario}) async {
    await _db.collection("usuarios/$usuarioId/meta").add({
      "descricao": descricao,
      "horario": Timestamp.fromDate(horario),
    });
  }

  Future<void> adicionarEnderecoImportante(String usuarioId,
      {required String endereco, required String categoria}) async {
    await _db.collection("usuarios/$usuarioId/endImportantes").add({
      "endereco": endereco,
      "categoria": categoria,
    });
  }

  Future<void> enviarNotificacao(String usuarioId,
      {required String mensagem, required String tipo}) async {
    await _db.collection("usuarios/$usuarioId/notificacao").add({
      "mensagem": mensagem,
      "tipo": tipo,
    });
  }

  Future<void> preencherFichaSaude(String usuarioId,
      {required String nomeCompleto,
      required int idade,
      required String contatoEmergencia,
      required String telefoneEmergencia,
      required String alergias,
      required String medicamentos,
      required String condicoesMedicas,
      required String observacoes,
      required List<String> lembretes}) async {
    await _db.collection("usuarios/$usuarioId/fichaSaude").add({
      "nomeCompleto": nomeCompleto,
      "idade": idade,
      "contatoEmergencia": contatoEmergencia,
      "telefoneEmergencia": telefoneEmergencia,
      "alergias": alergias,
      "medicamentos": medicamentos,
      "condicoesMedicas": condicoesMedicas,
      "observacoes": observacoes,
      "lembretes": lembretes,
    });
  }
}

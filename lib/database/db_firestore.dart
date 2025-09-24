import 'package:cloud_firestore/cloud_firestore.dart';

class DBFirestore {
  DBFirestore._(); //deixar privado pra tranformá-lo em um singleton
  static final DBFirestore _instance = DBFirestore._(); //pra poder recuperar a instância
  final FirebaseFirestore _firestore = FirebaseFirestore.instance; //recuperar a instância do firestore

  static get() {
    return DBFirestore._instance._firestore;
  }
}
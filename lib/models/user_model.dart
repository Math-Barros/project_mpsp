import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String nome;
  String cpf;
  String email;
  Timestamp timestamp;
  String uid;

  UserModel({this.nome, this.cpf, this.email, this.timestamp, this.uid});

  toMap() {
    return {
      'nome': nome,
      'cpf': cpf,
      'email': email,
      'uid': uid,
      'timestamp': FieldValue.serverTimestamp()
    };
  }

  factory UserModel.fromMap(Map map) {
    return UserModel(
      nome: map["nome"],
      cpf: map["cpf"],
      email: map["email"],
      timestamp: map["timestamp"],
      uid: map["uid"],
    );
  }
}

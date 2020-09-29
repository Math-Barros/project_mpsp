import 'dart:convert';

class UsuarioModel {
  int id;
  String nome;
  String email;
  String senha;
  int cpf;

  UsuarioModel({
    this.id,
    this.nome,
    this.email,
    this.senha,
    this.cpf,
  });

  factory UsuarioModel.fromJson(String str) =>
      UsuarioModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UsuarioModel.fromMap(Map<String, dynamic> json) => UsuarioModel(
        id: json["id"],
        nome: json["nome"],
        email: json["email"],
        senha: json["senha"],
        cpf: json["cpf"],
      );
  Map<String, dynamic> toMap() => {
        "id": id,
        "nome": nome,
        "email": email,
        "senha": senha,
        "cpf": cpf,
      };
}

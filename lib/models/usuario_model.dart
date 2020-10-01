import 'dart:convert';

class UsuarioModel {
  String cpf;
  String nome;
  String email;
  String senha;

  UsuarioModel({
    this.cpf,
    this.nome,
    this.email,
    this.senha,
  });

  factory UsuarioModel.fromJson(String str) =>
      UsuarioModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UsuarioModel.fromMap(Map<String, dynamic> json) => UsuarioModel(
        cpf: json["cpf"],
        nome: json["nome"],
        email: json["email"],
        senha: json["senha"],
      );

  Map<String, dynamic> toMap() => {
        "cpf": cpf,
        "nome": nome,
        "email": email,
        "senha": senha,
      };
}

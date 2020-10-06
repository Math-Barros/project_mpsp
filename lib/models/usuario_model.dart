import 'dart:convert';

class UsuarioModel {
  String cpf;
  String nome;
  String senha;
  String email;

  UsuarioModel({
    this.cpf,
    this.nome,
    this.senha,
    this.email,
  });

  factory UsuarioModel.fromJson(String str) =>
      UsuarioModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UsuarioModel.fromMap(Map<String, dynamic> json) => UsuarioModel(
        cpf: json["cpf"],
        nome: json["nome"],
        senha: json["senha"],
        email: json["email"],
      );

  Map<String, dynamic> toMap() => {
        "cpf": cpf,
        "nome": nome,
        "senha": senha,
        "email": email,
      };
}

import 'package:project_mpsp/database/database_helper.dart';
import 'package:project_mpsp/models/usuario_model.dart';

class UsuarioRepository {
  // Instancia do Database Helper
  DatabaseHelper _databaseHelper;

  // Construtor
  UsuarioRepository() {
    _databaseHelper = new DatabaseHelper();
  }

  Future<List<UsuarioModel>> findAll() async {
    var connection = await _databaseHelper.connection;
    var result = await connection.query(
      "UsuarioModel",
      columns: [
        "cpf",
        "nome",
        "email",
        "senha",
      ],
    );

    //Converte a lista de Maps para Lista de Cursos
    List<UsuarioModel> listaUsuarios = new List<UsuarioModel>();
    for (Map i in result) {
      listaUsuarios.add(UsuarioModel.fromMap(i));
    }

    return listaUsuarios;
  }

  Future<UsuarioModel> login(String cpf, String senha) async {
    var connection = await _databaseHelper.connection;
    var sqlCommand =
        "SELECT * FROM UsuarioModel WHERE rm = '$cpf' and senha = '$senha'";

    var results = await connection.rawQuery(sqlCommand);
    if (results.length > 0) {
      return new UsuarioModel.fromMap(results.first);
    } else {
      return null;
    }
  }

  Future<int> update(UsuarioModel usuarioModel) async {
    var connection = await _databaseHelper.connection;
    return await connection.update(
      "UsuarioModel",
      usuarioModel.toMap(),
      where: "cpf = ?",
      whereArgs: [usuarioModel.cpf],
    );
  }

  Future<int> create(UsuarioModel usuarioModel) async {
    var connection = await _databaseHelper.connection;

    var result = await connection.insert(
      "UsuarioModel",
      usuarioModel.toMap(),
    );
    return result;
  }
}

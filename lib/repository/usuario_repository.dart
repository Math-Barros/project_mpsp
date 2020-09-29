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
      columns: ["id", "cpf", "nome", "email", "senha"],
    );

    // Converte a lista de Maps para Lista de Alunos
    List<UsuarioModel> listaAlunos = new List<UsuarioModel>();
    for (Map i in result) {
      listaAlunos.add(UsuarioModel.fromMap(i));
    }

    return listaAlunos;
  }

  Future<int> create(UsuarioModel usuarioModel) async {
    var connection = await _databaseHelper.connection;
    var result = await connection.insert(
      "UsuarioModel",
      usuarioModel.toMap(),
    );
    return result;
  }

  Future<int> createRaw(UsuarioModel usuarioModel) async {
    var connection = await _databaseHelper.connection;
    var sqlCommand = " INSERT INTO UsuarioModel ( " +
        "  cpf , " +
        "  nome , " +
        "  email , " +
        "  senha ) " +
        "VALUES ( " +
        "    ${usuarioModel.cpf} , " +
        "    '${usuarioModel.nome}' " +
        "    '${usuarioModel.email}' " +
        "    '${usuarioModel.senha}' " +
        "  ) ";

    var result = await connection.rawInsert(sqlCommand);
    return result;
  }

  Future<UsuarioModel> get(int id) async {
    var connection = await _databaseHelper.connection;
    List<Map> results = await connection.query(
      "UsuarioModel",
      columns: ["id", "cpf", "nome", "email", "senha"],
      where: 'id = ?',
      whereArgs: [id],
    );

    if (results.length > 0) {
      return UsuarioModel.fromMap(
        results.first,
      );
    } else {
      return null;
    }
  }

  Future<UsuarioModel> getRaw(int id) async {
    var connection = await _databaseHelper.connection;
    var sqlCommand = "SELECT * FROM UsuarioModel WHERE ID = $id  ";

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
      where: "id = ?",
      whereArgs: [usuarioModel.id],
    );
  }

  Future<int> updateRaw(UsuarioModel usuarioModel) async {
    var connection = await _databaseHelper.connection;
    var sqlCommand = " UPDATE UsuarioModel SET  " +
        "  rm = ${usuarioModel.cpf} , " +
        "  nome = '${usuarioModel.nome}' , " +
        "  status = '${usuarioModel.email}' , " +
        "  status = '${usuarioModel.senha}' , " +
        " WHERE id = ${usuarioModel.id} ";

    var result = await connection.rawUpdate(sqlCommand);
    return result;
  }

  Future<void> delete(UsuarioModel usuarioModel) async {
    var connection = await _databaseHelper.connection;
    return await connection.delete(
      "UsuarioModel",
      where: "id = ?",
      whereArgs: [usuarioModel.id],
    );
  }

  Future<void> deleteRaw(UsuarioModel usuarioModel) async {
    var connection = await _databaseHelper.connection;
    var sqlCommand =
        " DELETE FROM UsuarioModel   " + " WHERE id = ${usuarioModel.id} ";

    var result = await connection.rawDelete(sqlCommand);
    return result;
  }
}

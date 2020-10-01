import 'package:path/path.dart';
import 'package:project_mpsp/models/usuario_model.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  // Instancia do SQFLite Database
  static Database _database;

  // Instancia da classe Helper
  static final DatabaseHelper _instance = DatabaseHelper._internal();

  // Fábrica de construtor
  factory DatabaseHelper() {
    return _instance;
  }

  // Construtor nomeado
  DatabaseHelper._internal();

  // Abre conexão com o banco
  Future<Database> get connection async {
    if (_database == null) {
      _database = await _createDatabase();
    }
    return _database;
  }

  Future<Database> _createDatabase() async {
    String databasesPath = await getDatabasesPath();
    String dbPath = join(databasesPath, 'portal_app.db');

    var database = await openDatabase(
      dbPath,
      version: 2,
      onCreate: _createTables,
    );

    return database;
  }

  void _createTables(Database database, int version) async {
    // Criando a tabela de Cursos
    await database.execute(
      '''
       CREATE TABLE  UsuarioModel(
        cpf TEXT PRIMARY KEY,
        nome TEXT,
        senha TEXT NOT NULL
      );
      ''',
    );

    await database.insert("UsuarioModel",
        new UsuarioModel(cpf: "123", nome: "Flavio", senha: "123").toMap());
    await database.insert("UsuarioModel",
        new UsuarioModel(cpf: "456", nome: "Pedro", senha: "123").toMap());
  }
}

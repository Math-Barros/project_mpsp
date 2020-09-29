import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

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
    String dbPath = join(databasesPath, 'acesso.db');

    var database = await openDatabase(
      dbPath,
      version: 1,
      onCreate: _createTables,
    );

    return database;
  }

  void _createTables(Database database, int version) async {
    // Criando as tabelas
    await database.execute(
      '''
      CREATE TABLE ProvaModel (
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        ano INTEGER,
        curso TEXT,
        turma TEXT,
        disciplina TEXT,
        data TEXT,
        tema TEXT
      )
      ''',
    );

    await database.execute(
      '''
      CREATE TABLE AlunoModel (
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        rm INTEGER,
        nome TEXT,
        status TEXT
      )
      ''',
    );
  }
}

import 'package:sqflite_common_ffi/sqflite_ffi.dart'; // Importez sqflite_ffi
import 'package:path/path.dart';

class DatabaseHelper {
  static Database? _database;

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  Future<Database> get database async {
    if (_database != null) return _database!;

    // Initialisez la fabrique de base de données avec sqflite_ffi
    sqfliteFfiInit();
    // Utilisez path.join pour obtenir le chemin du fichier de base de données
    String path = join(await getDatabasesPath(), 'token_db.db');
    // Ouvrez la base de données
    _database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      // Créez la structure de la base de données si elle n'existe pas
      await db
          .execute('CREATE TABLE tokens(id INTEGER PRIMARY KEY, token TEXT)');
    });
    return _database!;
  }

  // Méthode pour insérer un token dans la base de données
  Future<int> insertToken(String token) async {
    Database db = await database;
    return await db.insert('tokens', {'token': token});
  }

  // Méthode pour récupérer le premier token de la base de données
  Future<String?> getFirstToken() async {
    Database db = await database;
    List<Map<String, dynamic>> tokens = await db.query('tokens', limit: 1);
    if (tokens.isEmpty) {
      return null;
    }
    return tokens.first['token'];
  }

  // Méthode pour supprimer le premier token de la base de données
  Future<int> deleteFirstToken() async {
    Database db = await database;
    return await db.delete('tokens');
  }
}

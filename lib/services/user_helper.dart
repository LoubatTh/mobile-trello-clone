import 'package:dio/dio.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:path/path.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class DatabaseHelper {
  static Database? _database;
  final client = Dio();
  final apikey = dotenv.env['API_KEY'];
  final apiurl = dotenv.env['API_URL'];

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  /// Initialise et retourne la base de données.
  Future<Database> get database async {
    if (_database != null) return _database!;

    sqfliteFfiInit();
    String path = join(await getDatabasesPath(), 'user_db.db');

    _database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute(
          'CREATE TABLE user(id INTEGER PRIMARY KEY, userID TEXT, memberID TEXT, token TEXT, username TEXT)');
    });
    return _database!;
  }

  /// Remplit la base de données avec les informations du token.
  Future<void> fillDatabaseWithToken(String token) async {
    final db = await database;
    final url = '$apiurl/tokens/$token?key=$apikey&token=$token';
    final url_member =
        '$apiurl/members/me?key=$apikey&token=$token&fields=username';

    try {
      final response = await client.get(url);
      final response_member = await client.get(url_member);

      if (response.statusCode == 200 && response_member.statusCode == 200) {
        await db.insert('user', {
          'userID': response.data['id'],
          'memberID': response.data['idMember'],
          'token': token,
          'username': response_member.data['username'],
        });
        print("Informations ajoutées à la base de données");
        await printDatabase();
      } else {
        print('${response.statusCode} : ${response.data.toString()}');
        print(
            '${response_member.statusCode} : ${response_member.data.toString()}');
      }
    } catch (error) {
      print("Erreur lors de la récupération des données: $error");
    }
  }

  /// Récupère l'ID de l'utilisateur.
  Future<String?> getUserID() async {
    Database db = await database;
    List<Map<String, dynamic>> member = await db.query('user', limit: 1);
    if (member.isEmpty) {
      return null;
    }
    return member.first['userID'];
  }

  /// Récupère le memberID de l'utilisateur.
  Future<String?> getMemberID() async {
    Database db = await database;
    List<Map<String, dynamic>> member = await db.query('user', limit: 1);
    if (member.isEmpty) {
      return null;
    }
    return member.first['memberID'];
  }

  /// Récupère le token de l'utilisateur.
  Future<String?> getToken() async {
    Database db = await database;
    List<Map<String, dynamic>> member = await db.query('user', limit: 1);
    if (member.isEmpty) {
      print("Aucun token trouvé");
      return null;
    }
    return member.first['token'];
  }

  /// Supprime le membre de la base de données.
  Future<int> deleteDatabase() async {
    Database db = await database;
    return await db.delete('user');
  }

  /// Affiche les données de la base de données.
  Future<void> printDatabase() async {
    Database db = await database;
    List<Map<String, dynamic>> member = await db.query('user');
    print(member);
  }

  Future<void> printDatabaseColumns() async {
    Database database = await openDatabase(
      join(await getDatabasesPath(), 'user_db.db'),
    );

    List<Map<String, dynamic>> columns = await database.rawQuery(
      "PRAGMA table_info('user')",
    );

    print('Columns of the member table:');
    for (var column in columns) {
      print(column['name']);
    }
  }
}

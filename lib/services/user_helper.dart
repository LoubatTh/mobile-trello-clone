import 'package:dio/dio.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart'; // Importez sqflite_ffi
import 'package:path/path.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class DatabaseHelper {
  static Database? _database;
  final client = Dio();
  final apikey = dotenv.env['API_KEY'];

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  Future<Database> get database async {
    if (_database != null) return _database!;

    sqfliteFfiInit();
    String path = join(await getDatabasesPath(), 'member_db.db');
    _database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute(
          'CREATE TABLE member(id INTEGER PRIMARY KEY, userID TEXT, memberID TEXT)');
    });
    return _database!;
  }

  // Méthode pour récupérer l'ID de l'utilisateur et son memberID
  fillDatabaseWithToken(String token) async {
    final db = await database;
    final url =
        'https://api.trello.com/1/tokens/$token?key=$apikey&token=$token';

    try {
      final response = await client.get(url);

      if (response.statusCode == 200) {
        await db.insert('member', {
          'userID': response.data['id'],
          'memberID': response.data['idMember']
        });
        print("Informations added to database");
      } else {
        print('${response.statusCode} : ${response.data.toString()}');
      }
    } catch (error) {
      print(error);
    }
  }

  // Méthode pour récupérer le memberID de l'utilisateur
  Future<String?> getUserID() async {
    Database db = await database;
    List<Map<String, dynamic>> member = await db.query('member', limit: 1);
    if (member.isEmpty) {
      return null;
    }
    return member.first['userID'];
  }

  // Méthode pour récupérer le memberID de l'utilisateur
  Future<String?> getMemberID() async {
    Database db = await database;
    List<Map<String, dynamic>> member = await db.query('member', limit: 1);
    if (member.isEmpty) {
      return null;
    }
    return member.first['memberID'];
  }

  // Méthode pour supprimer le premier token de la base de données
  Future<int> deleteFirstToken() async {
    Database db = await database;
    return await db.delete('member');
  }

  // Méthode pour supprimer le membre de la base de données
  Future<int> deleteDatabase() async {
    Database db = await database;
    return await db.delete('member');
  }

  // Méthode pour print la base de données
  Future<void> printDatabase() async {
    Database db = await database;
    List<Map<String, dynamic>> member = await db.query('member');
    print(member);
  }
}

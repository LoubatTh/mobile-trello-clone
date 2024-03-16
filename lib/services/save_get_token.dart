import 'dart:async';

import 'package:app/models/token_model.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Open the database and store the reference.
  final database = openDatabase(
    join(await getDatabasesPath(), 'token_database.db'),
    // When the database is first created, create a table to store dogs.
    onCreate: (db, version) {
      // Run the CREATE TABLE statement on the database.
      return db.execute(
        'CREATE TABLE token_db(id INTEGER PRIMARY KEY, token TEXT)',
      );
    },
    version: 1,
  );

  Future<void> insertToken(TokenClass token) async {
    // Get a reference to the database.
    final db = await database;

    // Insert the Dog into the correct table. You might also specify the
    // `conflictAlgorithm` to use in case the same dog is inserted twice.
    //
    // In this case, replace any previous data.
    await db.insert(
      'token_db',
      token.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // A method that retrieves all the dogs from the dogs table.
  Future<List<TokenClass>> getToken() async {
    // Get a reference to the database.
    final db = await database;

    // Query the table for all the dogs.
    final List<Map<String, Object?>> token = await db.query('token_db');

    // Convert the list of each dog's fields into a list of `Dog` objects.
    return [
      for (final {
            'id': id as int,
            'token': token as String,
          } in token)
        TokenClass(id: id, token: token),
    ];
  }

  Future<void> updateDog(Token token) async {
    // Get a reference to the database.
    final db = await database;

    // Update the given Dog.
    await db.update(
      'dogs',
      TokenClass.toMap(),
      // Ensure that the Dog has a matching id.
      where: 'id = ?',
      // Pass the Dog's id as a whereArg to prevent SQL injection.
      whereArgs: [dog.id],
    );
  }

  Future<void> deleteDog(int id) async {
    // Get a reference to the database.
    final db = await database;

    // Remove the Dog from the database.
    await db.delete(
      'dogs',
      // Use a `where` clause to delete a specific dog.
      where: 'id = ?',
      // Pass the Dog's id as a whereArg to prevent SQL injection.
      whereArgs: [id],
    );
  }

  // Create a Dog and add it to the dogs table
  var fido = Dog(
    id: 0,
    name: 'Fido',
    age: 35,
  );

  await insertDog(fido);

  // Now, use the method above to retrieve all the dogs.
  print(await dogs()); // Prints a list that include Fido.

  // Update Fido's age and save it to the database.
  fido = Dog(
    id: fido.id,
    name: fido.name,
    age: fido.age + 7,
  );
  await updateDog(fido);

  // Print the updated results.
  print(await dogs()); // Prints Fido with age 42.

  // Delete Fido from the database.
  await deleteDog(fido.id);

  // Print the list of dogs (empty).
  print(await dogs());
}

class TokenClass {
  final int id;
  final String token;

  TokenClass({
    required this.id,
    required this.token,
  });

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'token': token,
    };
  }
}

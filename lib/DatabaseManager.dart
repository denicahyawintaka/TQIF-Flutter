import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseManager {
  static final _dbName = "chatarsis.db";

  // Use this class as a singleton
  DatabaseManager._privateConstructor();

  static final DatabaseManager instance = DatabaseManager._privateConstructor();
  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    // Instantiate the database only when it's not been initialized yet.
    _database = await _initDatabase();
    return _database;
  }

  // Creates and opens the database.
  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _dbName);
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  // Creates the database structure
  Future _onCreate(
    Database db,
    int version,
  ) async {
    await db.execute('''
          CREATE TABLE Diary (
            id INTEGER PRIMARY KEY,
            content TEXT NOT NULL,
            emoticon TEXT NOT NULL,
            category TEXT NOT NULL,
            date TEXT NOT NULL
          )
          ''');
  }
}

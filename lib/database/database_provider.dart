import 'dart:async';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

final DB_NAME = "books";

class DatabaseProvider {
  static final DatabaseProvider dbProvider = DatabaseProvider();

  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await createDatabase();
    return _database;
  }

  createDatabase() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, "$DB_NAME.db");

    var theDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    return theDb;
  }

  void _onCreate(Database db, int version) async {
    await db.execute(
      "CREATE TABLE $DB_NAME (id INTEGER PRIMARY KEY, bookname TEXT, aboutbook TEXT)");
  }
}

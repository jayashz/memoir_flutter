import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart' as path;
import 'package:sqflite/sqlite_api.dart';
import 'package:sqflite/sqflite.dart' as sql;

Future<Database> getDataBase() async {
  final dbPath = await sql.getDatabasesPath();
  final db = await sql.openDatabase(path.join(dbPath, 'memories.db'),
      onCreate: (db, version) {
    return db.execute(
        'CREATE TABLE user_memories(id TEXT PRIMARY KEY, title TEXT, photo TEXT,lat REAL, lng REAL, address TEXT, description TEXT)');
  }, version: 1);

  return db;
}



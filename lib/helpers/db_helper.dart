import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static Future<Database> database() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(path.join(dbPath, 'places.db'),
        onCreate: (db, version) async {
      await db.execute(
          'CREATE TABLE places(id TEXT PRIMARY KEY,title TEXT,image TEXT,lat REAL,long REAL,address TEXT)');
    }, version: 1);
  }

  static Future<void> insert(String table, Map<String, Object> data) async {
    final sqlDb = await DBHelper.database();
    await sqlDb.insert(table, data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
  }

  static Future<List<Map<String,Object>>> getData(String table) async {
    final sqlDb = await DBHelper.database();
    return sqlDb.query(table);
  }
}

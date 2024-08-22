import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();

  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('key_value.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
    CREATE TABLE key_value(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      key TEXT NOT NULL,
      value TEXT NOT NULL
    )
    ''');
  }

  Future<List<Map<String, dynamic>>> getKeyValuePairs() async {
    final db = await instance.database;
    final result = await db.query('key_value');
    return result;
  }

  Future<void> insertKeyValue(Map<String, String> data) async {
    final db = await instance.database;
    await db.insert('key_value', data);
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}

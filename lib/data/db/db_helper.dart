import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  static const String dbName = "gorent.db";

  DbHelper._init();
  static final DbHelper instance = DbHelper._init();
  static Database? _database;

  factory DbHelper() {
    return instance;
  }

  Future<Database> get database async {
    _database = await _initDatabase(dbName);
    return _database!;
  }

  Future<Database> _initDatabase(String dbName) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, dbName);
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE users (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT NOT NULL,
      email TEXT NOT NULL UNIQUE,
      nik TEXT NOT NULL UNIQUE,
      address TEXT NOT NULL,
      phone TEXT NOT NULL,
      username TEXT NOT NULL UNIQUE,
      password TEXT NOT NULL
    )
    ''');

    await db.execute('''
    CREATE TABLE transactions (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      userId INTEGER NOT NULL,
      carId INTEGER NOT NULL,
      status TEXT CHECK(status IN ('aktif', 'selesai', 'dibatalkan')),
      pricePerDay INT NOT NULL,
      rentDays INTEGER NOT NULL,
      startDate TEXT NOT NULL,
      totalPrice INT NOT NULL,
      FOREIGN KEY (userId) REFERENCES users(id)
    )
    ''');
  }
}

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../Model/user_model.dart';

class DBService {
  static final DBService instance = DBService._init();
  static Database? _database;

  DBService._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('user.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

// Method to create the 'user' table
  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE user(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        userCode TEXT,
        displayName TEXT,
        email TEXT,
        employeeCode TEXT,
        companyCode TEXT
      )
    ''');
  }

 // Method to save a user record into the database
  Future<void> saveUser(User user) async {
    final db = await instance.database;
    await db.insert('user', user.toMap());
  }
  
 // Method to retrieve the first user record from the database
  Future<User?> getUser() async {
    final db = await instance.database;
    final maps = await db.query('user', limit: 1);

    if (maps.isNotEmpty) {
      return User.fromJson1(maps.first);
    }
    return null;
  }
}

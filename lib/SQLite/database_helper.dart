import 'package:auth_app/JSON/users.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Databasehelper {
  final databaseName = "auth.db";

  // Table creation SQL statement
  String user = '''
  CREATE TABLE users (
    usrId INTEGER PRIMARY KEY AUTOINCREMENT,
    fullName TEXT,
    email TEXT,
    usrName TEXT UNIQUE,
    usrPassword TEXT
  )
  ''';

  // Initialize the database
  Future<Database> initDB() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, databaseName);

    return openDatabase(path, version: 1, onCreate: (db, version) async {
      await db.execute(user);
    });
  }

  // Authentication method
  Future<bool> authenticate(Users usr) async {
    final Database db = await initDB();
    var result = await db.rawQuery(
        "SELECT * FROM users WHERE usrName = ? AND usrPassword = ?",
        [usr.usrName, usr.password]);
    return result.isNotEmpty;
  }

// Check if username exists
  Future<bool> userExists(String usrName) async {
    final Database db = await initDB();
    var result =
        await db.query("users", where: "usrName = ?", whereArgs: [usrName]);
    return result.isNotEmpty;
  }

  // Sign up method
  Future<int> createUser(Users usr) async {
    final Database db = await initDB();
    if (await userExists(usr.usrName)) {
      throw Exception("Username already exists");
    }
    return db.insert("users", usr.toMap());
  }

  // Get current user details
  Future<Users?> getUser(String usrName) async {
    final Database db = await initDB();
    var res =
        await db.query("users", where: "usrName = ?", whereArgs: [usrName]);
    return res.isNotEmpty ? Users.fromMap(res.first) : null;
  }
}

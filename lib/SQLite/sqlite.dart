// import 'dart:async';

// import 'package:flutter/widgets.dart';
// import 'package:path/path.dart';
// import 'package:sqflite/sqflite.dart';
// import 'package:flutter_application_1/JsonModels/users.dart';

// // Avoid errors caused by flutter upgrade.
// // Importing 'package:flutter/widgets.dart' is required.

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   // Open the database and store the reference.
//   final database = openDatabase(
//     // Set the path to the database. Note: Using the `join` function from the
//     // `path` package is best practice to ensure the path is correctly
//     // constructed for each platform.
//     join(await getDatabasesPath(), 'users.dart'),
//   );
// }

// class DatabaseHelper {
//   final databaseName = "notes.db";
//   String noteTable =
//       "CREATE TABLE notes (noteId INTEGER PRIMARY KEY AUTOINCREMENT)";

//   String users =
//       "create table users (usrId INTEGER PRIMARY KEY AUTOINCREMENT, usrName TEXT UNIQUE, usrPassword TEXT)";

//   Future<Database> initDB() async {
//     final databasePath = await getDatabasesPath();
//     final path = join(databasePath, databaseName);

//     return openDatabase(path, version: 1, onCreate: (db, version) async {
//       await db.execute (users);
//       await db.execute(noteTable);
//     });
//   }
// }

// Future<bool> login(Users user) async {
//   final Database db = await initDB();

//   var result = await db.rawQuery(
//       "SELECT * from users where usrName = '${user.usrName}' AND '${user.usrPassword}'");

//   if (result.isNotEmpty) {
//     return true;
//   } else {
//     return false;
//   }
// }

// Future<int> signup(Users user) async {
//   final Database db = await initDB();
//   return db.insert('users', user.toMap());
// }

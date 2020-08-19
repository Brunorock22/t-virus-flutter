import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> getDatabase() async {
  const int DATABASE_VERSION = 1;
  const String DATABASE_NAME = 't_virus_data';
  final String dbPath = await getDatabasesPath();

  final String path = join(dbPath, DATABASE_NAME);
  return openDatabase(
    path,
    onCreate: (db, version) {

      //Create table Survivor
      db.execute('CREATE TABLE survivor('
          'id INTEGER PRIMARY KEY,'
          'age INTEGER,'
          'autologin INTEGER,'
          'name TEXT,'
          'gender TEXT,'
          'location TEXT)');

      //Create table Supplie
      db.execute('CREATE TABLE supplie('
          'id INTEGER PRIMARY KEY,'
          'name TEXT,'
          'points INTEGER,'
          'survivorId INTEGER,'
          'quantity INTEGER)'
      );
    },
    version: DATABASE_VERSION,
  );
}

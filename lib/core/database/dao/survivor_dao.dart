import 'package:sqflite/sqflite.dart';
import 'package:t_virus/core/model/survivor.dart';

import '../app_database.dart';

class SurvivorDao {
  ///Sava a survivor in database
  static Future<int> save(Survivor survivor) async {
    String USER_TABLE = 'survivor';
    final Database db = await getDatabase();
    final Map<String, dynamic> userMap = Map();
    userMap["id"] = survivor.id;
    userMap["name"] = survivor.name;
    userMap["age"] = survivor.age;
    userMap["autologin"] = survivor.autologin;
    userMap["gender"] = survivor.gender.toString();
    userMap["location"] = survivor.location;
    return db.insert(USER_TABLE, userMap);
  }
  ///Update a survivor in database
  static Future<void> update(Survivor survivor) async {
    String USER_TABLE = 'survivor';
    // Get a reference to the database.
    final db = await getDatabase();
    await db.update(
      USER_TABLE,
      survivor.toMap(),
      where: "id = ?",
      // Pass the User's id as a whereArg to prevent SQL injection.
      whereArgs: [survivor.id],
    );
  }
  ///Find a survivor in database
  static Future<Survivor> findLast() async {
    String USER_TABLE = 'survivor';
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> result = await db.query(USER_TABLE);
    final List<Survivor> survivors = List();
    for (Map<String, dynamic> row in result) {
      final Survivor user = Survivor(
          id: row['id'],
          name: row['name'],
          age: row['age'],
          autologin: row['autologin'],
          gender: row['gender'],
          location: row['location']);
      survivors.add(user);
    }
    //return the last of the list
    return survivors[survivors.length -1];
  }

  static Future<void> delete(int id) async {
    String USER_TABLE = 'survivor';
    // Get a reference to the database.
    final db = await getDatabase();
    // Remove from the Database.
    await db.delete(
      USER_TABLE,
      // Use a `where` clause to delete a specific user.
      where: "id = ?",
      // Pass the User's id as a whereArg to prevent SQL injection.
      whereArgs: [id],
    );
  }
}

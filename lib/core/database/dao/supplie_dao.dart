import 'package:sqflite/sqflite.dart';
import 'package:t_virus/core/model/supplie.dart';

import '../app_database.dart';

class SupplieDao {
  ///Sava a supplie in database
  static Future<int> save(Supplie supplie) async {
    String SUPPLIE_TABLE = 'supplie';
    final Database db = await getDatabase();
    final Map<String, dynamic> userMap = Map();
    userMap["id"] = supplie.id;
    userMap["name"] = supplie.name;
    userMap["points"] = supplie.points;
    userMap["quantity"] = supplie.quantity;
    userMap["survivorId"] = supplie.survivorId;
    return db.insert(SUPPLIE_TABLE, userMap);
  }

  ///Update a supplie in database
  static Future<void> update(Supplie supplie) async {
    String SUPPLIE_TABLE = 'supplie';
    // Get a reference to the database.
    final db = await getDatabase();
    await db.update(
      SUPPLIE_TABLE,
      supplie.toMap(),
      where: "id = ?",
      // Pass the Supplie's id as a whereArg to prevent SQL injection.
      whereArgs: [supplie.id],
    );
  }

  ///Find a supplie in database
  static Future<List<Supplie>> findAll() async {
    String SUPPLIE_TABLE = 'supplie';
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> result = await db.query(SUPPLIE_TABLE);
    final List<Supplie> supplies = List();
    for (Map<String, dynamic> row in result) {
      final Supplie user = Supplie(
          id: row['id'],
          name: row['name'],
          points: row['points'],
          survivorId: row['survivorId'],
          quantity: row['quantity']);
      supplies.add(user);
    }
    //return the last of the list
    return supplies;
  }

  static Future<void> delete(int id) async {
    String SUPPLIE_TABLE = 'supplie';
    // Get a reference to the database.
    final db = await getDatabase();
    // Remove from the Database.
    await db.delete(
      SUPPLIE_TABLE,
      // Use a `where` clause to delete a specific user.
      where: "id = ?",
      // Pass the User's id as a whereArg to prevent SQL injection.
      whereArgs: [id],
    );
  }
}

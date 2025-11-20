import 'package:car_rent_app/data/db/db_helper.dart';
import 'package:car_rent_app/data/model/user.dart';

class UserDao {
  final dbHelper = DbHelper();

  Future<int> insertUser(User user) async {
    final db = await dbHelper.database;
    return await db.insert('users', user.toMap());
  }

  Future<User?> getUserById(int id) async {
    final db = await dbHelper.database;
    final result = await db.query('users', where: 'id = ?', whereArgs: [id]);
    if (result.isNotEmpty) {
      return User.fromMap(result.first);
    }
    return null;
  }

  Future<User?> getUserByUsername(String username) async {
    final db = await dbHelper.database;
    final result = await db.query(
      'users',
      where: 'username = ?',
      whereArgs: [username],
    );
    if (result.isNotEmpty) {
      return User.fromMap(result.first);
    }
    return null;
  }
}

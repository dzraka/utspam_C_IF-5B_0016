import 'package:car_rent_app/data/db/user_dao.dart';
import 'package:car_rent_app/data/model/user.dart';

class UserRepository {
  final userDao = UserDao();

  Future<int> registerUser(User user) async {
    return await userDao.insertUser(user);
  }

  Future<User?> getUserById(int id) async {
    return await userDao.getUserById(id);
  }

  Future<User?> getUserByUsername(String username) async {
    return await userDao.getUserByUsername(username);
  }

  Future<User?> login(String username, String password) async {
    final user = await userDao.getUserByUsername(username);

    if (user == null) return null;

    if (user.password == password) {
      return user;
    }

    return null;
  }
}

import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/db/database.dart';
import '../models/user_model.dart';

abstract class AuthLocalDataSource {
  Future<UserModel?> login(String email, String password);
  Future<void> register(UserModel user);
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final DatabaseHelper dbHelper;

  AuthLocalDataSourceImpl(this.dbHelper);

  @override
  Future<UserModel?> login(String email, String password) async {
    final db = await dbHelper.database;
    final result = await db.query(
      'users',
      where: 'email = ? AND password = ?',
      whereArgs: [email, password],
    );
    if (result.isNotEmpty) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('userEmail', email);
      return UserModel.fromJson(result.first);
    }
    return null;
  }

  @override
  Future<void> register(UserModel user) async {
    final db = await dbHelper.database;
    await db.insert('users', user.toJson());
  }
}

import '../../../../core/db/database.dart';
import '../../domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final DatabaseHelper databaseHelper;

  AuthRepositoryImpl(this.databaseHelper);

  @override
  Future<bool> login(String email, String password) async {
    final db = await databaseHelper.database;
    final result = await db.query(
      'users',
      where: 'email = ? AND password = ?',
      whereArgs: [email, password],
    );
    return result.isNotEmpty;
  }

  @override
  Future<bool> signUp(String email, String password) async {
    final db = await databaseHelper.database;

    final exists = await db.query(
      'users',
      where: 'email = ?',
      whereArgs: [email],
    );
    if (exists.isNotEmpty) return false;

    await db.insert('users', {'email': email, 'password': password});
    return true;
  }
}

import '../repositories/auth_repository.dart';

class SignUp {
  final AuthRepository repository;

  SignUp(this.repository);

  Future<bool> call(String email, String password) async {
    return await repository.signUp(email, password);
  }
}

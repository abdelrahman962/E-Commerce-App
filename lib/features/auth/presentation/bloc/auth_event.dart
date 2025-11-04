abstract class AuthEvent {}

class LoginButtonPressed extends AuthEvent {
  final String email;
  final String password;

  LoginButtonPressed(this.email, this.password);
}

class SignUpButtonPressed extends AuthEvent {
  final String email;
  final String password;

  SignUpButtonPressed(this.email, this.password);
}

class LogOutEvent extends AuthEvent {}

import 'package:flutter_bloc/flutter_bloc.dart';
import 'auth_event.dart';
import 'auth_state.dart';
import '../../domain/usecases/login.dart';
import '../../domain/usecases/signup.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final Login login;
  final SignUp signUp;

  AuthBloc({required this.login, required this.signUp}) : super(AuthInitial()) {
    on<LoginButtonPressed>(_onLogin);
    on<SignUpButtonPressed>(_onSignUp);
    on<LogOutEvent>(_onLogout);
  }

  Future<void> _onLogin(
    LoginButtonPressed event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      final success = await login(event.email, event.password);
      if (success) {
        emit(AuthAuthenticated(event.email));
      } else {
        emit(AuthError('Invalid email or password'));
      }
    } catch (e) {
      emit(AuthError('Login failed: ${e.toString()}'));
    }
  }

  Future<void> _onSignUp(
    SignUpButtonPressed event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      final success = await signUp(event.email, event.password);
      if (success) {
        emit(AuthAuthenticated(event.email));
      } else {
        emit(AuthError('Sign up failed: user already exists'));
      }
    } catch (e) {
      emit(AuthError('Sign up failed: ${e.toString()}'));
    }
  }

  Future<void> _onLogout(LogOutEvent event, Emitter<AuthState> emit) async {
    emit(AuthInitial());
  }
}

import 'package:equatable/equatable.dart';

class User extends Equatable {
  final int? id;
  final String email;
  final String password;

  const User({this.id, required this.email, required this.password});

  @override
  List<Object?> get props => [id, email, password];
}

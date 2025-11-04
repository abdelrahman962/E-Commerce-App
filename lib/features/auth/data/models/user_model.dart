import '../../domain/entities/user.dart';

class UserModel extends User {
  const UserModel({super.id, required super.email, required super.password});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as int?,
      email: json['email'] as String,
      password: json['password'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {if (id != null) 'id': id, 'email': email, 'password': password};
  }
}

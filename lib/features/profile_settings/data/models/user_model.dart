// lib/features/profile_settings/data/models/user_model.dart

import '../../domain/entities/user.dart';

class UserModel extends User {
  UserModel({
    required String id,
    required String name,
    required String email,
    // Tambahkan field lain sesuai kebutuhan
  }) : super(
          id: id,
          name: name,
          email: email,
          // Tambahkan field lain sesuai kebutuhan
        );

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      // Tambahkan field lain sesuai kebutuhan
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      // Tambahkan field lain sesuai kebutuhan
    };
  }
}

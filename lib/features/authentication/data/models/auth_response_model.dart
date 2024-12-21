// lib/features/authentication/data/models/auth_response_model.dart
import '../../domain/entities/auth_response.dart';

class AuthResponseModel extends AuthResponse {
  AuthResponseModel({
    required String token,
    required String userId,
    // Tambahkan field lain sesuai kebutuhan
  }) : super(
          token: token,
          userId: userId,
          // Tambahkan field lain sesuai kebutuhan
        );

  factory AuthResponseModel.fromJson(Map<String, dynamic> json) {
    return AuthResponseModel(
      token: json['token'],
      userId: json['user_id'],
      // Tambahkan field lain sesuai kebutuhan
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'token': token,
      'user_id': userId,
      // Tambahkan field lain sesuai kebutuhan
    };
  }
}

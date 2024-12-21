// lib/features/authentication/domain/entities/auth_response.dart
import 'package:equatable/equatable.dart';

class AuthResponse extends Equatable {
  final String token;
  final String userId;
  // Tambahkan field lain sesuai kebutuhan

  AuthResponse({
    required this.token,
    required this.userId,
    // Tambahkan field lain sesuai kebutuhan
  });

  @override
  List<Object?> get props => [token, userId];
}

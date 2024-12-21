// lib/features/profile_settings/domain/entities/user.dart
import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String name;
  final String email;
  // Tambahkan field lain sesuai kebutuhan

  User({
    required this.id,
    required this.name,
    required this.email,
    // Tambahkan field lain sesuai kebutuhan
  });

  @override
  List<Object?> get props => [id, name, email];
}

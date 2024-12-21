// lib/features/authentication/domain/repositories/auth_repository.dart
import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/auth_response.dart';

abstract class AuthRepository {
  Future<Either<Failure, AuthResponse>> login(String email, String password);
  Future<Either<Failure, AuthResponse>> register(String email, String password);
  Future<Either<Failure, void>> logout();
  Future<Either<Failure, AuthResponse>> checkAuthStatus();
}

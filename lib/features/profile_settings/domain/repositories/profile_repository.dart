// lib/features/profile_settings/domain/repositories/profile_repository.dart

import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/user.dart';

abstract class ProfileRepository {
  Future<Either<Failure, User>> getUserProfile();
  Future<Either<Failure, User>> updateUserProfile(User user);
  Future<Either<Failure, void>> changePassword(
      String oldPassword, String newPassword);
  Future<Either<Failure, void>> toggleTheme(
      bool isDarkMode); // Pastikan ini ada
}

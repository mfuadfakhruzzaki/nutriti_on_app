// lib/features/profile_settings/domain/usecases/change_password.dart
import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../repositories/profile_repository.dart';
import '../../../../core/usecases/usecase.dart';

class ChangePasswordUseCase implements UseCase<void, ChangePasswordParams> {
  final ProfileRepository repository;

  ChangePasswordUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(ChangePasswordParams params) async {
    return await repository.changePassword(
        params.oldPassword, params.newPassword);
  }
}

class ChangePasswordParams {
  final String oldPassword;
  final String newPassword;

  ChangePasswordParams({required this.oldPassword, required this.newPassword});
}

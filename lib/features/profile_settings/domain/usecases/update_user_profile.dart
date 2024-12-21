// lib/features/profile_settings/domain/usecases/update_user_profile.dart
import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/user.dart';
import '../repositories/profile_repository.dart';
import '../../../../core/usecases/usecase.dart';

class UpdateUserProfileUseCase
    implements UseCase<User, UpdateUserProfileParams> {
  final ProfileRepository repository;

  UpdateUserProfileUseCase(this.repository);

  @override
  Future<Either<Failure, User>> call(UpdateUserProfileParams params) async {
    return await repository.updateUserProfile(params.user);
  }
}

class UpdateUserProfileParams {
  final User user;

  UpdateUserProfileParams({required this.user});
}

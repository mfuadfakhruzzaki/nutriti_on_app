// lib/features/profile_settings/domain/usecases/get_user_profile.dart

import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/user.dart';
import '../repositories/profile_repository.dart';
import '../../../../core/usecases/usecase.dart';

class GetUserProfileUseCase implements UseCase<User, NoParams> {
  final ProfileRepository repository;

  GetUserProfileUseCase(this.repository);

  @override
  Future<Either<Failure, User>> call(NoParams params) async {
    return await repository.getUserProfile();
  }
}

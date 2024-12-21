// lib/features/authentication/domain/usecases/register_usecase.dart
import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/auth_response.dart';
import '../repositories/auth_repository.dart';
import '../../../../core/usecases/usecase.dart';

class RegisterUseCase implements UseCase<AuthResponse, RegisterParams> {
  final AuthRepository repository;

  RegisterUseCase(this.repository);

  @override
  Future<Either<Failure, AuthResponse>> call(RegisterParams params) async {
    return await repository.register(params.email, params.password);
  }
}

class RegisterParams {
  final String email;
  final String password;

  RegisterParams({required this.email, required this.password});
}

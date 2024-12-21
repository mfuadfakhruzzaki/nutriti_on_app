// lib/features/authentication/domain/usecases/check_auth_status_usecase.dart
import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/auth_response.dart';
import '../repositories/auth_repository.dart';
import '../../../../core/usecases/usecase.dart';

class CheckAuthStatusUseCase implements UseCase<AuthResponse, NoParams> {
  final AuthRepository repository;

  CheckAuthStatusUseCase(this.repository);

  @override
  Future<Either<Failure, AuthResponse>> call(NoParams params) async {
    // Implementasi ini tergantung pada bagaimana Anda menentukan status autentikasi
    // Misalnya, membaca token dari storage dan mengembalikan AuthResponse jika token valid
    // atau mengembalikan Failure jika token tidak valid atau tidak ada
    // Anda bisa menyesuaikan implementasinya sesuai kebutuhan
    return await repository.checkAuthStatus();
  }
}

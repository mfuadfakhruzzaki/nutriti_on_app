// lib/features/profile_settings/domain/usecases/toggle_theme.dart

import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../repositories/profile_repository.dart';
import '../../../../core/usecases/usecase.dart';

class ToggleThemeUseCase implements UseCase<void, ToggleThemeParams> {
  final ProfileRepository repository;

  ToggleThemeUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(ToggleThemeParams params) async {
    return await repository.toggleTheme(params.isDarkMode);
  }
}

class ToggleThemeParams {
  final bool isDarkMode;

  ToggleThemeParams({required this.isDarkMode});
}

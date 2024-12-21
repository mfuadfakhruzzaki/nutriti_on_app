// lib/features/child/domain/usecases/update_child.dart
import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/child.dart';
import '../repositories/child_repository.dart';
import '../../../../core/usecases/usecase.dart';

class UpdateChildUseCase implements UseCase<Child, UpdateChildParams> {
  final ChildRepository repository;

  UpdateChildUseCase(this.repository);

  @override
  Future<Either<Failure, Child>> call(UpdateChildParams params) async {
    return await repository.updateChild(params.child);
  }
}

class UpdateChildParams {
  final Child child;

  UpdateChildParams({required this.child});
}

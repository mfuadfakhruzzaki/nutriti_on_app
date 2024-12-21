// lib/features/child/domain/usecases/add_child.dart
import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/child.dart';
import '../repositories/child_repository.dart';
import '../../../../core/usecases/usecase.dart';

class AddChildUseCase implements UseCase<Child, AddChildParams> {
  final ChildRepository repository;

  AddChildUseCase(this.repository);

  @override
  Future<Either<Failure, Child>> call(AddChildParams params) async {
    return await repository.addChild(params.child);
  }
}

class AddChildParams {
  final Child child;

  AddChildParams({required this.child});
}

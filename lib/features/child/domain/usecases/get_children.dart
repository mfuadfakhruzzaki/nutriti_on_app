// lib/features/child/domain/usecases/get_children.dart
import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/child.dart';
import '../repositories/child_repository.dart';
import '../../../../core/usecases/usecase.dart';

class GetChildrenUseCase implements UseCase<List<Child>, NoParams> {
  final ChildRepository repository;

  GetChildrenUseCase(this.repository);

  @override
  Future<Either<Failure, List<Child>>> call(NoParams params) async {
    return await repository.getChildren();
  }
}

// lib/features/child/domain/usecases/delete_child.dart
import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../repositories/child_repository.dart';
import '../../../../core/usecases/usecase.dart';

class DeleteChildUseCase implements UseCase<void, DeleteChildParams> {
  final ChildRepository repository;

  DeleteChildUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(DeleteChildParams params) async {
    return await repository.deleteChild(params.id);
  }
}

class DeleteChildParams {
  final String id;

  DeleteChildParams({required this.id});
}

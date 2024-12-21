// lib/features/child/domain/repositories/child_repository.dart
import 'package:dartz/dartz.dart';
import '../entities/child.dart';
import '../../../../core/error/failures.dart';

abstract class ChildRepository {
  Future<Either<Failure, List<Child>>> getChildren();
  Future<Either<Failure, Child>> addChild(Child child);
  Future<Either<Failure, Child>> updateChild(Child child);
  Future<Either<Failure, void>> deleteChild(String id);
}

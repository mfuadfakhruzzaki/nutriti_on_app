// lib/core/usecases/usecase.dart
import 'package:dartz/dartz.dart';
import '../error/failures.dart';

/// Abstraksi dasar untuk Use Cases.
abstract class UseCase<Type, Params> {
  /// Method yang harus diimplementasikan oleh setiap Use Case.
  Future<Either<Failure, Type>> call(Params params);
}

/// Kelas kosong yang digunakan ketika Use Case tidak memerlukan parameter.
class NoParams {}

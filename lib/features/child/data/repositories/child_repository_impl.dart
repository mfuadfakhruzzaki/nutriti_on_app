// lib/features/child/data/repositories/child_repository_impl.dart
import 'package:dartz/dartz.dart';

import '../../../../core/network/network_info.dart';
import '../../domain/entities/child.dart';
import '../../domain/repositories/child_repository.dart';
import '../datasources/child_remote_data_source.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';

class ChildRepositoryImpl implements ChildRepository {
  final ChildRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  ChildRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<Child>>> getChildren() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteChildren = await remoteDataSource.getChildren();
        return Right(remoteChildren);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, Child>> addChild(Child child) async {
    if (await networkInfo.isConnected) {
      try {
        final childModel = await remoteDataSource.addChild(child as dynamic);
        return Right(childModel);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, Child>> updateChild(Child child) async {
    if (await networkInfo.isConnected) {
      try {
        final childModel = await remoteDataSource.updateChild(child as dynamic);
        return Right(childModel);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, void>> deleteChild(String id) async {
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.deleteChild(id);
        return Right(null);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ConnectionFailure());
    }
  }
}

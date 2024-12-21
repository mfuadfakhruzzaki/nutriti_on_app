// lib/features/profile_settings/data/repositories/profile_repository_impl.dart

import 'package:dartz/dartz.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../domain/entities/user.dart';
import '../../domain/repositories/profile_repository.dart';
import '../datasources/profile_remote_data_source.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;
  final FlutterSecureStorage secureStorage;

  ProfileRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
    required this.secureStorage,
  });

  @override
  Future<Either<Failure, User>> getUserProfile() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteUser = await remoteDataSource.getUserProfile();
        return Right(remoteUser);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, User>> updateUserProfile(User user) async {
    if (await networkInfo.isConnected) {
      try {
        final updatedUser = await remoteDataSource.updateUserProfile(user);
        return Right(updatedUser);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, void>> changePassword(
      String oldPassword, String newPassword) async {
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.changePassword(oldPassword, newPassword);
        return Right(null);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, void>> toggleTheme(bool isDarkMode) async {
    try {
      await secureStorage.write(
          key: 'theme', value: isDarkMode ? 'dark' : 'light');
      return Right(null);
    } catch (e) {
      return Left(CacheFailure());
    }
  }
}

// lib/features/authentication/data/repositories/auth_repository_impl.dart
import 'package:dartz/dartz.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_data_source.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/auth_response.dart';
import '../../../../core/network/network_info.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;
  final FlutterSecureStorage secureStorage;

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
    required this.secureStorage,
  });

  @override
  Future<Either<Failure, AuthResponse>> login(
      String email, String password) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteAuth = await remoteDataSource.login(email, password);
        // Simpan token dan userId di FlutterSecureStorage
        await secureStorage.write(key: 'token', value: remoteAuth.token);
        await secureStorage.write(key: 'userId', value: remoteAuth.userId);
        return Right(remoteAuth);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, AuthResponse>> register(
      String email, String password) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteAuth = await remoteDataSource.register(email, password);
        // Simpan token dan userId di FlutterSecureStorage
        await secureStorage.write(key: 'token', value: remoteAuth.token);
        await secureStorage.write(key: 'userId', value: remoteAuth.userId);
        return Right(remoteAuth);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource
            .logout(); // Implementasikan metode logout di RemoteDataSource jika diperlukan
        await secureStorage.delete(key: 'token');
        await secureStorage.delete(key: 'userId');
        return Right(null);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, AuthResponse>> checkAuthStatus() async {
    final token = await secureStorage.read(key: 'token');
    final userId = await secureStorage.read(key: 'userId');
    if (token != null && userId != null) {
      // Jika Anda memiliki endpoint untuk memvalidasi token atau mendapatkan kembali data pengguna
      try {
        final remoteAuth = await remoteDataSource.getAuthStatus(token);
        return Right(remoteAuth);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(CacheFailure());
    }
  }
}

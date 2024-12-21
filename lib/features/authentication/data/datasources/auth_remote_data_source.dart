// lib/features/authentication/data/datasources/auth_remote_data_source.dart
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/auth_response_model.dart';
import '../../../../core/error/exceptions.dart';

abstract class AuthRemoteDataSource {
  /// Calls the login endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<AuthResponseModel> login(String email, String password);

  /// Calls the register endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<AuthResponseModel> register(String email, String password);

  /// Calls the logout endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<void> logout();

  /// Calls the auth status endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<AuthResponseModel> getAuthStatus(String token);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final http.Client client;

  AuthRemoteDataSourceImpl({required this.client});

  @override
  Future<AuthResponseModel> login(String email, String password) async {
    final response = await client.post(
      Uri.parse(
          'https://api.nutriti-on.com/login'), // Ganti dengan endpoint API Anda
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      return AuthResponseModel.fromJson(jsonDecode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<AuthResponseModel> register(String email, String password) async {
    final response = await client.post(
      Uri.parse(
          'https://api.nutriti-on.com/register'), // Ganti dengan endpoint API Anda
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    if (response.statusCode == 201) {
      return AuthResponseModel.fromJson(jsonDecode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<void> logout() async {
    // Jika API Anda memerlukan token untuk logout, pastikan untuk menambahkannya di headers
    // Misalnya:
    /*
    final token = await secureStorage.read(key: 'token');
    final response = await client.post(
      Uri.parse('https://api.nutriti-on.com/logout'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode != 200) {
      throw ServerException();
    }
    */
    // Jika logout tidak memerlukan panggilan API, cukup hapus token di repository
    // Namun, dalam implementasi repository di atas, kita menghapus token secara lokal
    // Jadi, jika tidak ada panggilan API yang diperlukan, Anda bisa membiarkan metode ini kosong
  }

  @override
  Future<AuthResponseModel> getAuthStatus(String token) async {
    final response = await client.get(
      Uri.parse(
          'https://api.nutriti-on.com/auth-status'), // Ganti dengan endpoint API Anda
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      return AuthResponseModel.fromJson(jsonDecode(response.body));
    } else {
      throw ServerException();
    }
  }
}

// lib/features/profile_settings/data/datasources/profile_remote_data_source.dart

import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/user_model.dart';
import '../../../../core/error/exceptions.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class ProfileRemoteDataSource {
  /// Calls the get user profile endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<UserModel> getUserProfile();

  /// Calls the update user profile endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<UserModel> updateUserProfile(UserModel user);

  /// Calls the change password endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<void> changePassword(String oldPassword, String newPassword);
}

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final http.Client client;
  final String baseUrl;
  final FlutterSecureStorage secureStorage;

  ProfileRemoteDataSourceImpl({
    required this.client,
    this.baseUrl = 'https://api.nutriti-on.com',
    required this.secureStorage,
  });

  @override
  Future<UserModel> getUserProfile() async {
    final token = await _getToken();
    final response = await client.get(
      Uri.parse('$baseUrl/profile'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      return UserModel.fromJson(jsonDecode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<UserModel> updateUserProfile(UserModel user) async {
    final token = await _getToken();
    final response = await client.put(
      Uri.parse('$baseUrl/profile'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(user.toJson()),
    );

    if (response.statusCode == 200) {
      return UserModel.fromJson(jsonDecode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<void> changePassword(String oldPassword, String newPassword) async {
    final token = await _getToken();
    final response = await client.post(
      Uri.parse('$baseUrl/change-password'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({
        'old_password': oldPassword,
        'new_password': newPassword,
      }),
    );

    if (response.statusCode != 200) {
      throw ServerException();
    }
  }

  Future<String> _getToken() async {
    final token = await secureStorage.read(key: 'token');
    if (token == null || token.isEmpty) {
      throw ServerException(); // Atau gunakan exception lain sesuai kebutuhan
    }
    return token;
  }
}

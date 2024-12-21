// lib/features/child/data/datasources/child_remote_data_source.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../data/models/child_model.dart';
import '../../../../core/error/exceptions.dart';

abstract class ChildRemoteDataSource {
  Future<List<ChildModel>> getChildren();
  Future<ChildModel> addChild(ChildModel child);
  Future<ChildModel> updateChild(ChildModel child);
  Future<void> deleteChild(String id);
}

class ChildRemoteDataSourceImpl implements ChildRemoteDataSource {
  final http.Client client;

  ChildRemoteDataSourceImpl({required this.client});

  @override
  Future<List<ChildModel>> getChildren() async {
    final response = await client.get(
      Uri.parse(
          'https://api.nutriti-on.com/children'), // Ganti dengan endpoint API Anda
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = jsonDecode(response.body);
      return jsonList.map((json) => ChildModel.fromJson(json)).toList();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<ChildModel> addChild(ChildModel child) async {
    final response = await client.post(
      Uri.parse(
          'https://api.nutriti-on.com/children'), // Ganti dengan endpoint API Anda
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(child.toJson()),
    );

    if (response.statusCode == 201) {
      return ChildModel.fromJson(jsonDecode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<void> deleteChild(String id) async {
    final response = await client.delete(
      Uri.parse(
          'https://api.nutriti-on.com/children/$id'), // Ganti dengan endpoint API Anda
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode != 204) {
      throw ServerException();
    }
  }

  @override
  Future<ChildModel> updateChild(ChildModel child) async {
    final response = await client.put(
      Uri.parse(
          'https://api.nutriti-on.com/children/${child.id}'), // Ganti dengan endpoint API Anda
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(child.toJson()),
    );

    if (response.statusCode == 200) {
      return ChildModel.fromJson(jsonDecode(response.body));
    } else {
      throw ServerException();
    }
  }
}

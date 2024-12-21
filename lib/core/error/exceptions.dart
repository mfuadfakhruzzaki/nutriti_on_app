// lib/core/error/exceptions.dart

/// Exception yang dilempar saat terjadi kesalahan di server atau API.
class ServerException implements Exception {}

/// Exception yang dilempar saat terjadi kesalahan di penyimpanan lokal (cache).
class CacheException implements Exception {}

/// Exception yang dilempar saat terjadi kesalahan autentikasi.
class AuthenticationException implements Exception {}

/// Exception yang dilempar saat terjadi kesalahan validasi input.
class ValidationException implements Exception {
  final String message;

  ValidationException(this.message);

  @override
  String toString() => 'ValidationException: $message';
}

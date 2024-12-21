// lib/core/constants/constants.dart

// ignore: dangling_library_doc_comments
/// Konstanta umum yang digunakan di seluruh aplikasi.

class AppConstants {
  /// Base URL untuk API backend.
  static const String apiBaseUrl =
      'https://nutriti-on-backend-301444341226.asia-southeast2.run.app';

  /// Timeout untuk permintaan HTTP (dalam detik).
  static const int httpTimeout = 10;

  /// Key untuk menyimpan token autentikasi di SharedPreferences.
  static const String authTokenKey = 'AUTH_TOKEN';

  /// Key untuk menyimpan user ID di SharedPreferences.
  static const String userIdKey = 'USER_ID';

  /// Pattern regex untuk validasi email.
  static final RegExp emailRegExp = RegExp(
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
  );

  /// Minimal panjang password.
  static const int passwordMinLength = 6;

  /// List opsi jenis kelamin.
  static const List<String> genderOptions = ['Laki-laki', 'Perempuan'];

  // Tambahkan konstanta lainnya sesuai kebutuhan aplikasi
}

// lib/core/utils/validators.dart

/// Validator untuk memeriksa apakah string kosong atau tidak.
String? validateNotEmpty(String? value, String fieldName) {
  if (value == null || value.trim().isEmpty) {
    return '$fieldName tidak boleh kosong.';
  }
  return null;
}

String? validateName(String? value) {
  if (value == null || value.trim().isEmpty) {
    return 'Nama tidak boleh kosong';
  }
  if (value.trim().length < 3) {
    return 'Nama minimal 3 karakter';
  }
  return null;
}

/// Validator untuk memeriksa format email yang valid.
String? validateEmail(String? value) {
  if (value == null || value.trim().isEmpty) {
    return 'Email tidak boleh kosong.';
  }
  // Simple regex untuk validasi email
  final RegExp emailRegExp = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  if (!emailRegExp.hasMatch(value.trim())) {
    return 'Format email tidak valid.';
  }
  return null;
}

/// Validator untuk memeriksa password dengan minimal 6 karakter.
String? validatePassword(String? value) {
  if (value == null || value.trim().isEmpty) {
    return 'Password tidak boleh kosong.';
  }
  if (value.trim().length < 6) {
    return 'Password harus minimal 6 karakter.';
  }
  return null;
}

/// Validator untuk memeriksa apakah angka valid dan positif.
String? validatePositiveNumber(String? value, String fieldName) {
  if (value == null || value.trim().isEmpty) {
    return '$fieldName tidak boleh kosong.';
  }
  final number = double.tryParse(value.trim());
  if (number == null || number <= 0) {
    return '$fieldName harus berupa angka yang valid dan lebih besar dari 0.';
  }
  return null;
}

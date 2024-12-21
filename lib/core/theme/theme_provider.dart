// lib/core/theme/theme_provider.dart

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ThemeProvider extends ChangeNotifier {
  final FlutterSecureStorage secureStorage;
  ThemeMode _themeMode = ThemeMode.light;
  bool _notificationsEnabled = true;

  ThemeProvider({required this.secureStorage}) {
    _loadTheme();
    _loadNotifications();
  }

  ThemeMode get themeMode => _themeMode;
  bool get isDarkMode => _themeMode == ThemeMode.dark;
  bool get notificationsEnabled => _notificationsEnabled;

  void toggleTheme() {
    if (_themeMode == ThemeMode.light) {
      _themeMode = ThemeMode.dark;
    } else {
      _themeMode = ThemeMode.light;
    }
    _saveTheme();
    notifyListeners();
  }

  Future<void> _loadTheme() async {
    final theme = await secureStorage.read(key: 'theme');
    if (theme != null) {
      _themeMode = theme == 'dark' ? ThemeMode.dark : ThemeMode.light;
      notifyListeners();
    }
  }

  Future<void> _saveTheme() async {
    await secureStorage.write(
        key: 'theme', value: _themeMode == ThemeMode.dark ? 'dark' : 'light');
  }

  void toggleNotifications(bool value) {
    _notificationsEnabled = value;
    _saveNotifications();
    notifyListeners();
  }

  Future<void> _saveNotifications() async {
    await secureStorage.write(
        key: 'notifications', value: _notificationsEnabled.toString());
  }

  Future<void> _loadNotifications() async {
    final notifications = await secureStorage.read(key: 'notifications');
    if (notifications != null) {
      _notificationsEnabled = notifications.toLowerCase() == 'true';
      notifyListeners();
    }
  }
}

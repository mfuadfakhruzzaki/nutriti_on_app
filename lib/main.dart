// lib/main.dart
import 'package:flutter/material.dart';
import 'injection_container.dart'
    as di; // Pastikan ini sesuai dengan proyek Anda
import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init(); // Inisialisasi dependensi jika diperlukan
  runApp(MyApp());
}

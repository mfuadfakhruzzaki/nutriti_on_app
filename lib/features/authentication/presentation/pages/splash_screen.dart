// lib/features/authentication/presentation/pages/splash_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/auth_bloc.dart';
import '../blocs/auth_event.dart';
import '../../../../core/theme/app_colors.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Mengecek status autentikasi setelah delay singkat
    Future.delayed(Duration(seconds: 2), () {
      BlocProvider.of<AuthBloc>(context).add(CheckAuthStatusEvent());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBackground, // Menggunakan lightBackground
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo atau ikon aplikasi
            Icon(
              Icons.health_and_safety,
              size: 100,
              color: AppColors.primary,
            ),
            SizedBox(height: 20),
            // Nama Aplikasi
            Text(
              'Nutriti-On',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            SizedBox(height: 10),
            // Tagline atau deskripsi singkat
            Text(
              'Mendukung Nutrisi Anak Anda',
              style: TextStyle(
                fontSize: 16,
                color: AppColors.textSecondary,
              ),
            ),
            SizedBox(height: 40),
            // Loading Indicator
            CircularProgressIndicator(
              color: AppColors.primary,
            ),
          ],
        ),
      ),
    );
  }
}

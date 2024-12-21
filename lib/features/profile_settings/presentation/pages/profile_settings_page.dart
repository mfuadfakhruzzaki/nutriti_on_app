// lib/features/profile_settings/presentation/pages/profile_settings_page.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/user.dart';
import '../blocs/profile_bloc.dart';
import '../blocs/profile_event.dart';
import '../blocs/profile_state.dart';
import '../../../../core/utils/validators.dart';
import '../../../../core/theme/app_colors.dart';
import 'package:provider/provider.dart';
import '../../../../core/theme/theme_provider.dart';
import '../../../../features/authentication/presentation/blocs/auth_bloc.dart';
import '../../../../features/authentication/presentation/blocs/auth_event.dart';

class ProfileSettingsPage extends StatefulWidget {
  @override
  _ProfileSettingsPageState createState() => _ProfileSettingsPageState();
}

class _ProfileSettingsPageState extends State<ProfileSettingsPage> {
  final _formKey = GlobalKey<FormState>();
  late String name;
  late String email;
  String? oldPassword;
  String? newPassword;

  @override
  void initState() {
    super.initState();
    // Load user profile saat halaman dibuka
    BlocProvider.of<ProfileBloc>(context).add(LoadUserProfileEvent());
  }

  void _submitProfile() {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();

    final updatedUser = User(
      id: '', // ID akan diisi oleh repository berdasarkan data yang diambil
      name: name,
      email: email,
      // Tambahkan field lain sesuai kebutuhan
    );

    BlocProvider.of<ProfileBloc>(context)
        .add(UpdateUserProfileEvent(updatedUser));
  }

  void _submitChangePassword() {
    if (oldPassword == null || newPassword == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Password lama dan baru harus diisi')),
      );
      return;
    }

    if (newPassword!.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Password baru minimal 6 karakter')),
      );
      return;
    }

    BlocProvider.of<ProfileBloc>(context).add(
      ChangePasswordEvent(oldPassword: oldPassword!, newPassword: newPassword!),
    );
  }

  void _toggleTheme() {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    themeProvider.toggleTheme();
    // Mengirim event ke Bloc jika diperlukan
    BlocProvider.of<ProfileBloc>(context)
        .add(ToggleThemeEvent(isDarkMode: themeProvider.isDarkMode));
  }

  void _logout() {
    // Mengirim event Logout ke AuthBloc
    BlocProvider.of<AuthBloc>(context).add(LogoutEvent());
    Navigator.of(context).pushReplacementNamed('/auth');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBackground, // Menggunakan lightBackground
      appBar: AppBar(
        title: Text('Profil & Pengaturan'),
        backgroundColor:
            AppColors.primary, // Sesuaikan warna AppBar jika diperlukan
      ),
      body: BlocListener<ProfileBloc, ProfileState>(
        listener: (context, state) {
          if (state is ProfileOperationSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Operasi berhasil')),
            );
          } else if (state is ProfileOperationFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        child: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            if (state is ProfileLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is ProfileLoaded) {
              final user = state.user;
              return SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      // Nama
                      TextFormField(
                        initialValue: user.name,
                        decoration: InputDecoration(
                          labelText: 'Nama',
                          hintText: 'Masukkan nama Anda',
                          border: OutlineInputBorder(),
                        ),
                        validator: validateName,
                        onSaved: (value) => name = value!,
                      ),
                      SizedBox(height: 16),
                      // Email
                      TextFormField(
                        initialValue: user.email,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          hintText: 'Masukkan email Anda',
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        validator: validateEmail,
                        onSaved: (value) => email = value!,
                      ),
                      SizedBox(height: 32),
                      // Submit Button untuk Profil
                      ElevatedButton(
                        onPressed: _submitProfile,
                        child: Text('Simpan Perubahan'),
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                              vertical: 16.0, horizontal: 24.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          textStyle: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          backgroundColor:
                              AppColors.primary, // Menggunakan backgroundColor
                        ),
                      ),
                      SizedBox(height: 32),
                      Divider(),
                      SizedBox(height: 16),
                      // Ganti Password
                      Text(
                        'Ganti Password',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 16),
                      // Password Lama
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Password Lama',
                          hintText: 'Masukkan password lama Anda',
                          border: OutlineInputBorder(),
                        ),
                        obscureText: true,
                        onChanged: (value) => oldPassword = value,
                      ),
                      SizedBox(height: 16),
                      // Password Baru
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Password Baru',
                          hintText: 'Masukkan password baru Anda',
                          border: OutlineInputBorder(),
                        ),
                        obscureText: true,
                        onChanged: (value) => newPassword = value,
                      ),
                      SizedBox(height: 16),
                      // Submit Button untuk Ganti Password
                      ElevatedButton(
                        onPressed: _submitChangePassword,
                        child: Text('Ganti Password'),
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                              vertical: 16.0, horizontal: 24.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          backgroundColor:
                              AppColors.accent, // Menggunakan backgroundColor
                          textStyle: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 32),
                      Divider(),
                      SizedBox(height: 16),
                      // Pengaturan Tema
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Tema Gelap',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Switch(
                            value:
                                Provider.of<ThemeProvider>(context).isDarkMode,
                            onChanged: (value) {
                              _toggleTheme();
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: 32),
                      // Logout Button
                      ElevatedButton(
                        onPressed: _logout,
                        child: Text('Logout'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              AppColors.error, // Menggunakan backgroundColor
                          padding: EdgeInsets.symmetric(
                              vertical: 16.0, horizontal: 24.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          textStyle: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            } else if (state is ProfileOperationFailure) {
              return Center(child: Text(state.message));
            }
            return Center(child: Text('Profil Anda akan muncul di sini.'));
          },
        ),
      ),
    );
  }
}

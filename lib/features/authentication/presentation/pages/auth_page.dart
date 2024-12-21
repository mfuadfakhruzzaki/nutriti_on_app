// lib/features/authentication/presentation/pages/auth_page.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/auth_bloc.dart';
import '../blocs/auth_event.dart';
import '../blocs/auth_state.dart';
import '../../../../core/utils/validators.dart';
import '../../../../core/theme/app_colors.dart';

class AuthPage extends StatefulWidget {
  @override
  _AuthPageState createState() => _AuthPageState();
}

enum AuthMode { login, register }

class _AuthPageState extends State<AuthPage> {
  final _formKey = GlobalKey<FormState>();
  AuthMode _authMode = AuthMode.login;

  String email = '';
  String password = '';

  void _switchAuthMode() {
    setState(() {
      _authMode =
          _authMode == AuthMode.login ? AuthMode.register : AuthMode.login;
    });
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();

    if (_authMode == AuthMode.login) {
      BlocProvider.of<AuthBloc>(context)
          .add(LoginEvent(email: email, password: password));
    } else {
      BlocProvider.of<AuthBloc>(context)
          .add(RegisterEvent(email: email, password: password));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBackground, // Menggunakan lightBackground
      appBar: AppBar(
        title: Text(_authMode == AuthMode.login ? 'Login' : 'Register'),
        backgroundColor: AppColors.primary, // Menyesuaikan warna AppBar
      ),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthAuthenticated) {
            // Navigasi ke halaman utama setelah autentikasi berhasil
            Navigator.of(context).pushReplacementNamed(
                '/child'); // Ganti dengan route yang sesuai
          } else if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  // Email
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Email',
                      hintText: 'Masukkan email Anda',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: validateEmail,
                    onSaved: (value) => email = value!,
                  ),
                  SizedBox(height: 16),
                  // Password
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Password',
                      hintText: 'Masukkan password Anda',
                      border: OutlineInputBorder(),
                    ),
                    obscureText: true,
                    validator: validatePassword,
                    onSaved: (value) => password = value!,
                  ),
                  SizedBox(height: 32),
                  // Submit Button
                  ElevatedButton(
                    onPressed: _submit,
                    child: Text(
                        _authMode == AuthMode.login ? 'Login' : 'Register'),
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
                  SizedBox(height: 16),
                  // Switch Auth Mode
                  TextButton(
                    onPressed: _switchAuthMode,
                    child: Text(
                      _authMode == AuthMode.login
                          ? 'Belum punya akun? Register sekarang!'
                          : 'Sudah punya akun? Login sekarang!',
                      style: TextStyle(color: AppColors.primary),
                    ),
                  ),
                  SizedBox(height: 16),
                  // Loading Indicator
                  BlocBuilder<AuthBloc, AuthState>(
                    builder: (context, state) {
                      if (state is AuthLoading) {
                        return CircularProgressIndicator(
                          color: AppColors.primary,
                        );
                      }
                      return SizedBox.shrink();
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

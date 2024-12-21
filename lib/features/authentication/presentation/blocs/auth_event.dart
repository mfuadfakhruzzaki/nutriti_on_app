// lib/features/authentication/presentation/blocs/auth_event.dart
import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
}

class LoginEvent extends AuthEvent {
  final String email;
  final String password;

  const LoginEvent({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}

class RegisterEvent extends AuthEvent {
  final String email;
  final String password;

  const RegisterEvent({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}

class CheckAuthStatusEvent extends AuthEvent {
  @override
  List<Object?> get props => [];
}

class LogoutEvent extends AuthEvent {
  @override
  List<Object?> get props => [];
}

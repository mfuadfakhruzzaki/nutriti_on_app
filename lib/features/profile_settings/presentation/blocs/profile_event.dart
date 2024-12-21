// lib/features/profile_settings/presentation/blocs/profile_event.dart
import 'package:equatable/equatable.dart';
import '../../domain/entities/user.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object?> get props => [];
}

class LoadUserProfileEvent extends ProfileEvent {}

class UpdateUserProfileEvent extends ProfileEvent {
  final User user;

  const UpdateUserProfileEvent(this.user);

  @override
  List<Object?> get props => [user];
}

class ChangePasswordEvent extends ProfileEvent {
  final String oldPassword;
  final String newPassword;

  const ChangePasswordEvent(
      {required this.oldPassword, required this.newPassword});

  @override
  List<Object?> get props => [oldPassword, newPassword];
}

class ToggleThemeEvent extends ProfileEvent {}

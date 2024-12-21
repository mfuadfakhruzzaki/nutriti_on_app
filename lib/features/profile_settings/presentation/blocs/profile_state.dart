// lib/features/profile_settings/presentation/blocs/profile_state.dart
import 'package:equatable/equatable.dart';
import '../../domain/entities/user.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object?> get props => [];
}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final User user;

  const ProfileLoaded(this.user);

  @override
  List<Object?> get props => [user];
}

class ProfileOperationSuccess extends ProfileState {}

class ProfileOperationFailure extends ProfileState {
  final String message;

  const ProfileOperationFailure(this.message);

  @override
  List<Object?> get props => [message];
}

class ThemeToggled extends ProfileState {}

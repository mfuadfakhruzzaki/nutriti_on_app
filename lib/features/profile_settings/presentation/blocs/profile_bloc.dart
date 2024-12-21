// lib/features/profile_settings/presentation/blocs/profile_bloc.dart

import 'package:flutter_bloc/flutter_bloc.dart';
import 'profile_event.dart';
import 'profile_state.dart';
import '../../domain/usecases/get_user_profile.dart';
import '../../domain/usecases/update_user_profile.dart';
import '../../domain/usecases/change_password.dart';
import '../../domain/usecases/toggle_theme.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../../core/error/failures.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final GetUserProfileUseCase getUserProfileUseCase;
  final UpdateUserProfileUseCase updateUserProfileUseCase;
  final ChangePasswordUseCase changePasswordUseCase;
  final ToggleThemeUseCase toggleThemeUseCase;

  ProfileBloc({
    required this.getUserProfileUseCase,
    required this.updateUserProfileUseCase,
    required this.changePasswordUseCase,
    required this.toggleThemeUseCase,
  }) : super(ProfileInitial()) {
    on<LoadUserProfileEvent>(_onLoadUserProfile);
    on<UpdateUserProfileEvent>(_onUpdateUserProfile);
    on<ChangePasswordEvent>(_onChangePassword);
    on<ToggleThemeEvent>(_onToggleTheme);
  }

  Future<void> _onLoadUserProfile(
      LoadUserProfileEvent event, Emitter<ProfileState> emit) async {
    emit(ProfileLoading());
    final failureOrUser = await getUserProfileUseCase(NoParams());

    failureOrUser.fold(
      (failure) {
        emit(ProfileOperationFailure(_mapFailureToMessage(failure)));
      },
      (user) {
        emit(ProfileLoaded(user));
      },
    );
  }

  Future<void> _onUpdateUserProfile(
      UpdateUserProfileEvent event, Emitter<ProfileState> emit) async {
    emit(ProfileLoading());
    final failureOrUser = await updateUserProfileUseCase(
        UpdateUserProfileParams(user: event.user));

    failureOrUser.fold(
      (failure) {
        emit(ProfileOperationFailure(_mapFailureToMessage(failure)));
      },
      (user) {
        emit(ProfileOperationSuccess());
        // Optionally, reload user profile after updating
        add(LoadUserProfileEvent());
      },
    );
  }

  Future<void> _onChangePassword(
      ChangePasswordEvent event, Emitter<ProfileState> emit) async {
    emit(ProfileLoading());
    final failureOrVoid = await changePasswordUseCase(
      ChangePasswordParams(
        oldPassword: event.oldPassword,
        newPassword: event.newPassword,
      ),
    );

    failureOrVoid.fold(
      (failure) {
        emit(ProfileOperationFailure(_mapFailureToMessage(failure)));
      },
      (_) {
        emit(ProfileOperationSuccess());
      },
    );
  }

  Future<void> _onToggleTheme(
      ToggleThemeEvent event, Emitter<ProfileState> emit) async {
    emit(ProfileLoading());
    final failureOrVoid = await toggleThemeUseCase(
      ToggleThemeParams(isDarkMode: event.isDarkMode),
    );

    failureOrVoid.fold(
      (failure) {
        emit(ProfileOperationFailure(_mapFailureToMessage(failure)));
      },
      (_) {
        emit(ProfileThemeToggled(isDarkMode: event.isDarkMode));
      },
    );
  }

  String _mapFailureToMessage(Failure failure) {
    if (failure is ServerFailure) {
      return 'Terjadi kesalahan server. Silakan coba lagi.';
    } else if (failure is ConnectionFailure) {
      return 'Tidak ada koneksi internet. Silakan periksa jaringan Anda.';
    } else if (failure is CacheFailure) {
      return 'Gagal mengakses data lokal.';
    } else {
      return 'Terjadi kesalahan. Silakan coba lagi.';
    }
  }
}

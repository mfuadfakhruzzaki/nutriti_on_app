// lib/features/authentication/presentation/blocs/auth_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'auth_event.dart';
import 'auth_state.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/register_usecase.dart';
import '../../domain/usecases/logout_usecase.dart';
import '../../domain/usecases/check_auth_status_usecase.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../../core/error/failures.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase loginUseCase;
  final RegisterUseCase registerUseCase;
  final LogoutUseCase logoutUseCase;
  final CheckAuthStatusUseCase checkAuthStatusUseCase;

  AuthBloc({
    required this.loginUseCase,
    required this.registerUseCase,
    required this.logoutUseCase,
    required this.checkAuthStatusUseCase,
  }) : super(AuthInitial()) {
    on<LoginEvent>(_onLogin);
    on<RegisterEvent>(_onRegister);
    on<LogoutEvent>(_onLogout);
    on<CheckAuthStatusEvent>(_onCheckAuthStatus);
  }

  Future<void> _onLogin(LoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final failureOrAuth = await loginUseCase(
      LoginParams(email: event.email, password: event.password),
    );

    failureOrAuth.fold(
      (failure) {
        emit(AuthError(_mapFailureToMessage(failure)));
      },
      (authResponse) {
        emit(AuthAuthenticated(authResponse));
      },
    );
  }

  Future<void> _onRegister(RegisterEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final failureOrAuth = await registerUseCase(
      RegisterParams(email: event.email, password: event.password),
    );

    failureOrAuth.fold(
      (failure) {
        emit(AuthError(_mapFailureToMessage(failure)));
      },
      (authResponse) {
        emit(AuthAuthenticated(authResponse));
      },
    );
  }

  Future<void> _onLogout(LogoutEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final failureOrVoid = await logoutUseCase(NoParams());

    failureOrVoid.fold(
      (failure) {
        emit(AuthError(_mapFailureToMessage(failure)));
      },
      (_) {
        emit(AuthUnauthenticated());
      },
    );
  }

  Future<void> _onCheckAuthStatus(
      CheckAuthStatusEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final failureOrAuth = await checkAuthStatusUseCase(NoParams());

    failureOrAuth.fold(
      (failure) {
        emit(AuthUnauthenticated());
      },
      (authResponse) {
        emit(AuthAuthenticated(authResponse));
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

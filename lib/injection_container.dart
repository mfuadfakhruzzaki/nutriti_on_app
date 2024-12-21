// lib/core/injection_container.dart

import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../features/authentication/data/datasources/auth_remote_data_source.dart';
import '../features/authentication/data/repositories/auth_repository_impl.dart';
import '../features/authentication/domain/repositories/auth_repository.dart';
import '../features/authentication/domain/usecases/login_usecase.dart';
import '../features/authentication/domain/usecases/register_usecase.dart';
import '../features/authentication/domain/usecases/logout_usecase.dart';
import '../features/authentication/domain/usecases/check_auth_status_usecase.dart';
import '../features/authentication/presentation/blocs/auth_bloc.dart';

import '../features/child/data/datasources/child_remote_data_source.dart';
import '../features/child/data/repositories/child_repository_impl.dart';
import '../features/child/domain/repositories/child_repository.dart';
import '../features/child/domain/usecases/get_children.dart';
import '../features/child/domain/usecases/add_child.dart';
import '../features/child/domain/usecases/update_child.dart';
import '../features/child/domain/usecases/delete_child.dart';
import '../features/child/presentation/blocs/child_bloc.dart';

import '../features/profile_settings/data/datasources/profile_remote_data_source.dart';
import '../features/profile_settings/data/repositories/profile_repository_impl.dart';
import '../features/profile_settings/domain/repositories/profile_repository.dart';
import '../features/profile_settings/domain/usecases/get_user_profile.dart';
import '../features/profile_settings/domain/usecases/update_user_profile.dart';
import '../features/profile_settings/domain/usecases/change_password.dart';
import '../features/profile_settings/domain/usecases/toggle_theme.dart';
import '../features/profile_settings/presentation/blocs/profile_bloc.dart';

import '../core/network/network_info.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Features - Authentication

  // Bloc
  sl.registerFactory(() => AuthBloc(
        loginUseCase: sl(),
        registerUseCase: sl(),
        logoutUseCase: sl(),
        checkAuthStatusUseCase: sl(),
      ));

  // Use Cases
  sl.registerLazySingleton(() => LoginUseCase(sl()));
  sl.registerLazySingleton(() => RegisterUseCase(sl()));
  sl.registerLazySingleton(() => LogoutUseCase(sl()));
  sl.registerLazySingleton(() => CheckAuthStatusUseCase(sl()));

  // Repository
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      remoteDataSource: sl(),
      networkInfo: sl(),
      secureStorage: sl(),
    ),
  );

  // Data Sources
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(client: sl()),
  );

  //! Features - Child

  // Bloc
  sl.registerFactory(() => ChildBloc(
        getChildrenUseCase: sl(),
        addChildUseCase: sl(),
        updateChildUseCase: sl(),
        deleteChildUseCase: sl(),
      ));

  // Use Cases
  sl.registerLazySingleton(() => GetChildrenUseCase(sl()));
  sl.registerLazySingleton(() => AddChildUseCase(sl()));
  sl.registerLazySingleton(() => UpdateChildUseCase(sl()));
  sl.registerLazySingleton(() => DeleteChildUseCase(sl()));

  // Repository
  sl.registerLazySingleton<ChildRepository>(
    () => ChildRepositoryImpl(
      remoteDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  // Data Sources
  sl.registerLazySingleton<ChildRemoteDataSource>(
    () => ChildRemoteDataSourceImpl(client: sl()),
  );

  //! Features - Profile & Settings

  // Bloc
  sl.registerFactory(() => ProfileBloc(
        getUserProfileUseCase: sl(),
        updateUserProfileUseCase: sl(),
        changePasswordUseCase: sl(),
        toggleThemeUseCase: sl(),
      ));

  // Use Cases
  sl.registerLazySingleton(() => GetUserProfileUseCase(sl()));
  sl.registerLazySingleton(() => UpdateUserProfileUseCase(sl()));
  sl.registerLazySingleton(() => ChangePasswordUseCase(sl()));
  sl.registerLazySingleton(() => ToggleThemeUseCase(sl()));

  // Repository
  sl.registerLazySingleton<ProfileRepository>(
    () => ProfileRepositoryImpl(
      remoteDataSource: sl(),
      networkInfo: sl(),
      secureStorage: sl(),
    ),
  );

  // Data Sources
  sl.registerLazySingleton<ProfileRemoteDataSource>(
    () => ProfileRemoteDataSourceImpl(client: sl()),
  );

  //! Core

  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  //! External

  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => Connectivity());
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton<FlutterSecureStorage>(() => FlutterSecureStorage());
}

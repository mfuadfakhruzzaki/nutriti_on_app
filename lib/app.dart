// lib/app.dart
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'core/theme/app_theme.dart';
import 'core/theme/theme_provider.dart';
import 'features/authentication/presentation/blocs/auth_bloc.dart';
import 'features/authentication/presentation/pages/auth_page.dart';
import 'features/authentication/presentation/pages/splash_screen.dart';
import 'features/child/domain/entities/child.dart';
import 'features/child/presentation/blocs/child_bloc.dart';
import 'features/child/presentation/blocs/child_event.dart';
import 'features/child/presentation/pages/child_page.dart';
import 'features/child/presentation/pages/add_child_page.dart';
import 'features/child/presentation/pages/edit_child_page.dart';
import 'features/profile_settings/presentation/blocs/profile_bloc.dart';
import 'features/profile_settings/presentation/blocs/profile_event.dart';
import 'features/profile_settings/presentation/pages/profile_settings_page.dart';
import 'features/settings/presentation/pages/settings_page.dart'; // Jika ada

import 'injection_container.dart' as di;
import 'package:flutter_bloc/flutter_bloc.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: di.init(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return MaterialApp(
            home: Scaffold(
              body: Center(child: CircularProgressIndicator()),
            ),
          );
        } else {
          return ChangeNotifierProvider(
            create: (_) =>
                ThemeProvider(secureStorage: di.sl<FlutterSecureStorage>()),
            child: Consumer<ThemeProvider>(
              builder: (context, themeProvider, child) {
                return MultiBlocProvider(
                  providers: [
                    BlocProvider<AuthBloc>(
                      create: (_) => di.sl<AuthBloc>(),
                    ),
                    BlocProvider<ChildBloc>(
                      create: (_) =>
                          di.sl<ChildBloc>()..add(LoadChildrenEvent()),
                    ),
                    BlocProvider<ProfileBloc>(
                      create: (_) =>
                          di.sl<ProfileBloc>()..add(LoadUserProfileEvent()),
                    ),
                  ],
                  child: MaterialApp(
                    title: 'Nutriti-On',
                    theme: AppTheme.lightTheme,
                    darkTheme: AppTheme.darkTheme,
                    themeMode: themeProvider.themeMode,
                    initialRoute: '/',
                    routes: {
                      '/': (context) => SplashScreen(),
                      '/auth': (context) => AuthPage(),
                      '/child': (context) => ChildPage(),
                      '/add_child': (context) => AddChildPage(),
                      '/edit_child': (context) => EditChildPage(
                            child: ModalRoute.of(context)!.settings.arguments
                                as Child,
                          ),
                      '/profile_settings': (context) => ProfileSettingsPage(),
                      '/settings': (context) => SettingsPage(),
                      // Tambahkan rute lain sesuai kebutuhan
                    },
                  ),
                );
              },
            ),
          );
        }
      },
    );
  }
}

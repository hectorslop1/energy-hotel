import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'core/theme/app_theme.dart';
import 'core/l10n/app_localizations.dart';
import 'features/auth/presentation/providers/auth_provider.dart';
import 'features/auth/presentation/providers/auth_state.dart';
import 'features/auth/presentation/screens/login_screen.dart';
import 'features/auth/presentation/screens/splash_screen.dart';
import 'features/home/presentation/screens/main_navigation_screen.dart';
import 'features/settings/presentation/providers/language_provider.dart';

class EnergyHotelApp extends ConsumerWidget {
  const EnergyHotelApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedLanguage = ref.watch(selectedLanguageProvider);

    return MaterialApp(
      title: 'Energy Hotel',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      locale: Locale(selectedLanguage.code),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('en'), Locale('es')],
      home: const AuthWrapper(),
    );
  }
}

class AuthWrapper extends ConsumerStatefulWidget {
  const AuthWrapper({super.key});

  @override
  ConsumerState<AuthWrapper> createState() => _AuthWrapperState();
}

class _AuthWrapperState extends ConsumerState<AuthWrapper> {
  bool _hasShownSplash = false;

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);

    switch (authState.status) {
      case AuthStatus.initial:
        return const SplashScreen();
      case AuthStatus.loading:
        if (!_hasShownSplash) {
          return const SplashScreen();
        }
        return const LoginScreen();
      case AuthStatus.authenticated:
        _hasShownSplash = true;
        return const MainNavigationScreen();
      case AuthStatus.unauthenticated:
      case AuthStatus.error:
        _hasShownSplash = true;
        return const LoginScreen();
    }
  }
}

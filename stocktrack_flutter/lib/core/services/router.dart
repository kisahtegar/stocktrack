import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stocktrack_flutter/core/common/views/page_underconstruction.dart';
import 'package:stocktrack_flutter/core/common/views/redirect_page.dart';
import 'package:stocktrack_flutter/core/services/injection_container.dart';
import 'package:stocktrack_flutter/src/auth/data/datasources/auth_remote_data_source.dart';
import 'package:stocktrack_flutter/src/auth/presentation/cubit/auth_cubit.dart';
import 'package:stocktrack_flutter/src/auth/presentation/views/sign_in_screen.dart';
import 'package:stocktrack_flutter/src/dashboard/presentation/views/dashboard.dart';

/// This code defines the route generation function `generateRoute` responsible
/// for handling different routes within your Flutter application. It constructs
/// the appropriate screens based on the route name and provides necessary
/// dependencies using BlocProvider when required. The `_pageBuilder` function
/// is used to create the page transition with a fade effect.
Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case '/':
      debugPrint('generateRoute(/): Started...');
      continue auth;

    auth:
    case '/auth':
      debugPrint('generateRoute(/auth): Started...');
      final prefs = sl<SharedPreferences>();
      final token = prefs.getString(kUserTokenKey);

      if (token != null) {
        if (JwtDecoder.isExpired(token)) {
          debugPrint('generateRoute(/auth): Expired token.');
          return _pageBuilder(
            (context) => RedirectPage(token),
            settings: settings,
          );
          // continue signin;
        } else {
          debugPrint('generateRoute(/auth): Navigated to /dashboard.');
          continue dashboard;
        }
      }
      continue signin;

    signin:
    case SignInScreen.routeName:
      debugPrint('generateRoute(/signin): Started...');
      return _pageBuilder(
        (_) => BlocProvider(
          create: (_) => sl<AuthCubit>(),
          child: const SignInScreen(),
        ),
        settings: settings,
      );

    dashboard:
    case Dashboard.routeName:
      debugPrint('generateRoute(/dashboard): Started...');

      final prefs = sl<SharedPreferences>();
      final token = prefs.getString(kUserTokenKey);

      if (token != null) {
        if (JwtDecoder.isExpired(token)) {
          debugPrint('generateRoute(/dashboard): Expired token.');
          return _pageBuilder(
            (context) => RedirectPage(token),
            settings: settings,
          );
        } else {
          debugPrint('generateRoute(/dashboard): Navigated to dashboard.');
          return _pageBuilder(
            (_) => const Dashboard(),
            settings: settings,
          );
        }
      }
      return _pageBuilder(
        (context) => RedirectPage(token),
        settings: settings,
      );

    default:
      debugPrint('generateRoute(default): Started...');
      return _pageBuilder(
        (_) => const PageUnderConstruction(),
        settings: settings,
      );
  }
}

/// This private function is used to construct a `PageRouteBuilder`. It takes a
/// Widget-building function (`page`) and route settings as parameters. It
/// returns a `PageRouteBuilder` with a fade transition animation when
/// navigating between screens.
PageRouteBuilder<dynamic> _pageBuilder(
  Widget Function(BuildContext) page, {
  required RouteSettings settings,
}) {
  return PageRouteBuilder(
    settings: settings,
    transitionsBuilder: (_, animation, __, child) => FadeTransition(
      opacity: animation,
      child: child,
    ),
    pageBuilder: (context, _, __) => page(context),
  );
}

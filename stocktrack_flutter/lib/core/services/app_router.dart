import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stocktrack_flutter/core/common/views/error_page.dart';
import 'package:stocktrack_flutter/core/common/views/underconstruction_page.dart';
import 'package:stocktrack_flutter/core/services/injection_container.dart';
import 'package:stocktrack_flutter/core/utils/route_utils.dart';
import 'package:stocktrack_flutter/src/auth/data/datasources/auth_remote_data_source.dart';
import 'package:stocktrack_flutter/src/auth/presentation/bloc/auth_bloc.dart';
import 'package:stocktrack_flutter/src/auth/presentation/views/sign_in_screen.dart';
import 'package:stocktrack_flutter/src/dashboard/presentation/views/dashboard.dart';

class AppRouter {
  AppRouter._();

  static final GoRouter router = GoRouter(
    initialLocation: '/signin',
    debugLogDiagnostics: true,
    errorBuilder: (context, state) => ErrorPage(
      errorMessage: state.extra.toString(),
    ),
    routes: <GoRoute>[
      GoRoute(
        path: AppPage.signIn.toPath,
        name: AppPage.signIn.toName,
        builder: (context, state) => BlocProvider(
          create: (context) => sl<AuthBloc>(),
          child: const SignInScreen(),
        ),
      ),
      GoRoute(
        path: AppPage.dashboard.toPath,
        name: AppPage.dashboard.toName,
        builder: (context, state) => const Dashboard(),
      ),
      GoRoute(
        path: AppPage.underConstruction.toPath,
        name: AppPage.underConstruction.toName,
        builder: (context, state) => const UnderConstructionPage(),
      ),
      GoRoute(
        path: AppPage.error.toPath,
        name: AppPage.error.toName,
        builder: (context, state) => const ErrorPage(),
      ),
    ],
    redirect: (context, state) {
      debugPrint('AppRouter: Redirect...');

      final prefs = sl<SharedPreferences>();
      final token = prefs.getString(kUserTokenKey);

      if (token != null) {
        if (JwtDecoder.isExpired(token)) {
          debugPrint('AppRouter: Token is expired.');
          return AppPage.signIn.toPath;
        } else {
          debugPrint('AppRouter: Navigated to /dashboard');
          return AppPage.dashboard.toPath;
        }
      } else {
        // Doing nothing.
        return null;
      }
    },
  );
}

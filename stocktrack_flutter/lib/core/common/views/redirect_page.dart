import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:stocktrack_flutter/src/auth/presentation/views/sign_in_screen.dart';
import 'package:stocktrack_flutter/src/dashboard/presentation/views/dashboard.dart';

class RedirectPage extends StatelessWidget {
  const RedirectPage(this.token, {super.key});
  final String? token;

  @override
  Widget build(BuildContext context) {
    if (token != null) {
      if (JwtDecoder.isExpired(token!)) {
        // Token has expired; navigate to the sign-in screen.
        Future.delayed(Duration.zero, () {
          debugPrint('Redirecting to: /signin');
          Navigator.of(context).pushReplacementNamed(SignInScreen.routeName);
        });
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else {
        // Token is still valid; navigate to the dashboard.
        Future.delayed(Duration.zero, () {
          debugPrint('Redirecting to: /dashboard');
          Navigator.of(context).pushReplacementNamed(Dashboard.routeName);
        });
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
    } else {
      Future.delayed(Duration.zero, () {
        debugPrint('Redirecting to: /signin');
        Navigator.of(context).pushReplacementNamed(SignInScreen.routeName);
      });
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
  }
}

import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:stocktrack_flutter/core/utils/route_utils.dart';

class RedirectPage extends StatelessWidget {
  const RedirectPage(this.token, {super.key});
  final String? token;

  @override
  Widget build(BuildContext context) {
    if (token != null) {
      if (JwtDecoder.isExpired(token!)) {
        // Token has expired; navigate to the sign-in screen.
        Future.delayed(Duration.zero, () {
          debugPrint('RedirectPage(token-expired): /signin');
          Navigator.of(context).pushReplacementNamed(AppPage.signIn.toPath);
        });
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else {
        // Token is still valid; navigate to the dashboard.
        Future.delayed(Duration.zero, () {
          debugPrint('RedirectPage(token-valid): /dashboard');
          Navigator.of(context).pushReplacementNamed(AppPage.dashboard.toPath);
        });
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
    } else {
      Future.delayed(Duration.zero, () {
        debugPrint('RedirectPage(token-null): /signin');
        Navigator.of(context).pushReplacementNamed(AppPage.signIn.toPath);
      });
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
  }
}

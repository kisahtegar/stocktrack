import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:stocktrack_flutter/core/res/colours.dart';
import 'package:stocktrack_flutter/core/res/media_res.dart';

/// The `PageUnderConstruction` widget is used to display a "Page Under
/// Construction" screen in your app. This screen is typically shown to inform
/// users that a particular page or feature is not yet available or is currently
/// in development.
class PageUnderConstruction extends StatelessWidget {
  const PageUnderConstruction({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: const BoxConstraints.expand(),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: Colours.gradientBackgroundSignIn,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: Lottie.asset(
              // Use Lottie animation to display the construction animation.
              MediaRes.pageUnderConstruction,
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:stocktrack_flutter/core/res/colours.dart';
import 'package:stocktrack_flutter/core/res/media_res.dart';

/// The `UnderConstructionPage` widget is used to display a "Under Construction
/// Page" screen in your app. This screen is typically shown to inform users
/// that a particular page or feature is not yet available or is currently in
/// development.
class UnderConstructionPage extends StatelessWidget {
  const UnderConstructionPage({super.key});

  static const routeName = '/under-construction';

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
              MediaRes.underConstructionPage,
            ),
          ),
        ),
      ),
    );
  }
}

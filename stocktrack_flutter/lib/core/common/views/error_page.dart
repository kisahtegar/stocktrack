import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:stocktrack_flutter/core/res/colours.dart';
import 'package:stocktrack_flutter/core/res/media_res.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({this.errorMessage, super.key});

  final String? errorMessage;

  /// The route name for this screen.
  static const routeName = '/error';

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
            child: Column(
              children: [
                // Use Lottie animation to display the construction animation.
                Lottie.asset(MediaRes.underConstructionPage),
                Text(errorMessage ?? ''),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

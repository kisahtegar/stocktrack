import 'package:flutter/material.dart';

/// A Flutter widget that provides a gradient background color for its child.
///
/// Use this widget to create a background with a gradient color for your
/// content. It takes a [gradient] parameter to define the gradient and a
/// [child] widget to be displayed on top of the gradient background.
///
/// ### Example:
///
/// ```dart
/// GradientBackgroundColor(
///   gradient: LinearGradient(
///     colors: [Colors.blue, Colors.green],
///     begin: Alignment.topCenter,
///     end: Alignment.bottomCenter,
///   ),
///   child: YourContentWidget(),
/// )
/// ```
class GradientBackgroundColor extends StatelessWidget {
  /// Creates a [GradientBackgroundColor] widget.
  ///
  /// The [gradient] parameter defines the gradient that defines the background
  /// color, and the [child] parameter is the widget to be displayed on top of
  /// the gradient background.
  const GradientBackgroundColor({
    required this.gradient,
    required this.child,
    super.key,
  });

  /// The gradient that defines the background color of this widget.
  final Gradient gradient;

  /// The widget to be displayed on top of the gradient background.
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      // constraints: const BoxConstraints.expand(),
      decoration: BoxDecoration(
        gradient: gradient,
      ),
      child: child,
    );
  }
}

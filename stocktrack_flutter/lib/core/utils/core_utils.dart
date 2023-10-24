import 'package:flutter/material.dart';
import 'package:stocktrack_flutter/core/res/colours.dart';

/// The `CoreUtils` class provides utility functions for common tasks within
/// your application. It has a private constructor `const CoreUtils._()` to
/// prevent external instantiation.
class CoreUtils {
  const CoreUtils._();

  /// Displays a SnackBar notification within the application.
  ///
  /// The [context] parameter is used to obtain the `ScaffoldMessenger` for
  /// showing the SnackBar, and the [message] parameter contains the message to
  /// be displayed.
  ///
  /// Usage:
  /// ```dart
  /// CoreUtils.showSnackBar(context, 'Your message goes here');
  /// ```
  static void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(
            message,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colours.primaryColour,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          margin: const EdgeInsets.all(10),
        ),
      );
  }

  /// Displays a loading dialog within the application.
  ///
  /// The [context] parameter is used to obtain the current [BuildContext] to
  /// show the loading dialog. This dialog typically includes a spinning
  /// CircularProgressIndicator to indicate ongoing background work.
  ///
  /// Usage:
  /// ```dart
  /// CoreUtils.showLoadingDialog(context);
  /// ```
  static void showLoadingDialog(BuildContext context) {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

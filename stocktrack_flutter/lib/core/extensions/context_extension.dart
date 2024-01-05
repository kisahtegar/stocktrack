import 'package:flutter/material.dart';

/// This extension simplifies common app development tasks by providing easy
/// access to essential functionality from the `BuildContext`. It enhances code
/// readability and promotes cleaner widget build methods.
extension ContextExt on BuildContext {
  /// Access the current `ThemeData` from the nearest `Theme` widget, allowing
  /// you to retrieve theme-related properties like colors and text styles.
  ThemeData get theme => Theme.of(this);

  /// Get the current `MediaQueryData`, which contains screen information like
  /// size and orientation, facilitating responsive layout design.
  MediaQueryData get mediaQuery => MediaQuery.of(this);

  /// Shorthand for accessing the screen size (dimensions) from `mediaQuery`.
  Size get size => mediaQuery.size;
  double get width => size.width;
  double get height => size.height;
}

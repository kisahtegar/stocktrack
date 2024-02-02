import 'package:flutter/material.dart';

// Font family name
const String _openSans = 'OpenSans';
const String _libreBaskerville = 'LibreBaskerville';

/// The styles are organized into classes for each font family, providing easy
/// access to various font weights and styles such as regular, bold, medium,
/// and italic.
///
/// ### Example:
/// ```
/// Text(
///   'Example Text',
///   style: OpenSans.bold,
/// )
/// ```
class OpenSans {
  const OpenSans._();

  static TextStyle regular = const TextStyle(
    fontFamily: _openSans,
  );

  static TextStyle medium = const TextStyle(
    fontFamily: _openSans,
    fontWeight: FontWeight.w500,
  );

  static TextStyle bold = const TextStyle(
    fontFamily: _openSans,
    fontWeight: FontWeight.w700,
  );

  static TextStyle italic = const TextStyle(
    fontFamily: _openSans,
    fontStyle: FontStyle.italic,
  );
}

/// The styles are organized into classes for each font family, providing easy
/// access to various font weights and styles such as regular, bold, and italic.
///
/// ### Example:
/// ```
/// Text(
///   'Example Text',
///   style: LibreBaskerville.bold,
/// )
/// ```
class LibreBaskerville {
  const LibreBaskerville._();

  static TextStyle regular = const TextStyle(
    fontFamily: _libreBaskerville,
  );

  static TextStyle bold = const TextStyle(
    fontFamily: _libreBaskerville,
    fontWeight: FontWeight.w700,
  );

  static TextStyle italic = const TextStyle(
    fontFamily: _libreBaskerville,
    fontStyle: FontStyle.italic,
  );
}

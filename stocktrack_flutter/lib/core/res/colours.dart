import 'dart:ui';

class Colours {
  const Colours._();

  static const gradientBackgroundSignIn = [
    Color(0xFF4CAF50), // Green
    Color(0xFF8BC34A), // Light Green
    Color(0xFFFFEB3B), // Yellow
    Color(0xFFFF9800), // Orange
  ];

  static const primaryColour = Color(0xFF4CAF50);

  static const greenColour = Color.fromARGB(255, 31, 86, 32);

  // Dashboard Sidebar colors
  static const canvasSidebarColour = Color.fromARGB(81, 216, 255, 221);
  static const selectedItemSidebarColour = Color.fromARGB(213, 216, 255, 221);
  static const selectedTextSidebarColour = Color.fromARGB(255, 31, 86, 32);
  static Color unSelectedTextSidebarColour =
      const Color.fromARGB(255, 31, 86, 32).withOpacity(0.7);
}

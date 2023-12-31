import 'package:flutter/material.dart';
import 'package:stocktrack_flutter/core/res/colours.dart';

/// The `UnderConstructionPage` widget is used to display a "Under Construction
/// Page" screen in your app. This screen is typically shown to inform users
/// that a particular page or feature is not yet available or is currently in
/// development.
class UnderConstructionPage extends StatelessWidget {
  const UnderConstructionPage({super.key});

  static const routeName = '/under-construction';

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: SizedBox(
              width: 130,
              height: 130,
              child: Stack(
                children: [
                  const Align(
                    alignment: Alignment.topLeft,
                    child: Icon(
                      Icons.sunny,
                      color: Colors.amber,
                    ),
                  ),
                  Align(
                    child: Container(
                      padding: const EdgeInsets.all(30),
                      decoration: BoxDecoration(
                        color: Colours.greenColour.withOpacity(0.2),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.construction,
                        color: Colours.greenColour,
                        size: 50,
                      ),
                    ),
                  ),
                  const Align(
                    alignment: Alignment.bottomRight,
                    child: Icon(
                      Icons.wifi_tethering_error,
                      color: Colors.blueAccent,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 25),
          const Text(
            'Under Construction',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'Our page is under construction, we still work on it.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Colors.black54,
            ),
          ),
        ],
      ),
    );
  }
}

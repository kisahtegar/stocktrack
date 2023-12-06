import 'package:flutter/material.dart';
import 'package:stocktrack_flutter/core/res/colours.dart';

/// A widget representing a page not found error screen.
class PageNotFound extends StatelessWidget {
  /// Creates a [PageNotFound] widget.
  ///
  /// - [errorTitle] is the title to be displayed on the error screen. If null,
  ///   a default '404 Page Not Found' is used.
  /// - [errorDescription] is the description to be displayed on the error
  ///   screen. If null, a default message is used.
  const PageNotFound({this.errorTitle, this.errorDescription, super.key});

  /// The title for the error screen.
  final String? errorTitle;

  /// The description for the error screen.
  final String? errorDescription;

  /// The route name for this screen.
  static const routeName = '/error';

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
                        Icons.error,
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
          Text(
            errorTitle ?? '404\nPage Not Found',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            errorDescription ??
                "The Page you are looking for doesn't exist or an other error "
                    'occurred.',
            textAlign: TextAlign.center,
            style: const TextStyle(
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

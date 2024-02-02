import 'package:flutter/material.dart';
import 'package:stocktrack_flutter/core/res/colours.dart';
import 'package:stocktrack_flutter/core/services/app_router.dart';
import 'package:stocktrack_flutter/core/services/injection_container.dart';
import 'package:stocktrack_flutter/core/services/storage_service.dart';
import 'package:stocktrack_flutter/core/utils/route_utils.dart';

/// The body of the Dashboard screen that holds the app bar and displays the
/// selected screen based on the current index.
class BodyDashboard extends StatelessWidget {
  const BodyDashboard({
    required int index,
    required List<Widget> screens,
    super.key,
  })  : _index = index,
        _screens = screens;

  /// The current index representing the selected screen.
  final int _index;

  /// List of screens to be displayed in the dashboard.
  final List<Widget> _screens;

  @override
  Widget build(BuildContext context) {
    debugPrint('Dashboard(Body): index = $_index');
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            tooltip: 'Help',
            onPressed: () {},
            icon: const Icon(
              Icons.help,
              color: Colours.greenColour,
            ),
          ),
          IconButton(
            onPressed: () {
              // Clearing all storage service specially for token.
              sl<StorageService>().clearAll();

              // Go to Sign-in page.
              AppRouter.router.go(AppPage.signIn.toPath);
            },
            tooltip: 'Logout',
            icon: const Icon(
              Icons.exit_to_app,
              color: Colours.greenColour,
            ),
          ),
          const SizedBox(width: 15),
        ],
      ),
      body: IndexedStack(
        // This widget is used to manage multiple screens or pages that can be
        // displayed in the dashboard. The [IndexedStack] widget shows only one
        // child at a time based on the currentIndex. The _screens list contains
        // the screens to be displayed.
        index: _index,
        children: _screens,
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:stocktrack_flutter/core/res/colours.dart';

class BodyDashboard extends StatelessWidget {
  const BodyDashboard({
    required int index,
    required List<Widget> screens,
    super.key,
  })  : _index = index,
        _screens = screens;

  final int _index;
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
            onPressed: () {},
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

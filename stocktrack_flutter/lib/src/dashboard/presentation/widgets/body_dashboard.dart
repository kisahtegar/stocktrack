import 'package:flutter/material.dart';
import 'package:stocktrack_flutter/core/res/colours.dart';

class BodyDashboard extends StatelessWidget {
  const BodyDashboard({super.key});

  @override
  Widget build(BuildContext context) {
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
      body: const Center(child: Text('dashboard')),
    );
  }
}

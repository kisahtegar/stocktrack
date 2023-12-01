import 'package:flutter/material.dart';
import 'package:sidebarx/sidebarx.dart';
import 'package:stocktrack_flutter/src/dashboard/presentation/widgets/body_dashboard.dart';
import 'package:stocktrack_flutter/src/dashboard/presentation/widgets/sidebar_dashboard.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  /// The route name for this screen.
  static const routeName = '/dashboard';

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    debugPrint('Dashboard: Build...');
    return Scaffold(
      body: Row(
        children: [
          // Sidebar Section.
          SidebarDashboard(
            controller: SidebarXController(
              selectedIndex: 0,
              extended: true,
            ),
            items: [
              SidebarXItem(
                icon: Icons.dashboard,
                label: 'Home',
                onTap: () {},
              ),
              SidebarXItem(
                icon: Icons.add_box,
                label: 'Barang',
                onTap: () {},
              ),
            ],
          ),

          // App Screen body.
          const Expanded(child: BodyDashboard()),
        ],
      ),
    );
  }
}

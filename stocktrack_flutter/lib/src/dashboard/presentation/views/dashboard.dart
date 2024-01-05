import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sidebarx/sidebarx.dart';
import 'package:stocktrack_flutter/src/dashboard/presentation/providers/dashboard_controller.dart';
import 'package:stocktrack_flutter/src/dashboard/presentation/widgets/body_dashboard.dart';
import 'package:stocktrack_flutter/src/dashboard/presentation/widgets/sidebar_dashboard.dart';

/// The main dashboard screen that displays a sidebar and the app's body.
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
    return Consumer<DashboardController>(
      // Listens for changes in the DashboardController. When the controller's
      // state changes, it rebuilds its child widget with the updated data.
      builder: (_, controller, __) {
        return Scaffold(
          body: Row(
            children: [
              // Sidebar Section.
              SidebarDashboard(
                controller: SidebarXController(
                  selectedIndex: controller.currentIndex,
                  extended: true,
                ),
                items: [
                  SidebarXItem(
                    icon: Icons.dashboard,
                    label: 'Home',
                    onTap: () => controller.changeIndex(0),
                  ),
                  SidebarXItem(
                    icon: Icons.person_2_rounded,
                    label: 'Supplier',
                    onTap: () => controller.changeIndex(1),
                  ),
                  SidebarXItem(
                    icon: Icons.add_box,
                    label: 'Item',
                    onTap: () => controller.changeIndex(2),
                  ),
                ],
              ),

              // App Screen body.
              Expanded(
                child: BodyDashboard(
                  index: controller.currentIndex,
                  screens: controller.screens,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

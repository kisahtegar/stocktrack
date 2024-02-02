import 'package:flutter/material.dart';
import 'package:sidebarx/sidebarx.dart';
import 'package:stocktrack_flutter/core/res/colours.dart';

/// Sidebar widget for the Dashboard screen.
class SidebarDashboard extends StatelessWidget {
  const SidebarDashboard({
    required SidebarXController controller,
    required List<SidebarXItem> items,
    super.key,
  })  : _controller = controller,
        _items = items;

  /// Controller for managing the state of the sidebar.
  final SidebarXController _controller;

  /// List of items to be displayed in the sidebar.
  final List<SidebarXItem> _items;

  @override
  Widget build(BuildContext context) {
    return SidebarX(
      controller: _controller,
      items: _items,
      footerDivider: Divider(color: Colors.grey.withOpacity(0.3), height: 1),
      theme: SidebarXTheme(
        itemTextPadding: const EdgeInsets.only(left: 30),
        selectedItemTextPadding: const EdgeInsets.only(left: 30),
        decoration: const BoxDecoration(
          color: Color.fromARGB(126, 216, 255, 221),
        ),
        selectedItemDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colours.selectedItemSidebarColour,
        ),
        textStyle: TextStyle(
          color: Colours.unSelectedTextSidebarColour,
        ),
        selectedTextStyle: const TextStyle(
          color: Colours.selectedTextSidebarColour,
        ),
        iconTheme: IconThemeData(
          color: Colours.unSelectedTextSidebarColour,
          size: 20,
        ),
        selectedIconTheme: const IconThemeData(
          color: Colours.selectedTextSidebarColour,
          size: 20,
        ),
      ),
      headerBuilder: (context, extended) {
        return SizedBox(
          height: 100,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Image.asset('assets/images/logo.png'),
          ),
        );
      },
      extendedTheme: const SidebarXTheme(
        width: 200,
        decoration: BoxDecoration(
          color: Color.fromARGB(126, 216, 255, 221),
        ),
      ),
    );
  }
}

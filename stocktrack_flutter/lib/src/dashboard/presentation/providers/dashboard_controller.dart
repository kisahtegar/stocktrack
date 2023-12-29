import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:stocktrack_flutter/core/common/app/tab_navigator.dart';
import 'package:stocktrack_flutter/core/common/views/presistent_view.dart';
import 'package:stocktrack_flutter/src/home/presentation/views/home_view.dart';
import 'package:stocktrack_flutter/src/item/presentation/views/item_view.dart';
import 'package:stocktrack_flutter/src/supplier/presentation/views/supplier_view.dart';

/// `DashboardController` is responsible for managing the state and navigation
/// within your dashboard, while the `PersistentView` widget is responsible for
/// displaying the content of the selected tab and keeping its state alive when
/// switching between tabs. The combination of these components allows you to
/// create a persistent and navigable tabbed interface.
class DashboardController extends ChangeNotifier {
  /// This is a list that keeps track of the history of indices for the screens
  /// displayed in the dashboard. It initially contains a single value, `0`,
  /// which corresponds to the first screen.
  List<int> _indexHistory = [0];

  // This variable keeps track of the currently selected screen index.
  int _currentIndex = 1;
  int get currentIndex => _currentIndex;

  final List<Widget> _screens = [
    // Home View
    ChangeNotifierProvider(
      create: (_) => TabNavigator(TabItem(child: const HomeView())),
      child: const PersistentView(),
    ),

    // Supplier View
    ChangeNotifierProvider(
      create: (_) => TabNavigator(TabItem(child: const SupplierView())),
      child: const PersistentView(),
    ),

    // Item View
    ChangeNotifierProvider(
      create: (_) => TabNavigator(TabItem(child: const ItemView())),
      child: const PersistentView(),
    ),
  ];

  List<Widget> get screens => _screens;

  /// This method is used to change the current screen `index`. It takes an
  /// `index` parameter and updates `_currentIndex` with the new index. It also
  /// adds the new index to `_indexHistory` to keep track of the navigation
  /// history.
  void changeIndex(int index) {
    if (_currentIndex == index) return;
    _currentIndex = index;
    _indexHistory.add(index);
    notifyListeners();
  }

  /// This method is used to navigate back to the previous screen. It removes
  /// the last index from `_indexHistory` and updates `_currentIndex` with the
  /// new last index.
  void goBack() {
    if (_indexHistory.length == 1) return;
    _indexHistory.removeLast();
    _currentIndex = _indexHistory.last;
    notifyListeners();
  }

  /// This method is used to reset the screen index and history back to the
  /// initial state, with only the first screen `(index 0)` in `_indexHistory`.
  void resetIndex() {
    _indexHistory = [0];
    _currentIndex = 0;
    notifyListeners();
  }
}

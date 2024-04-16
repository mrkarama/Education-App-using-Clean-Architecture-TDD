import 'package:education_app/core/common/app/providers/tab_navigator.dart';
import 'package:education_app/core/common/views/persistent_view.dart';
import 'package:education_app/src/profile/views/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DashboardController extends ChangeNotifier {
  DashboardController();

  final List<Widget> _screens = [
    // Home
    ChangeNotifierProvider(
      create: (_) => TabNavigator(
        TabItem(
          child: const Placeholder(),
        ),
      ),
      child: const PersistentView(),
    ),

    // Materials
    ChangeNotifierProvider(
      create: (_) => TabNavigator(
        TabItem(
          child: const Placeholder(),
        ),
      ),
      child: const PersistentView(),
    ),

    // More
    ChangeNotifierProvider(
      create: (_) => TabNavigator(
        TabItem(
          child: const Placeholder(),
        ),
      ),
      child: const PersistentView(),
    ),

    // Chat
    ChangeNotifierProvider(
      create: (_) => TabNavigator(
        TabItem(
          child: const Placeholder(),
        ),
      ),
      child: const PersistentView(),
    ),

    // Profile
    ChangeNotifierProvider(
      create: (_) => TabNavigator(
        TabItem(
          child: const ProfileView(),
        ),
      ),
      child: const PersistentView(),
    ),
  ];

  List<Widget> get screens => _screens;

  int _currentIndex = 4; // ProfileView
  int get currentIndex => _currentIndex;

  List<int> _pageHistory = [4];

  void changeIndex(int index) {
    if (_currentIndex != index) {
      _currentIndex = index;
      notifyListeners();
    }
  }

  void goBack() {
    if (_pageHistory.length > 1) return;
    _pageHistory.removeLast();
    _currentIndex = _pageHistory.last;
    notifyListeners();
  }

  void reset() {
    _pageHistory = [4];
    _currentIndex = 4;
    notifyListeners();
  }
}

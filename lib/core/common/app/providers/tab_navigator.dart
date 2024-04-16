import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class TabNavigator extends ChangeNotifier {
  TabNavigator(this._initialPage) {
    _navigationStack.add(_initialPage);
  }

  final TabItem _initialPage;

  final List<TabItem> _navigationStack = [];

  TabItem get _currentpage => _navigationStack.last;
  TabItem get currentPage => _currentpage;

  // Navigation functionalities
  void pop() {
    if (_navigationStack.length > 1) {
      _navigationStack.removeLast();
      notifyListeners();
    }
  }

  void push(TabItem page) {
    _navigationStack.add(page);
    notifyListeners();
  }

  void popTo(TabItem page) {
    _navigationStack.remove(page); // Because of the Equatable it will remove
    notifyListeners(); // exact page
  }

  void popToRoot() {
    _navigationStack
      ..clear()
      ..add(_initialPage);
    notifyListeners();
  }

  void popUntil(TabItem? page) {
    if (page == null) popToRoot();

    _navigationStack.removeRange(0, _navigationStack.indexOf(page!));
    notifyListeners();
  }

  void pushAndRemoveUntil(TabItem page) {
    _navigationStack
      ..clear()
      ..add(page); // Bit same as popToRoot
    notifyListeners();
  }
}

class TabNavigatorProvider extends InheritedNotifier<TabNavigator> {
  const TabNavigatorProvider({
    required this.navigator,
    required super.child,
    super.key,
  }) : super(notifier: navigator);

  final TabNavigator navigator;

  static TabNavigator? of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType();
}

class TabItem extends Equatable {
  TabItem({
    required this.child,
  }) : id = const Uuid().v1();

  final Widget child;
  final String id;

  @override
  List<Object> get props => [child, id];
}

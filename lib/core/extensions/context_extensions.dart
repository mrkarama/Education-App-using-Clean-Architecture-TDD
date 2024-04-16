import 'package:education_app/core/common/app/providers/tab_navigator.dart';
import 'package:education_app/core/common/app/providers/user_provider.dart';
import 'package:education_app/src/authentication/domain/entities/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

extension ContextExtensions on BuildContext {
  MediaQueryData get mediaQuery => MediaQuery.of(this);

  Size get size => mediaQuery.size;
  double get width => size.width;
  double get height => size.height;

  ThemeData get themeData => Theme.of(this);

  UserProvider get userProvider => read<UserProvider>();

  LocaleUser? get currentUser => userProvider.user;

  // Stack Navigation shortcuts

  TabNavigator get tabNavigator => read<TabNavigator>();

  void pop() => tabNavigator.pop();
  void push(TabItem page) => tabNavigator.push(page);
}

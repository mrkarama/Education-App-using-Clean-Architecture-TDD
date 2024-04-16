import 'package:education_app/src/authentication/domain/entities/user.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  UserProvider();

  LocaleUser? _user;
  LocaleUser? get user => _user;

  void initUser(LocaleUser? user) {
    if (_user != user) _user = user;
  }

  set user(LocaleUser? user) {
    if (_user != user) {
      _user = user;

      Future.delayed(Duration.zero, notifyListeners);
    }
  }
}

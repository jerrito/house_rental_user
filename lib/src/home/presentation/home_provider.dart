import 'package:flutter/material.dart';
import 'package:house_rental/src/authentication/domain/entities/user.dart';

class HomeProvider extends ChangeNotifier {
  User? _user;

  User? get user => _user;

  setUser(User? user) {
    _user = user;
    notifyListeners();
  }
}

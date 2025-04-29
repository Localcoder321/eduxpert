import 'package:flutter/cupertino.dart';

class AuthStateNotifier extends ChangeNotifier {
  bool _isLoggedIn;

  AuthStateNotifier(this._isLoggedIn);

  bool get isLoggedIn => _isLoggedIn;

  void setLoggedIn(bool value) {
    _isLoggedIn = value;
    notifyListeners();
  }
}
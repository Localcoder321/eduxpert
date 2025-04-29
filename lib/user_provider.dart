import 'package:flutter/cupertino.dart';

class UserProvider with ChangeNotifier {
  String _name = "";
  String _email = "";

  String get name => _name;
  String get email => _email;

  void setUserData(String name, String email) {
    _email = email;
    _name = name;
    notifyListeners();
  }

  void updateName(String name) {
    _name = name;
    notifyListeners();
  }

  void updateEmail(String email) {
    _email = email;
    notifyListeners();
  }
}

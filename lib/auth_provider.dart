import 'package:eduxpert/core/service/firebase/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider1 with ChangeNotifier {
  final AuthService _authService = AuthService();
  bool _isLoggedIn = false;
  User? _user;

  AuthProvider1() {
    loadLoginState();
  }

  bool get isLoggedIn => _isLoggedIn;
  User? get user => _user;

  Future<void> loadLoginState() async {
    final prefs = await SharedPreferences.getInstance();
    final loggedIn = prefs.getBool("is_logged-in") ?? false;

    if (loggedIn) {
      _user = FirebaseAuth.instance.currentUser;
      _isLoggedIn = _user != null;
    } else {
      _isLoggedIn = false;
    }
    notifyListeners();
  }

  Future<bool> login(String email, String password) async {
    try {
      _user = await _authService.login(email, password);
      if (_user != null) {
        _isLoggedIn = true;
        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool("is_logged-in", true);
        notifyListeners();
        return true;
      }
    } catch (e) {
      print("Login error $e");
    }
    return false;
  }

  Future<bool> register(String name, String email, String password) async {
    try {
      _user = await _authService.register(email, password, name);
      if (_user != null) {
        _isLoggedIn = true;
        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool('is_logged-in', true);
        notifyListeners();
        return true;
      }
    } catch (e) {
      print("Register error $e");
    }
    return false;
  }

  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove("is_logged-in");
    _user = null;
    _isLoggedIn = false;
    notifyListeners();
  }

  Future<void> deleteAccount() async {
    await _user?.delete();
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove("is_logged-in");
    _user = null;
    _isLoggedIn = false;
    notifyListeners();
  }
}

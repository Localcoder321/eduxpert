import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //Register
  Future<User?> register(String email, String password, String username) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      await userCredential.user?.updateDisplayName(username);
      await userCredential.user?.reload();

      return _auth.currentUser;
    } catch (e) {
      print("Register error! $e");
      return null;
    }
  }

  //Login
  Future<User?> login(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return userCredential.user;
    } catch (e) {
      print("Login error! $e");
      return null;
    }
  }

  //Logout
  Future<void> logout() async {
    await _auth.signOut();
  }

  //Delete account
  Future<void> deleteUser(String password) async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        AuthCredential credential = EmailAuthProvider.credential(
            email: user.email!, password: password);
        await user.reauthenticateWithCredential(credential);
        await user.delete();
        print("User deleted successfully.");
      } else {
        print("Not registered user");
      }
    } catch (e) {
      print("Error in deleting user: $e");
      if (e.toString().contains('requires-recent-login')) {
        print("User needs to re-authenticate before deletion.");
      }
    }
  }

  // Check if user is logged in
  User? getCurrentUser() {
    return _auth.currentUser;
  }
}

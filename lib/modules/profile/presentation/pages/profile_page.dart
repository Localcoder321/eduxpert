import 'package:eduxpert/core/service/firebase/auth_service.dart';
import 'package:eduxpert/modules/profile/presentation/widgets/custom_button.dart';
import 'package:eduxpert/modules/profile/presentation/widgets/profile_tile.dart';
import 'package:eduxpert/modules/register_login/presentation/widgets/custom_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final AuthService _authService = AuthService();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? user;

  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController passwordController;

  bool isEditingName = false;
  bool isEditingEmail = false;
  bool isEditingPassword = false;

  @override
  void initState() {
    super.initState();
    user = _auth.currentUser;
    nameController = TextEditingController(text: user?.displayName ?? "");
    emailController = TextEditingController(text: user?.email ?? "");
    passwordController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: GestureDetector(
          onTap: () => context.pop(),
          child: const Icon(
            Icons.keyboard_backspace_rounded,
            color: Colors.black,
          ),
        ),
        title: const Text(
          "Profile",
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 40),
            ProfileTile(
              label: 'Name',
              initialValue: user?.displayName ?? "Unknown",
              onSaved: (String value) => _updateUsername(value),
            ),
            const Divider(color: Colors.grey),
            ProfileTile(
              label: 'Email',
              initialValue: user?.email ?? "Unknown",
              onSaved: (String value) => _updateEmail(value),
            ),
            const Divider(color: Colors.grey),
            ProfileTile(
              label: 'Password',
              initialValue: "********",
              isPassword: true,
              onSaved: (String value) => _updatePassword(value),
            ),
            const Divider(color: Colors.grey),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomButton(
                  snackBarText: 'Logged out from the account',
                  icon: 'assets/icons/logout.svg',
                  text: 'Logout',
                  onTap: () => _handleLogout(context, _authService),
                ),
                CustomButton(
                  snackBarText: 'Account successfully deleted',
                  icon: 'assets/icons/trash.svg',
                  text: 'Delete account',
                  onTap: () => _showPasswordDialog(context, _authService),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _handleLogout(BuildContext context, AuthService authService) async {
    bool confirmed = await _showConfirmationDialog(
      context,
      "Logout",
      "Are you sure you want to log out?",
    );

    if (confirmed) {
      await authService.logout();
      context.go('/register_page');
    }
  }

  void _handleDeleteAccount(
      BuildContext context, AuthService authService, String password) async {
    try {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Account deleted successfully."),
          backgroundColor: Colors.green,
        ),
      );
      context.go('/register_page');
      await authService.deleteUser(password);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Error deleting account: ${e.toString()}"),
        backgroundColor: Colors.red,
      ));
    }
  }

  void _showPasswordDialog(BuildContext context, AuthService authService) {
    TextEditingController passwordController = TextEditingController();

    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text("Confirm Account Deletion"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text("Please enter your password to proceed."),
                  const SizedBox(height: 10),
                  CustomTextField(
                    hintText: "Enter your password",
                    isPassword: true,
                    controller: passwordController,
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Cancel"),
                ),
                TextButton(
                  onPressed: () async {
                    Navigator.pop(context);
                    _handleDeleteAccount(
                      context,
                      authService,
                      passwordController.text.trim(),
                    );
                  },
                  child: const Text(
                    "Delete",
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ],
            ));
  }

  Future<bool> _showConfirmationDialog(
      BuildContext context, String title, String content) async {
    return await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(title),
            content: Text(content),
            actions: [
              TextButton(
                  onPressed: () => Navigator.pop(context, false),
                  child: const Text("Cancel")),
              TextButton(
                onPressed: () => Navigator.pop(context, true),
                child: const Text(
                  "Yes",
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ],
          ),
        ) ??
        false;
  }

  Future<void> _updateUsername(String newName) async {
    try {
      await user?.updateDisplayName(nameController.text);
      await user?.reload();
      user = _auth.currentUser;
      setState(() {
        isEditingName = false;
      });
      _showMessage("Name updated successfully!");
    } catch (e) {
      _showMessage("Error updating name ${e.toString()}", isError: true);
    }
  }

  Future<void> _updateEmail(String newEmail) async {
    try {
      await user?.updateEmail(emailController.text);
      await user?.reload();
      user = _auth.currentUser;
      setState(() {
        isEditingEmail = false;
      });
      _showMessage("Email updated successfully!");
    } catch (e) {
      _showMessage("Error updating email ${e.toString()}", isError: true);
    }
  }

  Future<void> _updatePassword(String newPassword) async {
    try {
      await user?.updatePassword(passwordController.text);
      await user?.reload();
      user = _auth.currentUser;
      setState(() {
        isEditingPassword = false;
      });
      _showMessage("Password updated successfully!");
    } catch (e) {
      _showMessage("Error updating password ${e.toString()}", isError: true);
    }
  }

  void _showMessage(String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      backgroundColor: isError ? Colors.red : Colors.green,
    ));
  }
}

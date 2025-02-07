import 'package:eduxpert/core/service/firebase/auth_service.dart';
import 'package:eduxpert/modules/profile/presentation/widgets/custom_button.dart';
import 'package:eduxpert/modules/profile/presentation/widgets/profile_tile.dart';
import 'package:eduxpert/modules/register_login/presentation/widgets/custom_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthService _authService = AuthService();
    User? user = FirebaseAuth.instance.currentUser;

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
            ProfileTile(text: user?.displayName ?? "Unknown"),
            const Divider(
              color: Colors.grey,
            ),
            const ProfileTile(text: "Age"),
            const Divider(
              color: Colors.grey,
            ),
            ProfileTile(text: user?.email ?? "Unknown"),
            const Divider(
              color: Colors.grey,
            ),
            const ProfileTile(text: "Password"),
            const Divider(
              color: Colors.grey,
            ),
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
}

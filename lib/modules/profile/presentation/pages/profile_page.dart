import 'package:eduxpert/core/service/provider/auth_provider.dart';
import 'package:eduxpert/core/service/firebase/auth_service.dart';
import 'package:eduxpert/modules/profile/presentation/widgets/custom_button.dart';
import 'package:eduxpert/modules/profile/presentation/widgets/profile_tile.dart';
import 'package:eduxpert/modules/register_login/presentation/widgets/custom_textfield.dart';
import 'package:eduxpert/core/service/provider/user_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  late ScaffoldMessengerState scaffoldMessenger;

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
  void didChangeDependencies() {
    super.didChangeDependencies();
    scaffoldMessenger = ScaffoldMessenger.of(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: GestureDetector(
          onTap: () => context.go("/main_page"),
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
            Consumer<UserProvider>(
              builder: (context, userProvider, child) {
                return ProfileTile(
                  label: 'Name',
                  initialValue: userProvider.name,
                  onSaved: (String value) => _updateUsername(value),
                );
              },
            ),
            const Divider(color: Colors.grey),
            Consumer<UserProvider>(builder: (context, userProvider, child) {
              return ProfileTile(
                label: 'Email',
                initialValue: userProvider.email,
                onSaved: (String value) => _updateEmail(value),
              );
            }),
            const Divider(color: Colors.grey),
            Consumer<UserProvider>(builder: (context, userProvider, child) {
              return ProfileTile(
                label: 'Password',
                initialValue: "********",
                isPassword: true,
                onSaved: (String value) => _updatePassword(value),
              );
            }),
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
                  onTap: () => _showPasswordDialog(context),
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

    if (!confirmed) return;

    await authService.logout();

    if (mounted) {
      context.read<AuthProvider1>().logout();
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool("is_logged-in", false);
    }

    if (!mounted) return;
    context.go('/register_page');
  }

  void _handleDeleteAccount(BuildContext safeContext, AuthService authService,
      String password) async {
    try {
      final user = FirebaseAuth.instance.currentUser;

      if (user != null && user.email != null) {
        final cred = EmailAuthProvider.credential(
            email: user.email!, password: password);
        await user.reauthenticateWithCredential(cred);
      }

      await authService.deleteUser(password);

      if(safeContext.mounted) {
        safeContext.read<AuthProvider1>().logout();
        print("pre-final stage");
      }
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool("is_logged-in", false);
      print("final stage");

      if (safeContext.mounted) {
        print("yeah boy");
        safeContext.go('/register_page');
      }
    } catch (e) {
      print("Account deletion error: $e");
      ScaffoldMessenger.of(safeContext).showSnackBar(
        const SnackBar(
            content: Text("Account deletion failed. Check your password.")),
      );
    }
  }

  Future<String?> _showPasswordDialog(BuildContext safeContext) async {
    final passwordController = TextEditingController();
    return showDialog<String?>(
        context: safeContext,
        builder: (dialogContext) => AlertDialog(
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
                  onPressed: () {
                    Navigator.pop(dialogContext);
                  },
                  child: const Text("Cancel"),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(dialogContext);
                    print("here we go");
                    _handleDeleteAccount(
                      safeContext,
                      _authService,
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
      await user?.updateDisplayName(newName);
      await _auth.currentUser?.reload();
      user = _auth.currentUser;

      if (mounted) {
        context.read<UserProvider>().updateName(user?.displayName ?? "Guest");
      }

      setState(() {
        nameController.text = user?.displayName ?? "";
        isEditingName = false;
      });
      _showMessage("Name updated successfully!");
    } catch (e) {
      _showMessage("Error updating name ${e.toString()}", isError: true);
    }
  }

  Future<void> _updateEmail(String newEmail) async {
    try {
      await user?.updateEmail(newEmail);
      await _auth.currentUser?.reload();
      user = _auth.currentUser;

      if (mounted) {
        context.read<UserProvider>().updateEmail(user?.email ?? "No email");
      }

      setState(() {
        emailController.text = user?.email ?? "";
        isEditingEmail = false;
      });
      _showMessage("Email updated successfully!");
    } on FirebaseAuthException catch (e) {
      if (e.code == "requires-recent-login") {
        _showMessage("Please re-authenticate to update email.", isError: true);
      } else {
        _showMessage("Error updating email ${e.toString()}", isError: true);
      }
    }
  }

  Future<void> _updatePassword(String newPassword) async {
    try {
      await user?.updatePassword(newPassword);
      await _auth.currentUser?.reload();
      user = _auth.currentUser;
      passwordController.clear();
      _showMessage("Password updated successfully!");
    } on FirebaseAuthException catch (e) {
      if (e.code == "requires-recent-login") {
        _showMessage("Please re-authenticate to update password.",
            isError: true);
      } else {
        _showMessage("Error updating password ${e.toString()}", isError: true);
      }
    }
  }

  void _showMessage(String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      backgroundColor: isError ? Colors.red : Colors.green,
    ));
  }
}

import 'package:eduxpert/auth_provider.dart';
import 'package:eduxpert/modules/register_login/presentation/widgets/custom_textfield.dart';
import 'package:eduxpert/user_provider.dart';
import 'package:eduxpert/utils/constants/show_error.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterWidget extends StatefulWidget {
  const RegisterWidget({super.key});

  @override
  State<RegisterWidget> createState() => _RegisterWidgetState();
}

class _RegisterWidgetState extends State<RegisterWidget> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isLoading = false;

  void handleRegister() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      isLoading = true;
    });

    String name = nameController.text.trim();
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    final authProvider = Provider.of<AuthProvider1>(context, listen: false);
    final success = await authProvider.register(name, email, password);

    if (success && mounted) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool("is_logged-in", true);

      final user = authProvider.user;
      if (user != null) {
        Provider.of<UserProvider>(context, listen: false)
            .setUserData(user.displayName ?? name, user.email ?? email);
      }
      if (!mounted) return;
      context.go('/uni_selection_page');
    } else if (mounted) {
      ShowError(context, "Invalid email or password");
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          const Text(
            "Welcome",
            style: TextStyle(
              color: Colors.black,
              fontSize: 40,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: CustomTextField(
              hintText: "Your name",
              isPassword: false,
              controller: nameController,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "Name is required";
                }
                return null;
              },
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: CustomTextField(
              hintText: "Your email",
              isPassword: false,
              textInputType: TextInputType.emailAddress,
              controller: emailController,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "Email is required";
                }
                if (!value.contains("@")) {
                  return "Invalid email address";
                }
                return null;
              },
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: CustomTextField(
              hintText: "Your new password",
              isPassword: true,
              controller: passwordController,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "Password is required";
                }
                if (value.length < 6) {
                  return "Minimum 6 characters required";
                }
                return null;
              },
            ),
          ),
          const SizedBox(height: 42),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: GestureDetector(
              onTap: isLoading ? null : handleRegister,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: const Color(0xFF1399FF),
                ),
                child: Center(
                  child: isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text(
                          "Register",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

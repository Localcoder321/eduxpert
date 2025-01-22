import 'package:eduxpert/modules/register_login/presentation/widgets/login_widget.dart';
import 'package:eduxpert/modules/register_login/presentation/widgets/register_widget.dart';
import 'package:flutter/material.dart';

class LoginRegisterToggleButton extends StatefulWidget {
  const LoginRegisterToggleButton({super.key});

  @override
  State<LoginRegisterToggleButton> createState() =>
      _LoginRegisterToggleButtonState();
}

class _LoginRegisterToggleButtonState extends State<LoginRegisterToggleButton> {
  bool isLoginSelected = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 85.0),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 0),
            height: 30, // Keep height consistent while allowing width to adjust
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: const Color(0xFFD9D9D9),
            ),
            child: Stack(
              children: [
                AnimatedAlign(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  alignment: isLoginSelected
                      ? Alignment.centerLeft
                      : Alignment.centerRight,
                  child: FractionallySizedBox(
                    widthFactor:
                        0.5, // Make the sliding container 50% of parent width
                    child: Container(
                      height: double.infinity, // Match parent height
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            isLoginSelected = true;
                          });
                        },
                        child: Center(
                          child: Text(
                            "Login",
                            style: TextStyle(
                              color: isLoginSelected
                                  ? Colors.black
                                  : Colors.grey[700],
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            isLoginSelected = false;
                          });
                        },
                        child: Center(
                          child: Text(
                            "Register",
                            style: TextStyle(
                              color: !isLoginSelected
                                  ? Colors.black
                                  : Colors.grey[700],
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),
        // Dynamically switch between Login and Register widgets
        isLoginSelected ? const LoginWidget() : const RegisterWidget(),
      ],
    );
  }
}

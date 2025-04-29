import 'package:eduxpert/modules/register_login/presentation/widgets/toggle_button.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.only(
          top: MediaQuery.paddingOf(context).top,
          bottom: MediaQuery.paddingOf(context).bottom,
        ),
        child: const Column(
          children: [
            LoginRegisterToggleButton(),
          ],
        ),
      ),
    );
  }
}

import 'package:eduxpert/modules/profile/presentation/widgets/new_subscription_button.dart';
import 'package:eduxpert/modules/profile/presentation/widgets/subscription_card.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SubscriptionsPage extends StatelessWidget {
  const SubscriptionsPage({super.key});

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
          "Your subscriptions",
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            SubscriptionCard(
              uniName: "Westminster International University in Tashkent",
              period: "03.01-03.05.2025",
            ),
            SizedBox(height: 16),
            NewSubscriptionButton(),
          ],
        ),
      ),
    );
  }
}

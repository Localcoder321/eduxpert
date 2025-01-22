import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: MediaQuery.paddingOf(context).top,
        //bottom: MediaQuery.paddingOf(context).bottom,
      ),
      child: Drawer(
        backgroundColor: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            children: [
              ListTile(
                onTap: () => context.push("/profile_page"),
                leading: const Icon(
                  Icons.person_2,
                  color: Colors.black,
                ),
                title: const Text(
                  "Profile",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              const Divider(color: Colors.grey),
              ListTile(
                onTap: () => context.push("/subscriptions_page"),
                leading: const Icon(
                  Icons.credit_card,
                  color: Colors.black,
                ),
                title: const Text(
                  "Subscription",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

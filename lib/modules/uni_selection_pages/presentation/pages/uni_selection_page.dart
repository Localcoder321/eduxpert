import 'package:eduxpert/core/router/app_router.dart';
import 'package:eduxpert/modules/uni_selection_pages/presentation/widgets/custom_container.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class UniSelectionPage extends StatelessWidget {
  const UniSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.only(
          top: MediaQuery.paddingOf(context).top,
          bottom: MediaQuery.paddingOf(context).bottom,
        ),
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(
                bottom: 65,
                top: 80,
                left: 16,
                right: 16,
              ),
              child: Text(
                "Choose the university you want to enter",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 32, right: 32, bottom: 20),
              child: CustomContainer(
                text: "WIUT",
                textColor: const Color(0xFF1100FF),
                fontWeight: FontWeight.w600,
                textSize: 20,
                onTap: () {
                  context.push('/subscription_page');
                },
              ),
            ),
            /*Padding(
              padding: const EdgeInsets.only(left: 32, right: 32, bottom: 20),
              child: CustomContainer(
                text: "MDIST",
                fontWeight: FontWeight.w600,
                textColor: const Color(0xFFFF4141),
                textSize: 20,
                onTap: () {},
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 32, right: 32, bottom: 20),
              child: CustomContainer(
                text: "Government universities",
                onTap: () {},
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 32, right: 32, bottom: 20),
              child: CustomContainer(
                text: "Custom selection of subjects",
                onTap: () {},
              ),
            ),*/
          ],
        ),
      ),
    );
  }
}

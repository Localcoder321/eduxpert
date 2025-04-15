import 'package:eduxpert/modules/profile/presentation/widgets/payment_methods_widget.dart';
import 'package:eduxpert/modules/profile/presentation/widgets/selected_subjects_list.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

class SubscriptionPage extends StatefulWidget {
  const SubscriptionPage({super.key});

  @override
  State<SubscriptionPage> createState() => _SubscriptionPageState();
}

class _SubscriptionPageState extends State<SubscriptionPage>
    with WidgetsBindingObserver {
  int selectedPaymentMethod = -1;
  bool _isWaitingForPayment = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed && _isWaitingForPayment) {
      _isWaitingForPayment = false;
      context.go("/main_page");
    }
  }

  void _onPaymentMethodSelected(int index) {
    setState(() {
      selectedPaymentMethod = index;
    });
  }

  void _handlePay() async {
    if (selectedPaymentMethod.isNegative) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please select payment method!"),
        ),
      );
      return;
    }

    Uri paymentUrl;

    if (selectedPaymentMethod == 0) {
      paymentUrl = Uri.parse(
          "https://checkout.paycom.uz/fake_merchant_id?amount=10000&account[user_id]=123");
    } else {
      paymentUrl = Uri.parse(
          "https://my.click.uz/services/pay?service_id=9999&merchant_id=9999&amount=10000&transaction_param=123");
    }

    if (await canLaunchUrl(paymentUrl)) {
      _isWaitingForPayment = true;
      await launchUrl(paymentUrl, mode: LaunchMode.externalApplication);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Could not launch payment page."),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.only(
          top: MediaQuery.paddingOf(context).top,
          bottom: MediaQuery.paddingOf(context).bottom,
          left: 32,
          right: 32,
        ),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: GestureDetector(
                  onTap: () => context.pop(),
                  child: const Icon(
                    Icons.keyboard_backspace_rounded,
                    color: Colors.black,
                  )),
            ),
            const Text(
              "Subjects included to your subscription",
              style: TextStyle(
                color: Colors.black,
                fontSize: 26,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 28),
            const SelectedSubjectsList(),
            const SizedBox(height: 20),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Payment method:",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 8),
            PaymentMethods(
              onPaymentMethodSelected: _onPaymentMethodSelected,
            ),
            const SizedBox(height: 24),
            RichText(
              text: const TextSpan(
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                  children: [
                    TextSpan(
                      text: "Warning:\n",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                    TextSpan(
                      text:
                          "This subscription will continue only 3 month and after that you need to renew it if needed also will work only in one device.",
                    ),
                  ]),
            ),
            const Spacer(),
            GestureDetector(
              onTap: _handlePay,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: selectedPaymentMethod.isNegative
                      ? Colors.grey
                      : const Color(0xFF1399FF),
                ),
                child: const Center(
                  child: Text(
                    "Pay",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

import 'package:eduxpert/assets/constants/app_images.dart';
import 'package:flutter/material.dart';

class PaymentMethods extends StatefulWidget {
  final Function(int) onPaymentMethodSelected;

  const PaymentMethods({
    super.key,
    required this.onPaymentMethodSelected,
  });

  @override
  State<PaymentMethods> createState() => _PaymentMethodsState();
}

class _PaymentMethodsState extends State<PaymentMethods> {
  int selectedIndex = -1;

  void _selectPaymentMethod(int index) {
    setState(() {
      selectedIndex = index;
    });
    widget.onPaymentMethodSelected(index);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () => _selectPaymentMethod(0),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 40),
            width: 155,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                width: 2,
                color:
                    selectedIndex == 0 ? const Color(0xFF1399FF) : Colors.black,
              ),
              color: Colors.transparent,
            ),
            child: Image.asset(AppImages.payme),
          ),
        ),
        const SizedBox(width: 10),
        GestureDetector(
          onTap: () => _selectPaymentMethod(1),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 40),
            width: 155,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                  width: 2,
                  color: selectedIndex == 1
                      ? const Color(0xFF1399FF)
                      : Colors.black),
              color: Colors.transparent,
            ),
            child: Image.asset(AppImages.click),
          ),
        ),
      ],
    );
  }
}

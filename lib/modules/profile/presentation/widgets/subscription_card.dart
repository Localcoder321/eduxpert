import 'package:flutter/material.dart';

class SubscriptionCard extends StatelessWidget {
  final String uniName;
  final String period;
  const SubscriptionCard({
    super.key,
    required this.uniName,
    required this.period,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Colors.black,
          ),
          color: Colors.transparent,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                uniName,
                softWrap: true,
              ),
            ),
            const SizedBox(width: 45),
            Text(period),
          ],
        ),
      ),
    );
  }
}

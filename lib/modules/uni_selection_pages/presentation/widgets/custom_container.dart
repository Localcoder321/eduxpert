import 'package:flutter/material.dart';

class CustomContainer extends StatelessWidget {
  final String text;
  final Color? textColor;
  final double? textSize;
  final FontWeight? fontWeight;
  final void Function()? onTap;
  const CustomContainer({
    super.key,
    required this.text,
    this.textColor,
    this.textSize,
    this.fontWeight,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.black, width: 1),
          color: Colors.transparent,
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: textColor ?? Colors.black,
              fontSize: textSize ?? 14,
              fontWeight: fontWeight ?? FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }
}

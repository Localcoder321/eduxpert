import 'package:flutter/material.dart';

class ProfileTile extends StatelessWidget {
  final String text;
  const ProfileTile({
    required this.text,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),
        const Icon(Icons.edit_outlined),
      ],
    );
  }
}

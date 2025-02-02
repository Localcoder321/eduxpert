import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomLessonCard extends StatelessWidget {
  final String text;
  final String? url;
  const CustomLessonCard({
    super.key,
    required this.text,
    this.url,
  });

  bool _isValidUrl(String? url) {
    return url != null && Uri.tryParse(url)?.hasAbsolutePath == true;
  }

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw "Could not launch $url";
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isUrl = _isValidUrl(url);
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: GestureDetector(
        onTap: isUrl ? () => _launchUrl(url!) : null,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 12,
          ),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(12),
            color: Colors.transparent,
          ),
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }
}

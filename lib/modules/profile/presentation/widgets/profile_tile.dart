import 'package:flutter/material.dart';

class ProfileTile extends StatefulWidget {
  final String initialValue;
  final String label;
  final bool isPassword;
  final ValueChanged<String> onSaved;

  const ProfileTile({
    super.key,
    required this.initialValue,
    required this.label,
    required this.onSaved,
    this.isPassword = false,
  });

  @override
  State<ProfileTile> createState() => _ProfileTileState();
}

class _ProfileTileState extends State<ProfileTile> {
  late TextEditingController _controller;
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _isEditing
            ? Expanded(
                child: TextField(
                  controller: _controller,
                  obscureText: widget.isPassword,
                  decoration: InputDecoration(
                    hintText: "Enter new ${widget.label}",
                    border: InputBorder.none,
                  ),
                ),
              )
            : Text(
                "${widget.label}: ${widget.isPassword ? '********' : widget.initialValue}",
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
        IconButton(
          onPressed: () {
            if (_isEditing) {
              widget.onSaved(_controller.text);
            }
            setState(() => _isEditing = !_isEditing);
          },
          icon: Icon(_isEditing ? Icons.check : Icons.edit_outlined),
        ),
      ],
    );
  }
}

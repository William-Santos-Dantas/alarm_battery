import 'package:flutter/material.dart';

class MobileInfoRow extends StatelessWidget {
  final String text;
  final IconData icon;
  final Color iconColor;
  const MobileInfoRow(
      {Key? key,
      required this.text,
      required this.icon,
      this.iconColor = Colors.white})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: iconColor),
        const SizedBox(width: 5),
        Text(
          text,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}

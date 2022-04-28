import 'package:flutter/material.dart';

class MobileInfoRow extends StatelessWidget {
  final String text;
  final IconData icon;
  const MobileInfoRow({Key? key, required this.text, required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon),
        const SizedBox(width: 5),
        Text(text),
      ],
    );
  }
}

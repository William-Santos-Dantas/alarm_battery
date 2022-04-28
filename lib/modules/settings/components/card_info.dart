import 'package:flutter/material.dart';

class CardInfo extends StatelessWidget {
  final String title;
  final Function(bool) onChanged;
  final bool value;
  final IconData icon;
  const CardInfo({Key? key, required this.title, required this.onChanged, required this.value, required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
        trailing: Switch(
          value: value,
          onChanged: onChanged,
        ),
      ),
    );
  }
}

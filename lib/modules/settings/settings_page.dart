import 'components/card_info.dart';
import "package:flutter/material.dart";
import "package:get/get.dart";

import 'settings_controller.dart';

class SettingsPage extends GetView<SettingsController> {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String dropdownValue = 'Ringtone';
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(8),
          children: [
            CardInfo(
              title: 'Theme',
              value: false,
              onChanged: (bool value) {},
              icon: Icons.dark_mode,
            ),
            CardInfo(
              title: 'Sound',
              value: false,
              onChanged: (bool value) {},
              icon: Icons.volume_off,
            ),
            CardInfo(
              title: 'Vibration',
              value: true,
              onChanged: (bool value) {},
              icon: Icons.smartphone,
            ),
            Card(
              elevation: 10,
              child: ListTile(
                title: const Text('Battery'),
                subtitle: Row(
                  children: [
                    Text('15'),
                    Expanded(
                      child: RangeSlider(
                        values: RangeValues(15, 100),
                        min: 15,
                        max: 100,
                        divisions: 85,
                        onChanged: (values) {},
                      ),
                    ),
                    Text("100"),
                  ],
                ),
              ),
            ),
            Card(
              elevation: 10,
              child: ListTile(
                leading: const Icon(Icons.notifications_active, size: 30),
                title: const Text('Alarm Sound'),
                subtitle: DropdownButton<String>(
                  value: dropdownValue,
                  icon: const Icon(Icons.arrow_downward),
                  isExpanded: true,
                  underline: const SizedBox.shrink(),
                  onChanged: (String? newValue) {
                    dropdownValue = newValue!;
                  },
                  items: <String>['Ringtone', 'Notification', 'Alarm']
                      .map<DropdownMenuItem<String>>(
                    (String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    },
                  ).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

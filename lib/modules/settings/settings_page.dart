import 'components/card_info.dart';
import "package:flutter/material.dart";
import "package:get/get.dart";

import 'settings_controller.dart';

class SettingsPage extends GetView<SettingsController> {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Obx(
          () => ListView(
            padding: const EdgeInsets.all(8),
            children: [
              CardInfo(
                title: 'Theme',
                value: controller.isDarkTheme,
                onChanged: controller.changeTheme,
                icon:
                    controller.isDarkTheme ? Icons.dark_mode : Icons.light_mode,
              ),
              CardInfo(
                title: "Sound",
                value: controller.settings.value.sound,
                onChanged: (bool value) {
                  controller.settings.value.setSound = value;
                  controller.saveSettings();
                },
                icon: Icons.volume_off,
              ),
              CardInfo(
                title: 'Vibration',
                value: controller.settings.value.vibrate,
                onChanged: (bool value) {
                  controller.settings.value.setVibrate = value;
                  controller.saveSettings();
                },
                icon: Icons.smartphone,
              ),
              Card(
                elevation: 10,
                child: ListTile(
                  title: const Text('Battery'),
                  subtitle: Row(
                    children: [
                      Text('${controller.settings.value.startValue.round()}'),
                      Expanded(
                        child: RangeSlider(
                          values: RangeValues(
                            controller.settings.value.startValue,
                            controller.settings.value.endValue,
                          ),
                          min: 15,
                          max: 100,
                          divisions: 85,
                          onChanged: (values) {
                            controller.settings.value.setStartValue =
                                values.start.roundToDouble();
                            controller.settings.value.setEndValue =
                                values.end.roundToDouble();
                            controller.saveSettings();
                          },
                        ),
                      ),
                      Text('${controller.settings.value.endValue.round()}'),
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
                    value: controller.settings.value.androidSound,
                    icon: const Icon(Icons.arrow_downward),
                    isExpanded: true,
                    underline: const SizedBox.shrink(),
                    onChanged: (String? value) {
                      controller.settings.value.setAndroidSound = value;
                      controller.saveSettings();
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
      ),
    );
  }
}

import 'dart:async';
import 'package:alarm_battery/models/settings_model.dart';
import 'package:battery_info/battery_info_plugin.dart';
import 'package:battery_info/enums/charging_status.dart';
import 'package:battery_info/model/android_battery_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_background_service_android/flutter_background_service_android.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final storage = FlutterSecureStorage();
Future<void> initializeService() async {
  final service = FlutterBackgroundService();
  await service.configure(
    androidConfiguration: AndroidConfiguration(
      onStart: onStartService,
      autoStart: true,
      isForegroundMode: true,
    ),
    iosConfiguration: IosConfiguration(
      autoStart: false,
      onForeground: onStartService,
      onBackground: onIosBackground,
    ),
  );
  service.startService();
}

bool onIosBackground(ServiceInstance service) {
  WidgetsFlutterBinding.ensureInitialized();
  return true;
}

void onStartService(ServiceInstance service) async {
  WidgetsFlutterBinding.ensureInitialized();
  if (service is AndroidServiceInstance) {
    service.on('setAsForeground').listen((event) {
      service.setAsForegroundService();
    });

    service.on('setAsBackground').listen((event) {
      service.setAsBackgroundService();
    });
  }

  service.on('stopService').listen((event) {
    service.stopSelf();
  });
  Timer.periodic(
    const Duration(seconds: 3),
    (timer) async {
      if (service is AndroidServiceInstance) {
        var _androidBatteryInfo = await BatteryInfoPlugin().androidBatteryInfo;
        SettingsModel settings;
        String batteryRemain = '';
        if (_androidBatteryInfo != null) {
          batteryRemain = getBatteryRemain(_androidBatteryInfo);
        }

        var settingsJson = await storage.read(key: 'settings');
        if (settingsJson != null) {
          settings = SettingsModel.fromJson(settingsJson);
        } else {
          settings = SettingsModel();
        }

        if (_androidBatteryInfo?.chargingStatus == ChargingStatus.Charging) {
          service.setForegroundNotificationInfo(
            title: "Battery: ${_androidBatteryInfo?.batteryLevel ?? 100}%",
            content: "Charging Battery",
          );
        } else {
          service.setForegroundNotificationInfo(
            title: "Battery: ${_androidBatteryInfo?.batteryLevel ?? 100}%",
            content: "Battery Remain: $batteryRemain",
          );
        }
      }
    },
  );
}

String getBatteryRemain(AndroidBatteryInfo batteryInfo) {
  double remainingEnergy = -(batteryInfo.remainingEnergy! * 1.0E-9);
  int estimateHour =
      ((batteryInfo.batteryCapacity! / 1000) / remainingEnergy) ~/ 60;
  double estimateMinutes =
      ((batteryInfo.batteryCapacity! / 1000) / remainingEnergy) % 60;
  return "${estimateHour}h${estimateMinutes.round() < 10 ? '0${estimateMinutes.round()}m' : '${estimateMinutes.round()}m'}";
}

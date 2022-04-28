import 'dart:async';
import 'dart:developer';
import 'package:alarm_battery/models/settings_model.dart';
import 'package:battery_info/battery_info_plugin.dart';
import 'package:battery_info/enums/charging_status.dart';
import 'package:battery_info/model/android_battery_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_background_service_android/flutter_background_service_android.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';

FlutterSecureStorage storage = const FlutterSecureStorage();
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

        if ((_androidBatteryInfo?.batteryLevel ?? 100) >= settings.endValue) {
          if (_androidBatteryInfo?.chargingStatus == ChargingStatus.Charging) {
            alarm(settings);
          } else {
            FlutterRingtonePlayer.stop();
          }
        } else if ((_androidBatteryInfo?.batteryLevel ?? 15) <=
            settings.startValue) {
          if (_androidBatteryInfo?.chargingStatus != ChargingStatus.Charging) {
            alarm(settings);
          } else {
            FlutterRingtonePlayer.stop();
          }
        } else {
          FlutterRingtonePlayer.stop();
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

void alarm(SettingsModel settings) async {
  try {
    if (settings.vibrate) {
      bool canVibrate = await Vibrate.canVibrate;
      if (canVibrate) {
        Vibrate.vibrateWithPauses([
          const Duration(milliseconds: 500),
          const Duration(milliseconds: 1000),
          const Duration(milliseconds: 500),
        ]);
      }
    }

    if (settings.sound) {
      switch (settings.androidSound) {
        case 'Notification':
          FlutterRingtonePlayer.play(
            android: AndroidSounds.notification,
            ios: IosSounds.glass,
            looping: false,
            volume: 0.1,
            asAlarm: false,
          );
          break;
        case 'Alarm':
          FlutterRingtonePlayer.play(
            android: AndroidSounds.alarm,
            ios: IosSounds.glass,
            looping: false,
            volume: 0.1,
            asAlarm: false,
          );
          break;
        case 'Ringtone':
          FlutterRingtonePlayer.play(
            android: AndroidSounds.ringtone,
            ios: IosSounds.glass,
            looping: false,
            volume: 0.1,
            asAlarm: false,
          );
          break;
      }
    }
  } catch (e) {
    log('Surgiu algum erro inesperado $e');
  }
}

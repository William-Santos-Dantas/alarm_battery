import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

class SettingsModel {
  final _sound = true.obs;
  final _vibrate = true.obs;
  final _startValue = 15.0.obs;
  final _endValue = 100.0.obs;
  final _androidSound = 'Ringtone'.obs;
  FlutterSecureStorage storage = const FlutterSecureStorage();

  SettingsModel({
    bool sound = true,
    bool vibrate = true,
    double startValue = 15.0,
    double endValue = 100.0,
    String androidSound = 'Ringtone',
  }) {
    setSound = sound;
    setVibrate = vibrate;
    setStartValue = startValue;
    setEndValue = endValue;
    setAndroidSound = androidSound;
  }

  Map<String, dynamic> toMap() {
    return {
      'sound': _sound.value,
      'vibrate': _vibrate.value,
      'startValue': _startValue.value,
      'endValue': _endValue.value,
      'androidSound': _androidSound.value,
    };
  }

  factory SettingsModel.fromMap(Map<String, dynamic> map) {
    return SettingsModel(
      sound: map['sound'] ?? false,
      vibrate: map['vibrate'] ?? false,
      startValue: map['startValue']?.toDouble() ?? 100.0,
      endValue: map['endValue']?.toDouble() ?? 15.0,
      androidSound: map['androidSound'] ?? 'Ringtone',
    );
  }

  String toJson() => json.encode(toMap());

  factory SettingsModel.fromJson(String source) => SettingsModel.fromMap(
        json.decode(source),
      );

  get sound => _sound.value;
  set setSound(dynamic value) => _sound(value);
  get vibrate => _vibrate.value;
  set setVibrate(dynamic value) => _vibrate(value);
  get startValue => _startValue.value;
  set setStartValue(dynamic value) => _startValue(value);
  get endValue => _endValue.value;
  set setEndValue(dynamic value) => _endValue(value);
  get androidSound => _androidSound.value;
  set setAndroidSound(dynamic value) => _androidSound(value);

  
}

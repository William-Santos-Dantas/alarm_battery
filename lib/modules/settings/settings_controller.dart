import 'package:alarm_battery/application/services/theme_service.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

import '../../models/settings_model.dart';

class SettingsController extends GetxController {
  final _isDarkTheme = false.obs;
  get isDarkTheme => _isDarkTheme.value;
  final settings = SettingsModel().obs;
  final storage = const FlutterSecureStorage();

  @override
  void onReady() async {
    super.onReady();
    _isDarkTheme(ThemeService().isSavedDarkMode());
    var settingsJson = await storage.read(key: 'settings');
    if (settingsJson != null) {
      settings.value = SettingsModel.fromJson(settingsJson);
    }
  }

  void saveSettings() async {
    await storage.write(key: 'settings', value: settings.value.toJson());
  }

  void changeTheme(bool value) {
    ThemeService().changeThemeMode();
    _isDarkTheme.toggle();
  }
}

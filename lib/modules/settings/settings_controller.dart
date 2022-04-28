import 'package:alarm_battery/application/services/theme_service.dart';
import 'package:get/get.dart';

import '../../models/settings_model.dart';

class SettingsController extends GetxController {
  final _isDarkTheme = false.obs;
  get isDarkTheme => _isDarkTheme.value;
  final settings = SettingsModel().obs;

  @override
  void onReady() {
    super.onReady();
    _isDarkTheme(ThemeService().isSavedDarkMode());
  }

  void changeTheme(bool value) {
    ThemeService().changeThemeMode();
    _isDarkTheme.toggle();
  }
}

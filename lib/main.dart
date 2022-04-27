import 'dart:async';
import 'package:alarm_battery/application/services/theme_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'application/bindings/application_bindings.dart';
import 'application/routes/routes.dart';
import 'application/ui/Application_ui_config.dart';

Future<void> main() async {
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialBinding: ApplicationBindings(),
      getPages: Routes.routes,
      title: ApplicationUiConfig.title,
      theme: ApplicationUiConfig.lightTheme,
      darkTheme: ApplicationUiConfig.darkTheme,
      themeMode: ThemeService().getThemeMode(),
    );
  }
}

import 'package:alarm_battery/application/services/theme_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'home_controller.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Theme'),
      ),
      body: Center(
        child: MaterialButton(
          onPressed: () {
            ThemeService().changeThemeMode();
          },
          child: Text('Switch Theme'),
        ),
      ),
    );
  }
}

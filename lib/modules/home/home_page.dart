import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../alarm/alarm_bindings.dart';
import '../alarm/alarm_page.dart';
import '../settings/settings_bindings.dart';
import '../settings/settings_page.dart';
import 'home_controller.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.transparent,
          elevation: 0,
          selectedItemColor: const Color(0xFFEA4335),
          unselectedItemColor: Colors.grey,
          onTap: controller.goToPage,
          currentIndex: controller.pageIndex,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.history),
              label: 'Historico',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Settings',
            ),
          ],
        ),
      ),
      body: Navigator(
        initialRoute: '/alarm',
        key: Get.nestedKey(HomeController.NAVIGATION_KEY),
        onGenerateRoute: (settings) {
          if (settings.name == '/alarm') {
            return GetPageRoute(
              settings: settings,
              page: () => const AlarmPage(),
              binding: AlarmBindings(),
            );
          }
          if (settings.name == '/historic') {
            return GetPageRoute(
              settings: settings,
              page: () => const AlarmPage(),
              binding: AlarmBindings(),
            );
          }
          if (settings.name == '/settings') {
            return GetPageRoute(
              settings: settings,
              page: () => const SettingsPage(),
              binding: SettingsBindings(),
            );
          }
          return null;
        },
      ),
    );
  }
}

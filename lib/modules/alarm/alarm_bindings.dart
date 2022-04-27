import 'package:get/get.dart';
import 'alarm_controller.dart';

class AlarmBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AlarmController());
  }
}

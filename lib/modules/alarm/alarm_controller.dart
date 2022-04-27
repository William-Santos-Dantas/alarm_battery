import 'package:battery_info/battery_info_plugin.dart';
import 'package:battery_info/model/android_battery_info.dart';
import 'package:get/get.dart';

class AlarmController extends GetxController {
  final _androidBatteryInfo = AndroidBatteryInfo().obs;
  get androidBatteryInfo => _androidBatteryInfo.value;
  final _estimatedTime = ''.obs;
  get estimatedTime => _estimatedTime.value;

  @override
  void onReady() {
    super.onReady();
    getAndroidInfo();
  }

  void getAndroidInfo() {
    BatteryInfoPlugin().androidBatteryInfoStream.listen(
      (AndroidBatteryInfo? batteryInfo) {
        if (batteryInfo != null) {
          _androidBatteryInfo(batteryInfo);
          double remainingEnergy = -(batteryInfo.remainingEnergy! * 1.0E-9);
          int estimateHour =
              ((batteryInfo.batteryCapacity! / 1000) / remainingEnergy) ~/ 60;
          double estimateMinutes =
              ((batteryInfo.batteryCapacity! / 1000) / remainingEnergy) % 60;
          _estimatedTime(
            "${estimateHour}h${estimateMinutes.round() < 10 ? '0${estimateMinutes.round()}m' : '${estimateMinutes.round()}m'}",
          );
        }
      },
    );
  }
}

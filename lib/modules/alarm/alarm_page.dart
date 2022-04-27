import 'package:battery_info/enums/charging_status.dart';
import "package:flutter/material.dart";
import "package:get/get.dart";

import "alarm_controller.dart";
import 'components/mobile_info_row.dart';

class AlarmPage extends GetView<AlarmController> {
  const AlarmPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OrientationBuilder(
        builder: (context, orientation) {
          double size = orientation == Orientation.portrait
              ? context.widthTransformer(reducedBy: 20)
              : context.heightTransformer(reducedBy: 40);
          return Obx(
            () => SingleChildScrollView(
              child: Column(
                children: [
                  SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20, bottom: 20),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          SizedBox(
                            width: size,
                            height: size,
                            child: CircularProgressIndicator(
                              value: controller
                                          .androidBatteryInfo.chargingStatus ==
                                      ChargingStatus.Charging
                                  ? null
                                  : (controller.androidBatteryInfo
                                              .batteryLevel ??
                                          0) /
                                      100,
                              semanticsLabel: "Circular progress indicator",
                              backgroundColor: Colors.grey,
                              strokeWidth: 20,
                              valueColor:
                                  (controller.androidBatteryInfo.batteryLevel ??
                                              0) <
                                          15
                                      ? const AlwaysStoppedAnimation<Color>(
                                          Colors.red)
                                      : const AlwaysStoppedAnimation<Color>(
                                          Colors.blue,
                                        ),
                            ),
                          ),
                          SizedBox(
                            width: size,
                            height: size,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "${controller.androidBatteryInfo.batteryLevel}%",
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 35,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                RotatedBox(
                                  quarterTurns: 3,
                                  child: Icon(
                                    controller.androidBatteryInfo
                                                .chargingStatus ==
                                            ChargingStatus.Charging
                                        ? Icons.battery_charging_full
                                        : Icons.battery_full,
                                    color: Colors.white,
                                    size: 70,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      MobileInfoRow(
                        text:
                            controller.androidBatteryInfo.health == "health_good"
                                ? "GOOD"
                                : "BAD",
                        icon: Icons.favorite,
                      ),
                      MobileInfoRow(
                        text: "${controller.estimatedTime}",
                        icon: Icons.schedule,
                      ),
                      MobileInfoRow(
                        text: "${controller.androidBatteryInfo.temperature}°C",
                        icon: Icons.device_thermostat,
                        iconColor:
                            (controller.androidBatteryInfo.temperature ?? 0) >
                                    35
                                ? Colors.red
                                : Colors.white,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

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
          return SingleChildScrollView(
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
                          child: const CircularProgressIndicator(
                            value: 100,
                            semanticsLabel: "Circular progress indicator",
                            backgroundColor: Colors.grey,
                            strokeWidth: 20,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.blue,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: size,
                          height: size,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text(
                                "100%",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 35,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 10),
                              RotatedBox(
                                quarterTurns: 3,
                                child: Icon(
                                  Icons.battery_full,
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
                  children: const [
                    MobileInfoRow(
                      text: "GOOD ",
                      icon: Icons.favorite,
                    ),
                    MobileInfoRow(
                      text: "12:00",
                      icon: Icons.schedule,
                    ),
                    MobileInfoRow(
                      text: "30°C",
                      icon: Icons.device_thermostat,
                      iconColor:Colors.white,
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

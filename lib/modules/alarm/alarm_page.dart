import "package:flutter/material.dart";
import "package:get/get.dart";

import "alarm_controller.dart";

class AlarmPage extends GetView<AlarmController> {
  const AlarmPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Alarm Page'),
      ),
      body: Container(),
    );
  }
}

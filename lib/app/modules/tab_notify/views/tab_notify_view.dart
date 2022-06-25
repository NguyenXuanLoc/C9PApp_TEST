import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/tab_notify_controller.dart';

class TabNotifyView extends GetView<TabNotifyController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TabNotifyView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'TabNotifyView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}

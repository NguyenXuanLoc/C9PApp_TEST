import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/tab_account_controller.dart';

class TabAccountView extends GetView<TabAccountController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TabAccountView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'TabAccountView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}

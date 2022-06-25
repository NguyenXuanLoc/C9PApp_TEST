import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/tab_promotion_controller.dart';

class TabPromotionView extends GetView<TabPromotionController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TabPromotionView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'TabPromotionView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}

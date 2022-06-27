import 'package:c9p/app/routes/app_pages.dart';
import 'package:c9p/app/utils/app_utils.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../../data/event_bus/load_weather_event.dart';

class HomeController extends GetxController {
  final pageController = PageController();
  bool isOpenOrder = false;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() async {
    try {
      isOpenOrder = Get.arguments;
      if (isOpenOrder) {
        await Get.toNamed(Routes.ORDER);
      }
    } catch (ex) {}
    super.onReady();
  }

  void jumToTap(int index) => pageController.jumpToPage(index);
}

import 'package:c9p/app/data/event_bus/jump_to_tab_event.dart';
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
    Utils.eventBus
        .on<JumpToTabEvent>()
        .listen((model) => jumToTap(model.index));
    super.onInit();
  }

  @override
  void onReady() async {
    try {
      isOpenOrder = Get.arguments;
      if (isOpenOrder) {
        await Get.toNamed(Routes.ORDER);
        Utils.fireEvent(LoadWeatherEvent());
      }
    } catch (ex) {}
    super.onReady();
  }

  void jumToTap(int index) => pageController.jumpToPage(index);
}

import 'package:c9p/app/routes/app_pages.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final pageController = PageController();
  bool isOpenOrder = false;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    try {
      isOpenOrder = Get.arguments;
      if (isOpenOrder) Get.toNamed(Routes.ORDER);
    } catch (ex) {}
    super.onReady();
  }

  void jumToTap(int index) => pageController.jumpToPage(index);
}

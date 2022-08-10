import 'dart:math';

import 'package:c9p/app/data/model/order_model.dart';
import 'package:c9p/app/routes/app_pages.dart';
import 'package:c9p/app/utils/app_utils.dart';
import 'package:c9p/app/utils/tag_utils.dart';
import 'package:get/get.dart';

class OrderSuccessController extends GetxController {
  String tag;
  OrderModel? model;
  OrderSuccessController(): tag = Random().nextInt(100).toString();
  @override
  void onInit() {
    model = Get.arguments;
    super.onInit();
  }
  Future<bool> onBackPress() async {
    Get.offAllNamed(Routes.HOME);
    return false;
  }

  @override
  void onClose() {
    TagUtils().tagsRiceOrderSuccess.removeAt(0);
    super.onInit();
  }

  void mainOnclick() => Get.offAllNamed(Routes.HOME);

  void myOrderOnclick() =>
      Get.toNamed(Routes.YOUR_ORDER, arguments: Get.arguments);
}

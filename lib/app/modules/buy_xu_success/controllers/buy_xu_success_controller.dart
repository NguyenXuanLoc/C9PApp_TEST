import 'package:c9p/app/modules/buy_combo_success/controllers/buy_combo_success_controller.dart';
import 'package:c9p/app/utils/app_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../data/model/payment_success_model.dart';
import '../../../routes/app_pages.dart';

class BuyXuSuccessController extends GetxController {
  String tag;

  BuyXuSuccessController() : tag = Utils.getRandomTag();
  PaymentSuccessModel model = Get.arguments[0];
  int totalXuRecived = Get.arguments[1];

  @override
  void onInit() {
    super.onInit();
  }

  Future<bool> interceptor(BuildContext context) async {
    Get.offAllNamed(Routes.HOME);
    return false;
  }

  void mainOnclick() => Get.offAllNamed(Routes.HOME);

  void yourXuOnclick() => Get.toNamed(Routes.YOUR_XU);
}

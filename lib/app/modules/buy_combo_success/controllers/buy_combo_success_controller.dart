import 'package:c9p/app/data/model/payment_info_model.dart';
import 'package:c9p/app/routes/app_pages.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../data/model/combo_best_seller_model.dart';
import '../../../data/model/payment_success_model.dart';

class BuyComboSuccessController extends GetxController {
  ComboSellingModel model = Get.arguments[0];
  String qty = Get.arguments[1];
  String receiver = Get.arguments[2];
  String phoneNumber = Get.arguments[3];
  PaymentSuccessModel paymentSuccessModel = Get.arguments[4];
  PaymentInfoModel paymentInfoModel = Get.arguments[5];
  final count = 0.obs;

  @override
  void onInit() {
    super.onInit();
  }

  Future<bool> interceptor(BuildContext context) async {
    Get.offAllNamed(Routes.HOME);
    return false;
  }

  void onClickMain() => Get.offAllNamed(Routes.HOME);

  void onClickMyCombo() => Get.toNamed(Routes.MY_COMBO);

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  void increment() => count.value++;
}

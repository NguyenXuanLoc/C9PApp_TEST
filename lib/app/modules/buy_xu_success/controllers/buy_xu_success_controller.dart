import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../data/model/payment_success_model.dart';
import '../../../routes/app_pages.dart';

class BuyXuSuccessController extends GetxController {
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

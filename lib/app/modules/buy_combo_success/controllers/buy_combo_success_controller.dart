import 'package:c9p/app/routes/app_pages.dart';
import 'package:get/get.dart';

import '../../../data/model/combo_best_seller_model.dart';

class BuyComboSuccessController extends GetxController {
  ComboSellingModel model = Get.arguments[0];
  String qty = Get.arguments[1];
  String receiver = Get.arguments[2];
  String phoneNumber = Get.arguments[3];

  final count = 0.obs;

  @override
  void onInit() {
    super.onInit();
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

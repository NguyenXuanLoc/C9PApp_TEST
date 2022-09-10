import 'package:get/get.dart';

import '../controllers/buy_combo_success_controller.dart';

class BuyComboSuccessBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BuyComboSuccessController>(
      () => BuyComboSuccessController(),
    );
  }
}

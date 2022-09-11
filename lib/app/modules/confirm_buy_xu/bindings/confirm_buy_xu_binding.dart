import 'package:get/get.dart';

import '../controllers/confirm_buy_xu_controller.dart';

class ConfirmBuyXuBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ConfirmBuyXuController>(
      () => ConfirmBuyXuController(),
    );
  }
}

import 'package:get/get.dart';

import '../controllers/buy_xu_success_controller.dart';

class BuyXuSuccessBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BuyXuSuccessController>(
      () => BuyXuSuccessController(),
    );
  }
}

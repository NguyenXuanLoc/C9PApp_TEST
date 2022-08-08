import 'package:get/get.dart';

import '../controllers/confirm_rice_order_controller.dart';

class ConfirmRiceOrderBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ConfirmRiceOrderController>(
      () => ConfirmRiceOrderController(),
    );
  }
}

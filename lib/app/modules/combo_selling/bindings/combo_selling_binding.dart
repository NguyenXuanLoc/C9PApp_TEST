import 'package:get/get.dart';

import '../controllers/combo_selling_controller.dart';

class ComboSellingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ComboSellingController>(
      () => ComboSellingController(),
    );
  }
}

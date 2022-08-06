import 'package:get/get.dart';

import '../controllers/by_combo_controller.dart';

class ByComboBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ByComboController>(
      () => ByComboController(),
    );
  }
}

import 'package:get/get.dart';

import '../controllers/my_combo_controller.dart';

class MyComboBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MyComboController>(
      () => MyComboController(),
    );
  }
}

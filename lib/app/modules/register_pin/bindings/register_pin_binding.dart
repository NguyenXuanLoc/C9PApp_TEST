import 'package:get/get.dart';

import '../controllers/register_pin_controller.dart';

class RegisterPinBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RegisterPinController>(
      () => RegisterPinController(),
    );
  }
}

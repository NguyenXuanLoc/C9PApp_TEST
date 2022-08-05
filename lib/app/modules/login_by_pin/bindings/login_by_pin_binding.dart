import 'package:get/get.dart';

import '../controllers/login_by_pin_controller.dart';

class LoginByPinBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginByPinController>(
      () => LoginByPinController(),
    );
  }
}

import 'package:get/get.dart';

import '../controllers/login_splash_controller.dart';

class LoginSplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginSplashController>(
      () => LoginSplashController(),
    );
  }
}

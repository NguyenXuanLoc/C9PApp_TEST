import 'dart:async';

import 'package:c9p/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:c9p/app/config/globals.dart' as globals;

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
  }

  void openHome() {
    Timer(
        const Duration(seconds: 1),
        () => globals.isLogin && !globals.isNeedUpdateProfile
            ? Get.offAllNamed(Routes.HOME)
            : (globals.isLogin && globals.isNeedUpdateProfile
                ? Get.offAllNamed(Routes.UPDATE_PROFILE)
                : Get.offAllNamed(Routes.LOGIN_SPLASH)));
  }
}

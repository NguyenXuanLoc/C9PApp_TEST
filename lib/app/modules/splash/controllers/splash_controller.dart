import 'dart:async';
import 'package:launch_review/launch_review.dart';

import 'package:c9p/app/config/globals.dart' as globals;
import 'package:c9p/app/routes/app_pages.dart';
import 'package:get/get.dart';

import '../../../components/app_check_version.dart';

class SplashController extends GetxController {
  final isForceUpdate = false.obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    openHome();
    super.onReady();
  }

  Future<bool> checkVersions() async {
    var result = await AppVersionChecker().checkUpdate();
    return result.canUpdate;
  }

  void openHome() async {
    isForceUpdate.value = await checkVersions();
    if (isForceUpdate.value) return;
    Timer(
        const Duration(seconds: 1),
        () => !globals.isLogin
            ? Get.offAllNamed(Routes.HOME, arguments: false)
            : (globals.isLogin && globals.isNeedUpdateProfile
                ? globals.isActive
                    ? Get.offAllNamed(Routes.HOME, arguments: false)
                    : Get.offAllNamed(Routes.UPDATE_PROFILE)
                : (globals.isMissPinCode
                    ? Get.offAllNamed(Routes.REGISTER_PIN,
                        arguments: globals.phoneNumber)
                    : Get.offAllNamed(Routes.HOME, arguments: false))));
  }
  void openStore()=> LaunchReview.launch(androidAppId: "com.app.com9phut",
      iOSAppId: "1631738263");
}

import 'package:get/get.dart';

import '../../../routes/app_pages.dart';

class LoginSplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
  }

  void openWebView(String title, String url) =>    Get.toNamed(Routes.WEBVIEW, arguments: [title, url]);

}

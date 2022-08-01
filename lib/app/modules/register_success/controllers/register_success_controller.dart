import 'package:get/get.dart';

import '../../../routes/app_pages.dart';

class RegisterSuccessController extends GetxController {
  void onClickContinues() async =>
      Get.offAllNamed(Routes.HOME, arguments: true);
}

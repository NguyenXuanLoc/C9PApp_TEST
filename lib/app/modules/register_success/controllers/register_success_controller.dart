import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../../../utils/storage_utils.dart';

class RegisterSuccessController extends GetxController {
  //TODO: Implement RegisterSuccessController

  final count = 0.obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  void onClickContinues() async => Get.offAllNamed(Routes.HOME,
      arguments: await StorageUtils.isFirstOrder());

  @override
  void onClose() {}

  void increment() => count.value++;
}

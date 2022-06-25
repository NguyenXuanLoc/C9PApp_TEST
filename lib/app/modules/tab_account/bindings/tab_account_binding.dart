import 'package:get/get.dart';

import '../controllers/tab_account_controller.dart';

class TabAccountBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TabAccountController>(
      () => TabAccountController(),
    );
  }
}

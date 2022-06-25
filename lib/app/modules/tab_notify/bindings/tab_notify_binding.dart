import 'package:get/get.dart';

import '../controllers/tab_notify_controller.dart';

class TabNotifyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TabNotifyController>(
      () => TabNotifyController(),
    );
  }
}

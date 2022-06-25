import 'package:get/get.dart';

import '../controllers/developing_controller.dart';

class DevelopingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DevelopingController>(
      () => DevelopingController(),
    );
  }
}

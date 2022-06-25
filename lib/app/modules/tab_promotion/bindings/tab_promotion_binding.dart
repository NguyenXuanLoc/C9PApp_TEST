import 'package:get/get.dart';

import '../controllers/tab_promotion_controller.dart';

class TabPromotionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TabPromotionController>(
      () => TabPromotionController(),
    );
  }
}

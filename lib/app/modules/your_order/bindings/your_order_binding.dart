import 'package:c9p/app/utils/tag_utils.dart';
import 'package:get/get.dart';

import '../controllers/your_order_controller.dart';

class YourOrderBinding extends Bindings {
  @override
  void dependencies() {
    var tag = YourOrderController().tag;
    TagUtils().tagsYourOrder.add(tag);
    Get.lazyPut<YourOrderController>(
      () => YourOrderController(),
      tag: tag
    );
  }
}

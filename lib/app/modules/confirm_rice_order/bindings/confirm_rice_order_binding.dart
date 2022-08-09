import 'package:c9p/app/utils/tag_utils.dart';
import 'package:get/get.dart';

import '../controllers/confirm_rice_order_controller.dart';

class ConfirmRiceOrderBinding extends Bindings {
  @override
  void dependencies() {
    var tag = ConfirmRiceOrderController().tag;
    TagUtils().tagsConfirmRiceOrder.add(tag);
    Get.lazyPut<ConfirmRiceOrderController>(() => ConfirmRiceOrderController(),
        tag: tag);
  }
}

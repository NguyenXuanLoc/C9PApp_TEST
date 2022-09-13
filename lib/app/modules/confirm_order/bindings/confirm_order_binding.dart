import 'package:c9p/app/utils/tag_utils.dart';
import 'package:get/get.dart';

import '../controllers/confirm_order_controller.dart';

class ConfirmOrderBinding extends Bindings {
  @override
  void dependencies() {
    var tag = ConfirmOrderController().tag;
    TagUtils().tagsConfirmBuyCombo.add(tag);
    Get.lazyPut<ConfirmOrderController>(() => ConfirmOrderController(),
        tag: tag);
  }
}

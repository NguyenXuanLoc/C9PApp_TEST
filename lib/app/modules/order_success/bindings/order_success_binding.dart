import 'package:c9p/app/utils/tag_utils.dart';
import 'package:get/get.dart';

import '../controllers/order_success_controller.dart';

class OrderSuccessBinding extends Bindings {
  @override
  void dependencies() {
    var tag = OrderSuccessController().tag;
    TagUtils().tagsRiceOrderSuccess.add(tag);
    Get.lazyPut<OrderSuccessController>(() => OrderSuccessController(),
        tag: tag);
  }
}

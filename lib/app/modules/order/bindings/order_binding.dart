import 'package:c9p/app/utils/app_utils.dart';
import 'package:c9p/app/utils/tag_utils.dart';
import 'package:get/get.dart';

import '../controllers/order_controller.dart';

class OrderBinding extends Bindings {
  @override
  void dependencies() {
    var tag = OrderController().tag;
    TagUtils().tagsCreateOrder.add(tag);
    Get.lazyPut<OrderController>(
      () => OrderController(),tag: tag
    );
  }
}

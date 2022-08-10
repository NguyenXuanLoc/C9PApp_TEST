import 'package:c9p/app/utils/tag_utils.dart';
import 'package:get/get.dart';

import '../controllers/detail_order_controller.dart';

class DetailOrderBinding extends Bindings {
  @override
  void dependencies() {
    var tag = DetailOrderController().tag;
    TagUtils().tagsDetailRiceOrder.add(tag);
    Get.lazyPut<DetailOrderController>(() => DetailOrderController(), tag: tag);
  }
}

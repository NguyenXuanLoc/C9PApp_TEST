import 'package:c9p/app/utils/tag_utils.dart';
import 'package:get/get.dart';

import '../controllers/product_detail_controller.dart';

class ProductDetailBinding extends Bindings {
  @override
  void dependencies() {
    var tag = ProductDetailController().tag;
    TagUtils().tagsProductDetail.add(tag);
    Get.lazyPut<ProductDetailController>(() => ProductDetailController(),
        tag: tag);
  }
}

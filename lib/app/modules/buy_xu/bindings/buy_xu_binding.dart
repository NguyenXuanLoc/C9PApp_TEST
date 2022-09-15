import 'package:get/get.dart';

import '../../../utils/tag_utils.dart';
import '../controllers/buy_xu_controller.dart';

class BuyXuBinding extends Bindings {
  @override
  void dependencies() {
    var tag = BuyXuController().tag;
    TagUtils().tagsBuyXu.add(tag);
    Get.lazyPut<BuyXuController>(() => BuyXuController(), tag: tag);
  }
}

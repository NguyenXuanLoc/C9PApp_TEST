import 'package:c9p/app/utils/tag_utils.dart';
import 'package:get/get.dart';

import '../controllers/buy_xu_success_controller.dart';

class BuyXuSuccessBinding extends Bindings {
  @override
  void dependencies() {
    var tag = BuyXuSuccessController().tag;
    TagUtils().tagsBuyXuSuccess.add(tag);
    Get.lazyPut<BuyXuSuccessController>(() => BuyXuSuccessController(),
        tag: tag);
  }
}

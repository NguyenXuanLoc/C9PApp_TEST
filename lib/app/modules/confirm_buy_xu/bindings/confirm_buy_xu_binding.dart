import 'package:c9p/app/utils/tag_utils.dart';
import 'package:get/get.dart';

import '../controllers/confirm_buy_xu_controller.dart';

class ConfirmBuyXuBinding extends Bindings {
  @override
  void dependencies() {
    var tag = ConfirmBuyXuController().tag;
    TagUtils().tagsConfirmBuyXu.add(tag);
    Get.lazyPut<ConfirmBuyXuController>(() => ConfirmBuyXuController(),
        tag: tag);
  }
}

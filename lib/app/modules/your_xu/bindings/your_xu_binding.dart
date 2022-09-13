import 'package:c9p/app/utils/tag_utils.dart';
import 'package:get/get.dart';

import '../controllers/your_xu_controller.dart';

class YourXuBinding extends Bindings {
  @override
  void dependencies() {
    var tag = YourXuController().tag;
    TagUtils().tagsYourXu.add(tag);
    Get.lazyPut<YourXuController>(() => YourXuController(), tag: tag);
  }
}

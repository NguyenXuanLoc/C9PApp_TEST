import 'package:c9p/app/routes/app_pages.dart';
import 'package:get/get.dart';

class DevelopingController extends GetxController {
  var isShowBack = Get.arguments ?? false;
  void reOrderOnclick() => Get.toNamed(Routes.ORDER);

  void mainOnclick() => Get.offAllNamed(Routes.HOME, arguments: false);
}

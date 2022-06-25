import 'package:c9p/app/routes/app_pages.dart';
import 'package:get/get.dart';

class OrderSuccessController extends GetxController {
  void mainOnclick() => Get.offAllNamed(Routes.HOME);

  void followOrderOnclick() => Get.toNamed(Routes.YOUR_ORDER);
}

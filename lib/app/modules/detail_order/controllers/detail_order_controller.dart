import 'package:c9p/app/routes/app_pages.dart';
import 'package:get/get.dart';

class DetailOrderController extends GetxController {
  //TODO: Implement DetailOrderController

  final count = 0.obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  void reOrderOnclick() => Get.toNamed(Routes.DEVELOPING);

  @override
  void onClose() {}

  void increment() => count.value++;
}

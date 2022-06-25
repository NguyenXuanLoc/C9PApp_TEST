import 'package:c9p/app/modules/home/controllers/home_controller.dart';
import 'package:c9p/app/modules/tab_account/controllers/tab_account_controller.dart';
import 'package:c9p/app/modules/tab_main/controllers/tab_main_controller.dart';
import 'package:c9p/app/modules/tab_notify/controllers/tab_notify_controller.dart';
import 'package:c9p/app/modules/tab_promotion/controllers/tab_promotion_controller.dart';
import 'package:get/get.dart';

class RootBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<TabMainController>(TabMainController());
    Get.put<TabPromotionController>(TabPromotionController());
    Get.put<TabNotifyController>(TabNotifyController());
    Get.put<TabAccountController>(TabAccountController());
    // Get.put<HomeController>(HomeController());
  }
}

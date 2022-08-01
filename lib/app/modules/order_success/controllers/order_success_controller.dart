import 'package:c9p/app/data/model/order_model.dart';
import 'package:c9p/app/routes/app_pages.dart';
import 'package:c9p/app/utils/log_utils.dart';
import 'package:get/get.dart';
import 'package:back_button_interceptor/back_button_interceptor.dart';

class OrderSuccessController extends GetxController {
  OrderModel? model;

  @override
  void onInit() {
    model = Get.arguments;
    super.onInit();
  }

  void init() {
    BackButtonInterceptor.add(myInterceptor);
  }

  @override
  void onClose() {
    super.onInit();
  }

  bool myInterceptor(bool stopDefaultButtonEvent, RouteInfo info) {
    Get.offAllNamed(Routes.HOME, arguments: false);
    BackButtonInterceptor.remove(myInterceptor);
    return true;
  }

  void mainOnclick() => Get.offAllNamed(Routes.HOME);

  void followOrderOnclick() =>
      Get.toNamed(Routes.DETAIL_ORDER, arguments: Get.arguments);
}

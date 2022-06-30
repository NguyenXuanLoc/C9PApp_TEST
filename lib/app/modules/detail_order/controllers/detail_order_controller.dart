import 'package:c9p/app/data/model/order_model.dart';
import 'package:c9p/app/routes/app_pages.dart';
import 'package:get/get.dart';

class DetailOrderController extends GetxController {
  var orderModer = OrderModel().obs;

  @override
  void onInit() {
    super.onInit();
  }

  void init() => orderModer.value = Get.arguments;

  @override
  void onReady() {
    super.onReady();
  }

  void reOrderOnclick() =>
      Get.toNamed(Routes.ORDER, arguments: orderModer.value);
}

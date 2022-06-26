import 'package:c9p/app/data/model/order_model.dart';
import 'package:c9p/app/routes/app_pages.dart';
import 'package:get/get.dart';

class DetailOrderController extends GetxController {
  var orderModer = OrderModel().obs;

  @override
  void onInit() {
    orderModer.value = Get.arguments;
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  void reOrderOnclick() => Get.toNamed(Routes.DEVELOPING);

}

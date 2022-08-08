import 'package:get/get.dart';

import '../../order/controllers/order_controller.dart';

class ConfirmRiceOrderController extends GetxController {
  RiceOrderParam model = Get.arguments;
  final isPaymentByCash = true.obs;

  void changeMethodPayment() => isPaymentByCash.value = !isPaymentByCash.value;

  @override
  void onReady() {
    super.onReady();
  }


}

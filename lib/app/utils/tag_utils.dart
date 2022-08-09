import 'package:c9p/app/modules/confirm_order/controllers/confirm_order_controller.dart';
import 'package:c9p/app/modules/confirm_rice_order/controllers/confirm_rice_order_controller.dart';
import 'package:c9p/app/modules/detail_order/controllers/detail_order_controller.dart';
import 'package:c9p/app/modules/order_success/controllers/order_success_controller.dart';
import 'package:get/get.dart';

class TagUtils {
  static final TagUtils _instance =  TagUtils._internal();
  factory TagUtils() =>_instance;
  TagUtils._internal();

  List<String> tagsRiceOrder = [];
  List<String> tagsConfirmRiceOrder = [];
  List<String> tagsRiceOrderSuccess = [];

  OrderSuccessController? findRiceOrderSuccessController() {
    OrderSuccessController? controller;
    for (var i = 0; i < tagsRiceOrderSuccess.length; i++) {
      try {
        controller = Get.find<OrderSuccessController>(tag: tagsRiceOrderSuccess[i]);
      } catch (e) {
        continue;
      }
    }
    return controller;
  }
  DetailOrderController? findDetailOrderController() {
    DetailOrderController? controller;
    for (var i = 0; i < tagsRiceOrder.length; i++) {
      try {
        controller = Get.find<DetailOrderController>(tag: tagsRiceOrder[i]);
      } catch (e) {
        continue;
      }
    }
    return controller;
  }
  ConfirmRiceOrderController? findConfirmRiceOrderController() {
    ConfirmRiceOrderController? controller;
    for (var i = 0; i < tagsConfirmRiceOrder.length; i++) {
      try {
        controller = Get.find<ConfirmRiceOrderController>(tag: tagsConfirmRiceOrder[i]);
      } catch (e) {
        continue;
      }
    }
    return controller;
  }
}

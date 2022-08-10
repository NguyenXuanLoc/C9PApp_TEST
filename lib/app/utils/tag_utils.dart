import 'package:c9p/app/modules/confirm_order/controllers/confirm_order_controller.dart';
import 'package:c9p/app/modules/confirm_rice_order/controllers/confirm_rice_order_controller.dart';
import 'package:c9p/app/modules/detail_order/controllers/detail_order_controller.dart';
import 'package:c9p/app/modules/order/controllers/order_controller.dart';
import 'package:c9p/app/modules/order_success/controllers/order_success_controller.dart';
import 'package:c9p/app/modules/your_order/controllers/your_order_controller.dart';
import 'package:get/get.dart';

class TagUtils {
  static final TagUtils _instance =  TagUtils._internal();
  factory TagUtils() =>_instance;
  TagUtils._internal();

  List<String> tagsDetailRiceOrder = [];
  List<String> tagsConfirmRiceOrder = [];
  List<String> tagsRiceOrderSuccess = [];
  List<String> tagsYourOrder = [];
  List<String> tagsCreateOrder = [];

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
  OrderController? findCreateOderController() {
    OrderController? controller;
    for (var i = 0; i < tagsCreateOrder.length; i++) {
      try {
        controller = Get.find<OrderController>(tag: tagsCreateOrder[i]);
      } catch (e) {
        continue;
      }
    }
    return controller;
  }
  YourOrderController? findYourOrderController() {
    YourOrderController? controller;
    for (var i = 0; i < tagsYourOrder.length; i++) {
      try {
        controller = Get.find<YourOrderController>(tag: tagsYourOrder[i]);
      } catch (e) {
        continue;
      }
    }
    return controller;
  }
  DetailOrderController? findDetailOrderController() {
    DetailOrderController? controller;
    for (var i = 0; i < tagsDetailRiceOrder.length; i++) {
      try {
        controller = Get.find<DetailOrderController>(tag: tagsDetailRiceOrder[i]);
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

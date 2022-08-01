import 'dart:async';

import 'package:c9p/app/config/globals.dart' as globals;
import 'package:c9p/app/data/model/order_model.dart';
import 'package:c9p/app/routes/app_pages.dart';
import 'package:c9p/app/utils/app_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../data/event_bus/refresh_order_detail_event.dart';

class DetailOrderController extends GetxController {
  var orderModer = OrderModel().obs;
  StreamSubscription<RefreshOrderDetailEvent>? _reloadStream;

  @override
  void onInit() {
    globals.isOrderDetail = true;
    refreshOrderListener();

    super.onInit();
  }

  @override
  void onClose() {
    globals.isOrderDetail = false;
    _reloadStream?.cancel();
    super.onClose();
  }

  void refreshOrderListener() {
    _reloadStream =
        Utils.eventBus.on<RefreshOrderDetailEvent>().listen((event) {
      if (orderModer.value.orderId.toString() == event.orderId) {
        getOrderById(event.orderId);
      }
    });
  }

  void getOrderById(String orderId) async {
    var orderResponse = await Utils.getOrderById(orderId);
    if (orderResponse != null) orderModer.value = orderResponse;
    update();
  }

  void init() => WidgetsBinding.instance
      .addPostFrameCallback((_) async => orderModer.value = Get.arguments);

  void reOrderOnclick() =>
      Get.toNamed(Routes.ORDER, arguments: orderModer.value);
}

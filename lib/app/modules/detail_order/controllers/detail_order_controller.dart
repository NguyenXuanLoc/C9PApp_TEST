import 'dart:async';
import 'dart:math';

import 'package:c9p/app/config/globals.dart' as globals;
import 'package:c9p/app/data/model/order_model.dart';
import 'package:c9p/app/routes/app_pages.dart';
import 'package:c9p/app/utils/app_utils.dart';
import 'package:c9p/app/utils/tag_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../data/event_bus/refresh_order_detail_event.dart';

class DetailOrderController extends GetxController {
  final String tag;
  var orderModer = OrderModel().obs;
  StreamSubscription<RefreshOrderDetailEvent>? _reloadStream;
  DetailOrderController() : tag = Random().nextInt(100).toString();

  @override
  void onInit() {
    orderModer.value = Get.arguments;
    globals.isOrderDetail = true;
    refreshOrderListener();
    super.onInit();
  }

  @override
  void onClose() {
    globals.isOrderDetail = false;
    TagUtils().tagsDetailRiceOrder.removeAt(0);
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

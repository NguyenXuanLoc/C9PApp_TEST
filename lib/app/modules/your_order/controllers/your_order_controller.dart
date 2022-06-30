import 'package:c9p/app/data/model/done_order_model.dart';
import 'package:c9p/app/data/model/order_model.dart';
import 'package:c9p/app/data/provider/user_provider.dart';
import 'package:c9p/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class YourOrderController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final userProvider = UserProvider();
  final isLoadingDoneOrder = true.obs;
  final isLoadingPendingOrder = true.obs;
  final lDoneOrder = List<OrderModel>.empty(growable: true).obs;
  var currentDoneOrderPage = 0;
  var doneOrderScrollController = ScrollController();
  var pendingOrderScrollController = ScrollController();

  final isReadEndDoneOrder = false.obs;
  final isReadEndPendingOrder = false.obs;
  final lPendingOrder = List<OrderModel>.empty(growable: true).obs;
  var currentPendingOrderPage = 0;
  var currentIndex = 0;
  late TabController tabController;

  @override
  void onInit() {
    initTab();
    getDoneOrder();
    getPendingOrder();
    pagingPendingOrder();
    pagingDoneOrder();
    super.onInit();
  }

  void initTab() {
    tabController = TabController(length: 2, vsync: this);
    tabController.addListener(() => currentIndex = tabController.index);
  }

  void setIndex(int index) => currentIndex = index;

  void pagingDoneOrder() {
    doneOrderScrollController.addListener(() {
      var maxScroll = doneOrderScrollController.position.maxScrollExtent;
      var currentScroll = doneOrderScrollController.position.pixels;
      if (maxScroll - currentScroll <= 200 &&
          lDoneOrder.isNotEmpty &&
          !isReadEndDoneOrder.value &&
          !isLoadingDoneOrder.value &&
          currentIndex == 1) {
        getDoneOrder(
            nextPage: '/?page=${currentDoneOrderPage + 1}', isPaging: true);
      }
    });
  }

  void getDoneOrder({String nextPage = '', bool isPaging = false}) async {
    isLoadingDoneOrder.value = true;
    var response = await userProvider.getDoneOrder(paging: nextPage);
    if (response.error == null && response.data != null) {
      var doneOrderModel = DoneOrderModel.fromJson(response.data['data']);
      currentDoneOrderPage = doneOrderModel.meta?.currentPage ?? 0;
      if (doneOrderModel.data == null || doneOrderModel.data!.isEmpty) {
        isReadEndDoneOrder.value = true;
      }
      if (!isPaging) {
        lDoneOrder.value = doneOrderModel.data ?? [];
      } else {
        lDoneOrder.addAll(doneOrderModel.data ?? []);
        update();
      }
    }
    isLoadingDoneOrder.value = false;
  }

  void getPendingOrder({String nextPage = '', bool isPaging = false}) async {
    isLoadingPendingOrder.value = true;
    var response = await userProvider.getPendingOrder(paging: nextPage);
    if (response.error == null && response.data != null) {
      var doneOrderModel = DoneOrderModel.fromJson(response.data['data']);
      currentPendingOrderPage = doneOrderModel.meta?.currentPage ?? 0;
      if (doneOrderModel.data == null || doneOrderModel.data!.isEmpty) {
        isReadEndPendingOrder.value = true;
      }
      if (isPaging) {
        lPendingOrder.addAll(doneOrderModel.data ?? []);
        update();
      } else {
        lPendingOrder.value = doneOrderModel.data ?? [];
      }
    }
    isLoadingPendingOrder.value = false;
  }

  void pagingPendingOrder() {
    pendingOrderScrollController.addListener(() {
      var maxScroll = pendingOrderScrollController.position.maxScrollExtent;
      var currentScroll = pendingOrderScrollController.position.pixels;
      if (maxScroll - currentScroll <= 200 &&
          lPendingOrder.isNotEmpty &&
          !isReadEndPendingOrder.value &&
          !isLoadingPendingOrder.value &&
          currentIndex == 0) {
        getPendingOrder(
            nextPage: '/?page=${currentPendingOrderPage + 1}', isPaging: true);
      }
    });
  }

  void refreshDoneOrder() {
    lDoneOrder.clear();
    isReadEndDoneOrder.value = false;
    getDoneOrder();
  }

  void refreshPendingOrder() {
    lPendingOrder.clear();
    isReadEndPendingOrder.value = false;
    getPendingOrder();
  }

  openReOrder(OrderModel model) =>
      Get.toNamed(Routes.ORDER, arguments: model);

  void openOrderDetail(OrderModel model) =>
      Get.toNamed(Routes.DETAIL_ORDER, arguments: model);
}

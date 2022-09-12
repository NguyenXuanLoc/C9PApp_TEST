import 'dart:async';

import 'package:c9p/app/data/model/done_order_model.dart';
import 'package:c9p/app/data/model/order_model.dart';
import 'package:c9p/app/data/model/xu_model.dart';
import 'package:c9p/app/data/provider/user_provider.dart';
import 'package:c9p/app/routes/app_pages.dart';
import 'package:c9p/app/utils/app_utils.dart';
import 'package:c9p/app/utils/log_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:c9p/app/config/globals.dart' as globals;
import '../../../data/event_bus/refresh_your_order_event.dart';
import '../../../utils/tag_utils.dart';

class YourXuController extends GetxController
    with GetSingleTickerProviderStateMixin {
  String tag;

  YourXuController() : tag = Utils.getRandomTag();
  final userProvider = UserProvider();
  final isLoadingDoneOrder = true.obs;
  final isLoadingPendingOrder = true.obs;
  final lDoneOrder = List<OrderModel>.empty(growable: true).obs;
  final xuModel = XuModel().obs;
  var currentDoneOrderPage = 0;
  var doneOrderScrollController = ScrollController();
  var pendingOrderScrollController = ScrollController();

  final isReadEndDoneOrder = false.obs;
  final isReadEndPendingOrder = false.obs;
  final lPendingOrder = List<OrderModel>.empty(growable: true).obs;
  var currentPendingOrderPage = 0;
  var currentIndex = 0;
  late TabController tabController;
  var isShowRefreshButton = false.obs;
  StreamSubscription<RefreshYourOrderEvent>? _showRefreshStream;

  @override
  void onInit() {
    initTab();
    getInfoWallet();
    getDoneOrder();
    getPendingOrder();
    pagingPendingOrder();
    pagingDoneOrder();
    globals.isOpenYourOrder = true;
    showRefreshButtonListener();
    super.onInit();
  }

  @override
  void onClose() {
    globals.isOpenYourOrder = false;
    TagUtils().tagsYourOrder.removeAt(0);
    _showRefreshStream?.cancel();
    super.onClose();
  }

  void showRefreshButtonListener() {
    _showRefreshStream = Utils.eventBus
        .on<RefreshYourOrderEvent>()
        .listen((event) => showRefreshButton(true));
  }

  void refreshAll() {
    refreshDoneOrder();
    refreshPendingOrder();
    getInfoWallet();
    showRefreshButton(false);
  }

  void showRefreshButton(bool isShow) {
    logE("TAG showRefreshButton: $isShow");
    isShowRefreshButton.value = isShow;
  }

  void initTab() {
    tabController = TabController(length: 3, vsync: this);
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

  openReOrder(OrderModel model) => Get.toNamed(Routes.ORDER, arguments: model);

  void openOrderDetail(OrderModel model) =>
      Get.toNamed(Routes.DETAIL_ORDER, arguments: model);

  void getInfoWallet() async {
    var response = await userProvider.getInfoWallet();
    if (response.error == null && response.data != null) {
      xuModel.value = XuModel.fromJson(response.data['data']);
    }
  }
  void buyXuOnclick(BuildContext context) => globals.isLogin
      ? Get.toNamed(Routes.BUY_XU)
      : Utils.requestLogin(context);
}

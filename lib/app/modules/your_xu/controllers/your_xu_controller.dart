import 'dart:async';

import 'package:c9p/app/config/constant.dart';
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
import '../../../data/model/history_xu_model.dart';
import '../../../utils/tag_utils.dart';

class YourXuController extends GetxController
    with GetSingleTickerProviderStateMixin {
  String tag;

  YourXuController() : tag = Utils.getRandomTag();
  final userProvider = UserProvider();
  final xuModel = XuModel().obs;

  final isLoadingHistory = true.obs;
  final lHistory = List<HistoryXuModel>.empty(growable: true).obs;
  final isReadEndHistory = false.obs;
  var currentHistory = 1;
  var historyScrollController = ScrollController();

  final isLoadingAddXu = true.obs;
  final lAddXu = List<HistoryXuModel>.empty(growable: true).obs;
  var addXuScrollController = ScrollController();
  final isReadEndAddXu = false.obs;
  var currentAddXu = 1;

  final isLoadingUseXu = true.obs;
  final lUseXu = List<HistoryXuModel>.empty(growable: true).obs;
  var useXuScrollController = ScrollController();
  final isReadEndUseXu = false.obs;
  var currentUseXu = 1;

  final currentIndex = 0.obs;

  late TabController tabController;
  var isShowRefreshButton = false.obs;
  StreamSubscription<RefreshYourOrderEvent>? _showRefreshStream;

  @override
  void onInit() {
    initTab();
    getInfoWallet();
    getHistory();
    getAddXu();
    getUseXu();
    pagingAddXu();
    pagingHistory();
    pagingUseXu();
    globals.isOpenYourOrder = true;
    showRefreshButtonListener();
    super.onInit();
  }

  @override
  void onClose() {
    globals.isOpenYourOrder = false;
    TagUtils().tagsYourXu.removeAt(0);
    _showRefreshStream?.cancel();
    super.onClose();
  }

  void showRefreshButtonListener() {
    _showRefreshStream = Utils.eventBus
        .on<RefreshYourOrderEvent>()
        .listen((event) => showRefreshButton(true));
  }

  void refreshAll() {
    refreshHistory();
    refreshAddXu();
    refreshUseXu();
    getInfoWallet();
    showRefreshButton(false);
  }

  void showRefreshButton(bool isShow) {
    isShowRefreshButton.value = isShow;
  }

  void initTab() {
    tabController = TabController(length: 3, vsync: this);
    tabController.addListener(() => currentIndex.value = tabController.index);
  }

  void setIndex(int index) => currentIndex.value = index;

  void getHistory({String nextPage = '1', bool isPaging = false}) async {
    isLoadingHistory.value = true;
    var response = await userProvider.getHistoryBuyXu(nextPage: nextPage);
    if (response.error == null && response.data != null) {
      var lResponse = historyXuModelFromJson(response.data['data']['data']);
      currentHistory = response.data['data']['meta']['current_page'] ?? 1;
      if (lResponse.isEmpty) {
        isReadEndHistory.value = true;
      }
      if (!isPaging) {
        lHistory.value = lResponse;
      } else {
        lHistory.addAll(lResponse);
        update();
      }
    }
    isLoadingHistory.value = false;
  }

  void getAddXu({String nextPage = '1', bool isPaging = false}) async {
    isLoadingAddXu.value = true;
    var response = await userProvider.getHistoryBuyXu(nextPage: nextPage,varied: ApiKey.plus);
    if (response.error == null && response.data != null) {
      var lResponse = historyXuModelFromJson(response.data['data']['data']);
      currentAddXu = response.data['data']['meta']['current_page'] ?? 1;
      if (lResponse.isEmpty) {
        isReadEndAddXu.value = true;
      }
      if (isPaging) {
        lAddXu.addAll(lResponse);
        update();
      } else {
        lAddXu.value = lResponse;
      }
    }
    isLoadingAddXu.value = false;
  }
  void getUseXu({String nextPage = '1', bool isPaging = false}) async {
    isLoadingUseXu.value = true;
    var response = await userProvider.getHistoryBuyXu(nextPage: nextPage,varied: ApiKey.minus);
    if (response.error == null && response.data != null) {
      var lResponse = historyXuModelFromJson(response.data['data']['data']);
      currentUseXu = response.data['data']['meta']['current_page'] ?? 1;
      if (lResponse.isEmpty) {
        isReadEndUseXu.value = true;
      }
      if (isPaging) {
        lUseXu.addAll(lResponse);
        update();
      } else {
        lUseXu.value = lResponse;
      }
    }
    isLoadingUseXu.value = false;
  }

  void pagingAddXu() {
    addXuScrollController.addListener(() {
      var maxScroll = addXuScrollController.position.maxScrollExtent;
      var currentScroll = addXuScrollController.position.pixels;
      if (maxScroll - currentScroll <= 200 &&
          lAddXu.isNotEmpty &&
          !isReadEndAddXu.value &&
          !isLoadingAddXu.value &&
          currentIndex == 1) {
        getAddXu(
            nextPage: '${currentAddXu + 1}', isPaging: true);
      }
    });
  }
  void pagingUseXu() {
    useXuScrollController.addListener(() {
      var maxScroll = useXuScrollController.position.maxScrollExtent;
      var currentScroll = useXuScrollController.position.pixels;
      if (maxScroll - currentScroll <= 200 &&
          lUseXu.isNotEmpty &&
          !isReadEndUseXu.value &&
          !isLoadingUseXu.value &&
          currentIndex == 2) {
        getUseXu(
            nextPage: '${currentUseXu + 1}', isPaging: true);
      }
    });
  }
  void pagingHistory() {
    historyScrollController.addListener(() {
      var maxScroll = historyScrollController.position.maxScrollExtent;
      var currentScroll = historyScrollController.position.pixels;
      if (maxScroll - currentScroll <= 200 &&
          lHistory.isNotEmpty &&
          !isReadEndHistory.value &&
          !isLoadingHistory.value &&
          currentIndex == 0) {
        getHistory(nextPage: '${currentHistory + 1}', isPaging: true);
      }
    });
  }
  void refreshHistory() {
    lHistory.clear();
    isReadEndHistory.value = false;
    getHistory();
    getInfoWallet();
  }
  void refreshUseXu() {
    lUseXu.clear();
    isReadEndUseXu.value = false;
    getUseXu();
    getInfoWallet();
  }
  void refreshAddXu() {
    lAddXu.clear();
    isReadEndAddXu.value = false;
    getAddXu();
    getInfoWallet();
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

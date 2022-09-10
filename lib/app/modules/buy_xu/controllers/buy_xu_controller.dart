import 'dart:math';

import 'package:c9p/app/components/dialogs.dart';
import 'package:c9p/app/data/model/active_xu_model.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../../data/model/xu_model.dart';
import '../../../data/provider/user_provider.dart';

class BuyXuController extends GetxController {
  final String tag;

  BuyXuController() : tag = Random().nextInt(100).toString();
  final xuModel = XuModel().obs;
  final scrollController = ScrollController();
  final isLoading = true.obs;
  final isReadEnd = false.obs;
  final selectModel = ActiveXuModel().obs;
  final lPackageXu = List<ActiveXuModel>.empty(growable: true).obs;
  var userProvider = UserProvider();
  var currentPage = 1;

  @override
  void onInit() {
    getInfoWallet();
    paging();
    super.onInit();
  }

  void onRefresh() {
    currentPage = 1;
    selectModel.value = ActiveXuModel();
    lPackageXu.value = [];
    getInfoWallet();
    getActiveCoinPack();
  }

  void selectPackageXu(ActiveXuModel model) => selectModel.value = model;

  void paging() {
    scrollController.addListener(() {
      var maxScroll = scrollController.position.maxScrollExtent;
      var currentScroll = scrollController.position.pixels;
      if (maxScroll - currentScroll <= 200 &&
          !isLoading.value &&
          !isReadEnd.value) {
        currentPage++;
        getActiveCoinPack(isPaging: true, nextPage: currentPage);
      }
    });
  }

  void getInfoWallet() async {
    var response = await userProvider.getInfoWallet();
    if (response.error == null && response.data != null) {
      xuModel.value = XuModel.fromJson(response.data['data']);
    }
  }

  void getActiveCoinPack({bool isPaging = false, int nextPage = 1}) async {
    if (!isPaging) Dialogs.showLoadingDialog(Get.context);
    isLoading.value = true;
    var response = await userProvider.getActiveCoinPack(nextPage: nextPage);
    if (!isPaging) await Dialogs.hideLoadingDialog();
    try {
      if (response.error == null && response.data != null) {
        currentPage = response.data['data']['meta']['current_page'];
        var lResponse = activeXuModelFromJson(response.data['data']['data']);
        if (lResponse.isEmpty) isReadEnd.value = true;
        if (isPaging) {
          lPackageXu.addAll(lResponse);
          update();
        } else {
          selectModel.value = lResponse.first;
          lPackageXu.value = lResponse;
        }
      }
    } catch (ex) {
      isReadEnd.value = true;
      update();
    }
    isLoading.value = false;
  }

  @override
  void onReady() {
    getActiveCoinPack();
    super.onReady();
  }

  @override
  void onClose() {}
}

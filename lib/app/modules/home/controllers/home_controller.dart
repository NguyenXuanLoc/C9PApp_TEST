import 'dart:async';

import 'package:c9p/app/components/dialogs.dart';
import 'package:c9p/app/config/app_translation.dart';
import 'package:c9p/app/config/globals.dart' as globals;
import 'package:c9p/app/data/event_bus/jump_to_tab_event.dart';
import 'package:c9p/app/data/event_bus/new_notify_event.dart';
import 'package:c9p/app/routes/app_pages.dart';
import 'package:c9p/app/utils/app_utils.dart';
import 'package:c9p/app/utils/log_utils.dart';
import 'package:c9p/app/utils/toast_utils.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../../data/provider/user_provider.dart';
import '../../../utils/storage_utils.dart';

class HomeController extends GetxController {
  final pageController = PageController();
  final userProvider = UserProvider();
  final currentIndex = 0.obs;
  BuildContext? context;
  var isShowCloseDialog = false;

  @override
  void onInit() {
    listenerNotify();
    super.onInit();
  }

  void showLoading(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback(
        (_) => Dialogs.showPopupPromotion(context, loginCallBack: () {}));
  }

  Future<bool> onBackPress() async {
    var isClose = false;
    if (currentIndex != 0) {
      jumToTap(0, isBackPress: true);
      return false;
    } else {
      if (!isShowCloseDialog) {
        isShowCloseDialog = true;
        await Dialogs.showCloseAppDialog(context!, closeCallBack: () {
          isClose = true;
          isShowCloseDialog = false;
        }, cancelCallBack: () {
          isShowCloseDialog = false;
          isClose = false;
        }, popCallBack: () {
          isShowCloseDialog = false;
          isClose = false;
        });
      }
    }
    return isClose;

    // CommonUtils.showToast(context, "Back presses");
  }

  void setContext(BuildContext context) {
    this.context = context;
    showLoading(context);
  }

  void openOrder(BuildContext context) async {
    if (!globals.isLogin) {
      Utils.requestLogin(context);
    } else {
      Get.toNamed(Routes.ORDER);
    }
  }

  @override
  void onReady() async {
    if (Get.arguments != null && Get.arguments) {
      Get.toNamed(Routes.ORDER);
    }
    checkOrderIdFromCache();
    checkRegisterDevice();
    super.onReady();
  }

  void listenerNotify() {
    Utils.eventBus
        .on<NewNotifyEvent>()
        .listen((event) async => openOrderNotify(event.orderId));
  }

  void checkOrderIdFromCache() async {
    if (globals.isLogin) {
      var orderId = await StorageUtils.getOrderId();
      if (orderId.isNotEmpty) openOrderNotify(orderId);
    }
    StorageUtils.saveOrderId('');
  }

  void openOrderNotify(String orderId) async {
    var orderModel = await Utils.getOrderById(orderId);
    if (orderModel == null) {
      toast(LocaleKeys.network_error.tr);
    } else {
      Get.toNamed(Routes.DETAIL_ORDER, arguments: orderModel);
    }
  }

  void checkRegisterDevice() async {
    var isRegister = await StorageUtils.isRegisterDevice();
    if (!isRegister && globals.isLogin) {
      var deviceToken = await Utils.getFirebaseToken();
      var registerDeviceResponse =
          await userProvider.registerDevice(deviceToken ?? '');
      if (registerDeviceResponse.error == null) {
        StorageUtils.setRegisterDevice(true);
      }
    }
  }

  void jumToTap(int index,
      {BuildContext? context, bool isBackPress = false}) async {
    if (index == 0 || isBackPress) {
      currentIndex.value = index;
      pageController.jumpToPage(index);
    } else {
      if (globals.isLogin) {
        currentIndex.value = index;
        pageController.jumpToPage(index);
      } else {
        Utils.requestLogin(context!);
      }
    }
  }
}

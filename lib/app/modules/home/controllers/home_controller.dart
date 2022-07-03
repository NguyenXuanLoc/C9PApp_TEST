import 'package:c9p/app/config/app_translation.dart';
import 'package:c9p/app/data/event_bus/jump_to_tab_event.dart';
import 'package:c9p/app/data/event_bus/new_notify_event.dart';
import 'package:c9p/app/routes/app_pages.dart';
import 'package:c9p/app/utils/app_utils.dart';
import 'package:c9p/app/utils/toast_utils.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../../data/event_bus/load_weather_event.dart';
import '../../../data/provider/user_provider.dart';
import '../../../utils/storage_utils.dart';

class HomeController extends GetxController {
  final pageController = PageController();
  bool isOpenOrder = false;
  final userProvider = UserProvider();
  final currentIndex = 0.obs;

  @override
  void onInit() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Utils.eventBus
          .on<JumpToTabEvent>()
          .listen((model) => jumToTap(model.index));
    });
    listenerNotify();
    super.onInit();
  }

  @override
  void onReady() async {
    try {
      isOpenOrder = Get.arguments;
      if (isOpenOrder) {
        await Get.toNamed(Routes.ORDER);
        Utils.fireEvent(LoadWeatherEvent());
      }
    } catch (ex) {}
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
    var orderId = await StorageUtils.getOrderId();
    if (orderId.isNotEmpty) openOrderNotify(orderId);
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
    if (!isRegister) {
      var deviceToken = await Utils.getFirebaseToken();
      var registerDeviceResponse =
          await userProvider.registerDevice(deviceToken ?? '');
      if (registerDeviceResponse.error == null) {
        StorageUtils.setRegisterDevice(true);
      }
    }
  }

  void jumToTap(int index) {
    currentIndex.value = index;
    pageController.jumpToPage(index);
  }
}

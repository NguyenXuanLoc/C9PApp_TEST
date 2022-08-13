import 'dart:async';

import 'package:c9p/app/config/app_translation.dart';
import 'package:c9p/app/data/event_bus/jump_to_tab_event.dart';
import 'package:c9p/app/data/event_bus/load_weather_event.dart';
import 'package:c9p/app/data/event_bus/reload_user_event.dart';
import 'package:c9p/app/data/event_bus/show_badge_event.dart';
import 'package:c9p/app/data/model/order_model.dart';
import 'package:c9p/app/data/model/promotion_model.dart';
import 'package:c9p/app/data/model/weather_model.dart';
import 'package:c9p/app/data/provider/user_provider.dart';
import 'package:c9p/app/modules/home/controllers/home_controller.dart';
import 'package:c9p/app/routes/app_pages.dart';
import 'package:c9p/app/utils/app_utils.dart';
import 'package:c9p/app/utils/log_utils.dart';
import 'package:c9p/app/utils/storage_utils.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:location/location.dart';
import 'package:c9p/app/config/globals.dart' as globals;
import 'package:url_launcher/url_launcher.dart';
import '../../../config/constant.dart';
import '../../../data/model/combo_best_seller_model.dart';
import '../../../data/model/my_combo_model.dart';

enum TabMainAction { MENU, ORDER, PROMOTION, MORE }

class TabMainController extends GetxController {
  final userProvider = UserProvider();
  final weatherModel = WeatherModel().obs;
  final weatherDetail = Weather().obs;
  final weatherDescription = ''.obs;
  final lNearOrder = List<OrderModel>.empty(growable: true).obs;
  final isLoadNearOrder = true.obs;
  final isLoadPromotion = true.obs;
  var lPromotion = List<ComboSellingModel>.empty(growable: true).obs;
  var isFirstOpen = true;
  final fullName = ''.obs;
  final avatarUrl = ''.obs;
  var countLoadWeather = 1;
  var isBadge = false.obs;

  void onRefresh() {
    getNearOrder();
    getPromotion();
  }

  @override
  onInit() {
    init();
    super.onInit();
  }
  @override
  onClose() {
    super.onClose();
  }
  void init() {
    checkWeather();
    getNearOrder();
    getPromotion();
    getUserInfo();
    showBadgeListener();
  }

  void showBadgeListener() {
    Utils.eventBus.on<ShowBadgeEvent>().listen((event) => setBadge(true));
  }

  void setBadge(bool isShow) => isBadge.value = isShow;

  void getUserInfo() async {
    var userModel = await StorageUtils.getUser();
    if (userModel != null) {
      fullName.value = userModel.data?.userData?.name ?? '';
      avatarUrl.value = userModel.data?.userData?.image ?? '';
      refresh();
    }
  }

  void checkWeather() async {
    await Utils.requestPermissionLocation();
    var isRequestWeather = await StorageUtils.isRequestWeather();
    var weatherCache = await StorageUtils.getWeather();
    if (isRequestWeather || weatherCache == null) {
      getWeatherOnline();
    } else {
      weatherModel.value = weatherCache;
      weatherDetail.value = weatherModel.value.weather?[0] ?? Weather();
      weatherDetail.value.icon =
          "${AppConstant.URL_WEATHER_ICON}${weatherDetail.value.icon!}@2x.png";
      weatherDescription.value =
          weatherDetail.value.description!.substring(0, 1).toUpperCase() +
              weatherDetail.value.description!.substring(1);
    }
  }

  void getWeatherOnline() async {
    var locationData = await getLocation();
    if (locationData != null) {
      var weatherResponse = await userProvider.getWeather(
          locationData.latitude!, locationData.longitude!);
      if (weatherResponse.error == null && weatherResponse.data != null) {
        weatherModel.value = weatherModelFromJson(weatherResponse.data);
        StorageUtils.saveWeather(weatherModel.value);
        weatherDetail.value = weatherModel.value.weather?[0] ?? Weather();
        weatherDetail.value.icon =
            "${AppConstant.URL_WEATHER_ICON}${weatherDetail.value.icon!}@2x.png";
        weatherDescription.value =
            weatherDetail.value.description!.substring(0, 1).toUpperCase() +
                weatherDetail.value.description!.substring(1);
      } else {
        if (countLoadWeather > 3) return;
        Timer(const Duration(minutes: 1), () => getWeatherOnline());
        countLoadWeather++;
      }
    }
  }

  void getPromotion() async {
    isLoadPromotion.value = true;
    var response = await userProvider.getComboSelling();
    if (response.error == null && response.data != null) {
      lPromotion.value = comboSellingModelFromJson(response.data['data']['data']);
      update();
    }
    isLoadPromotion.value = false;
  }

  void openReOrder(OrderModel model, index){
    for(int i =0;i<lNearOrder.length;i++) {
      lNearOrder[i].isSelect = false;
    }
    lNearOrder[index].isSelect = true;
    lNearOrder.refresh();
    Get.toNamed(Routes.ORDER, arguments: model);
  }
  void getNearOrder() async {
    isLoadNearOrder.value = true;
    if (globals.isLogin) {
      var response = await userProvider.nearOrder();
      if (response.error == null && response.data != null) {
        lNearOrder.value = orderModelFromJson(response.data['data']);
      }
    }
    isLoadNearOrder.value = false;
  }

  Future<LocationData?> getLocation() async {
    Location location = Location();
    await Utils.requestPermissionLocation();
    if (!await location.serviceEnabled() ||
        await location.hasPermission() == PermissionStatus.denied) {
      await location.requestPermission();
    }
    return await location.getLocation();
  }

  void openOrderDetail(OrderModel model, int index){
    for(int i =0;i<lNearOrder.length;i++) {
      lNearOrder[i].isSelect = false;
    }
    lNearOrder[index].isSelect = true;
    lNearOrder.refresh();
    Get.toNamed(Routes.DETAIL_ORDER, arguments: model);
  }

  void onClickAction(TabMainAction action, BuildContext context) {
    if (action == TabMainAction.MENU) {
      Get.toNamed(Routes.WEBVIEW, arguments: [LocaleKeys.menu.tr, AppConstant.URL_MENU]);
      return;
    }
    if (!globals.isLogin) {
      Utils.requestLogin(context);
      return;
    }
    switch (action) {
      case TabMainAction.PROMOTION:
        Get.find<HomeController>().jumToTap(1);
        break;
      case TabMainAction.MORE:
        Get.toNamed(Routes.DEVELOPING,arguments: true);
        break;
      case TabMainAction.ORDER:
        {
          setBadge(false);
          Get.toNamed(Routes.YOUR_ORDER);
          break;
        }
    }
  }

  void onClickProfile(BuildContext context) => globals.isLogin
      ? Get.find<HomeController>().jumToTap(3)
      : Utils.requestLogin(context);


  void openSaleCombo(ComboSellingModel model) =>
      Get.toNamed(Routes.BY_COMBO, arguments: model);

  void openDialThePhone() => launchUrl(Uri(
        scheme: 'tel',
        path: '0332005445',
      ));
}

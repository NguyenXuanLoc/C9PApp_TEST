import 'dart:async';

import 'package:c9p/app/data/event_bus/load_weather_event.dart';
import 'package:c9p/app/data/model/order_model.dart';
import 'package:c9p/app/data/model/promotion_model.dart';
import 'package:c9p/app/data/model/weather_model.dart';
import 'package:c9p/app/data/provider/user_provider.dart';
import 'package:c9p/app/routes/app_pages.dart';
import 'package:c9p/app/utils/app_utils.dart';
import 'package:c9p/app/utils/storage_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';

import '../../../config/constant.dart';

enum TabMainAction { MENU, ORDER, DISCTRICT, MORE }

class TabMainController extends GetxController {
  final userProvider = UserProvider();
  final weatherModel = WeatherModel().obs;
  final weatherDetail = Weather().obs;
  final weatherDescription = ''.obs;
  final lNearOrder = List<OrderModel>.empty(growable: true).obs;
  final isLoadNearOrder = true.obs;
  final isLoadPromotion = true.obs;
  var lPromotion = List<PromotionModel>.empty(growable: true).obs;
  var isFirstOpen = true;
  final fullName = ''.obs;
  var countLoadWeather = 1;
  StreamSubscription<LoadWeatherEvent>? _weatherStream;

  void onRefresh() {
    getNearOrder();
    getPromotion();
  }

  void init() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      if (isFirstOpen) {
        checkWeather();
        getNearOrder();
        getPromotion();
        getUserInfo();
        isFirstOpen = false;
      }
    });
    _weatherStream = Utils.eventBus.on<LoadWeatherEvent>().listen((event) {
      checkWeather();
      _weatherStream?.cancel();
    });
  }

  void getUserInfo() async {
    var userModel = await StorageUtils.getUser();
    if (userModel != null) {
      fullName.value = userModel.data?.userData?.name ?? '';
    }
  }

  void checkWeather() async {
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
    var response = await userProvider.gePromotion();
    if (response.error == null && response.data != null) {
      lPromotion.value = promotionModelFromJson(response.data['data']);
    }
    isLoadPromotion.value = false;
  }

  void openReOrder(OrderModel model) =>
      Get.toNamed(Routes.ORDER, arguments: model);

  void getNearOrder() async {
    isLoadNearOrder.value = true;
    var response = await userProvider.nearOrder();
    if (response.error == null && response.data != null) {
      lNearOrder.value = orderModelFromJson(response.data['data']);
    }
    isLoadNearOrder.value = false;
  }

  Future<LocationData?> getLocation() async {
    Location location = Location();
    if (await StorageUtils.isFirstOrder()) return null;
    await Utils.requestPermissionLocation();
    if (!await location.serviceEnabled() ||
        await location.hasPermission() == PermissionStatus.denied) {
      return null;
    }
    return await location.getLocation();
  }

  void openOrderDetail(OrderModel model) =>
      Get.toNamed(Routes.DETAIL_ORDER, arguments: model);

  void onClickAction(TabMainAction action) {
    switch (action) {
      case TabMainAction.MORE:
      case TabMainAction.MENU:
      case TabMainAction.DISCTRICT:
        {
          break;
        }
      case TabMainAction.ORDER:
        {
          Get.toNamed(Routes.YOUR_ORDER);
          break;
        }
    }
  }

  void onClickProfile() => Get.toNamed(Routes.UPDATE_PROFILE);
}

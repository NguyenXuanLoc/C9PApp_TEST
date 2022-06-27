import 'dart:async';

import 'package:c9p/app/data/event_bus/load_weather_event.dart';
import 'package:c9p/app/data/model/order_model.dart';
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
  var lPromotion = List<String>.empty(growable: true).obs;
  var isFirstOpen = true;

  void onRefresh() {
    getNearOrder();
    getPromotion();
  }

  void init() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      if (isFirstOpen) {
        getWeather();
        getNearOrder();
        getPromotion();
        isFirstOpen = false;
      }
    });
  }

  void getWeather() async {
    var locationData = await getLocation();
    if (locationData != null) {
      var weatherResponse = await userProvider.getWeather(
          locationData.latitude!, locationData.longitude!);
      if (weatherResponse.error == null && weatherResponse.data != null) {
        weatherModel.value = weatherModelFromJson(weatherResponse.data);
        weatherDetail.value = weatherModel.value.weather?[0] ?? Weather();
        weatherDetail.value.icon =
            "${AppConstant.URL_WEATHER_ICON}${weatherDetail.value.icon!}@2x.png";
        weatherDescription.value =
            weatherDetail.value.description!.substring(0, 1).toUpperCase() +
                weatherDetail.value.description!.substring(1);
      }
    }
  }

  void getPromotion() {
    isLoadPromotion.value = true;
    lPromotion.value = [
      'https://megatop.vn/wp-content/uploads/2019/12/ma-khuyen-mai-grabfood-6.jpg',
      'https://dinkynguyentrai.com.vn/wp-content/uploads/2020/07/104590520_3181198648585847_4711719218630492232_o.jpg',
      'https://megatop.vn/wp-content/uploads/2019/12/ma-khuyen-mai-grabfood-6.jpg'
    ];
/*    Timer(const Duration(seconds: 1), () {
      lPromotion.value = [
        'https://megatop.vn/wp-content/uploads/2019/12/ma-khuyen-mai-grabfood-6.jpg',
        'https://dinkynguyentrai.com.vn/wp-content/uploads/2020/07/104590520_3181198648585847_4711719218630492232_o.jpg',
        'https://megatop.vn/wp-content/uploads/2019/12/ma-khuyen-mai-grabfood-6.jpg'
      ];
    });*/
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
    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;
    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return null;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return null;
      }
    }
    locationData = await location.getLocation();
    return locationData;
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

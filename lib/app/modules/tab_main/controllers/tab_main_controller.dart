import 'dart:async';

import 'package:c9p/app/data/model/weather_model.dart';
import 'package:c9p/app/data/provider/user_provider.dart';
import 'package:c9p/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';


enum TabMainAction { MENU, ORDER, DISCTRICT, MORE }

class TabMainController extends GetxController {
  final userProvider = UserProvider();
  final weatherModel = WeatherModel().obs;
  final weatherDetail = Weather().obs;
  final weatherDescription = ''.obs;


  void getWeather() async {
    var locationData = await getLocation();
    if (locationData != null) {
      var weatherResponse = await userProvider.getWeather(
          locationData.latitude!, locationData.longitude!);
      if (weatherResponse.error == null && weatherResponse.data != null) {
        weatherModel.value = weatherModelFromJson(weatherResponse.data);
        weatherDetail.value = weatherModel.value.weather?[0] ?? Weather();
        weatherDescription.value =
            weatherDetail.value.description!.substring(0, 1).toUpperCase() +
                weatherDetail.value.description!.substring(1);
      }
    }
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

  void openOrderDetail() => Get.toNamed(Routes.DETAIL_ORDER);

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

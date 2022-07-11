import 'dart:async';

import 'package:c9p/app/components/dialogs.dart';
import 'package:c9p/app/config/globals.dart' as globals;
import 'package:c9p/app/data/model/order_model.dart';
import 'package:c9p/app/data/provider/user_provider.dart';
import 'package:c9p/app/utils/storage_utils.dart';
import 'package:event_bus/event_bus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';

import '../components/date_picker.dart';
import '../config/app_translation.dart';
import '../routes/app_pages.dart';
import '../theme/colors.dart';

class Utils {
  static var eventBus = EventBus();

  static fireEvent(dynamic model) => eventBus.fire(model);

  static void hideKeyboard(BuildContext? context) {
    if (context != null) FocusScope.of(context).requestFocus(FocusNode());
  }

  static String formatPhone(String value) =>
      value.startsWith('0') ? value : '0$value';

  static String standardizePhoneNumber(String value) {
    if (value.isEmpty || value.length < 9) return '';
    if (value.length == 9 && !value.startsWith('0')) {
      return '+84$value';
    }
    if (value.startsWith('0') && value.length == 10) {
      return '+84${value.substring(1)}';
    }
    if (value.startsWith('84') && value.length == 11) {
      return '+$value';
    }
    if (value.startsWith('+84') && value.length == 12) {
      return value;
    }
    return '';
  }

  static bool validateMobile(String value) {
    String pattern = r'(^(?:[+0]9)?[0-9]{9,12}$)';
    RegExp regExp = RegExp(pattern);
    if (value.isEmpty) {
      return false;
    } else if (!regExp.hasMatch(value)) {
      return false;
    }
    return true;
  }

/*

  static void snackBarMessage(String message,
      {Color? backgroundColor, SnackPosition? position, Color? colorText}) {
    Get.snackbar(LocaleKeys.notify.tr, message,
        snackStyle: SnackStyle.FLOATING,
        backgroundColor: backgroundColor ?? colorBackgroundWhite,
        colorText: colorText ?? colorText100,
        animationDuration: const Duration(seconds: 1),
        duration: const Duration(seconds: 2),
        snackPosition: position ?? SnackPosition.BOTTOM);
  }
*/

  static bool validatePassword(String value) {
    String pattern = r'^(?=.*?[a-z])(?=.*?[0-9]).{8,}$';
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(value);
  }

  static void pickDate(BuildContext context, Function(DateTime) callback) {
    var time = DateTime.now();
    DatePicker.showDatePicker(context,
        showTitleActions: true,
        minTime: DateTime(time.year, time.month, time.day),
        maxTime: DateTime(time.year + 10, time.month, time.day),
        onChanged: (date) {}, onConfirm: (date) {
      var result =
          "${date.day.toString().length == 1 ? '0' + date.day.toString() : date.day}-${date.month.toString().length == 1 ? '0' + date.month.toString() : date.month}-${date.year}";
      callback(date);
    }, currentTime: DateTime.now(), locale: LocaleType.vi);
  }

  static void showTimePickers(
      BuildContext context, Function(DateTime) callback) {
    DatePicker.showTimePicker(context,
        showTitleActions: true, onChanged: (date) {}, onConfirm: (date) {
      callback(date);
    }, currentTime: DateTime.now(), locale: LocaleType.vi);
  }

  static String convertTimeToMMMYYDD(DateTime time) =>
      DateFormat('MMMM-yyyy-dd').format(time).toString().split(' ')[0];

  static String convertTimeToYYMMDD(DateTime time) =>
      DateFormat('yyyy-M-dd').format(time.toLocal()).toString().split(' ')[0];

  static String convertTimeToDDMMYY(DateTime time) =>
      DateFormat('dd-MM-yyyy').format(time.toLocal()).toString().split(' ')[0];

  static String convertTimeToHHMM(DateTime time) =>
      DateFormat.Hm().format(time.toLocal());

  static String formatMoney(int money) =>
      NumberFormat('#,###,###,#,###,###,###', 'vi').format(money);

  static String convertTimeToDDMMYYHHMMSS(DateTime time) {
    var result = DateFormat('dd/MM/yyy HH:mm:ss').format(time.toLocal());
    return result;
  }

  static Future<TimeOfDay?> pickTime(BuildContext context) async =>
      await showTimePicker(
        context: context,
        useRootNavigator: false,
        cancelText: LocaleKeys.cancel.tr,
        confirmText: LocaleKeys.yes.tr,
        helpText: '',
        minuteLabelText: LocaleKeys.minutes.tr,
        hourLabelText: LocaleKeys.hours.tr,
        initialTime:
            TimeOfDay(hour: DateTime.now().hour, minute: DateTime.now().minute),
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData.light().copyWith(
              colorScheme: const ColorScheme.light(
                // change the border color
                primary: colorGreen60,
                // change the text color
                onSurface: colorText60,
              ),
              // button colors
              buttonTheme: const ButtonThemeData(
                colorScheme: ColorScheme.light(
                  primary: Colors.green,
                ),
              ),
            ),
            child: child!,
          );
        },
      );

  bool isLogin() => globals.isLogin;

  static Future<void> requestPermissionLocation() async {
    Location location = Location();
    bool serviceEnabled;
    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
    }
    var permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
    }
    await location.hasPermission();
  }

  static String convertTimeToHHMMA(DateTime time) =>
      DateFormat.Hm().format(time.toLocal());

  static Future<String?> getFirebaseToken() async =>
      await FirebaseMessaging.instance.getToken();

  static String time24to12Format(DateTime dateTime) {
    var time = DateFormat.Hm().format(dateTime.toLocal());
    int h = int.parse(time.split(":").first);
    int m = int.parse(time.split(":").last.split(" ").first);
    String send = "";
    if (h > 12) {
      var temp = h - 12;
      send = "$temp:${m.toString().length == 1 ? "0$m" : m.toString()} " "PM";
    } else {
      send = "$h:${m.toString().length == 1 ? "0$m" : m.toString()}  " "AM";
    }
    return send;
  }

  static Future<OrderModel?> getOrderById(String orderId) async {
    var response = await UserProvider().getOrderById(orderId);
    if (response.error == null && response.data != null) {
      return OrderModel.fromJson(response.data['data']);
    }
    return null;
  }

  static Future<void> autoLogout() async {
    StorageUtils.clearUser();
    StorageUtils.setRegisterDevice(false);
    Timer(
        const Duration(seconds: 1), () => Get.offAllNamed(Routes.LOGIN_SPLASH));
  }

  static Future<void> requestLogin(BuildContext context) async {
    await Dialogs.showLoginDialog(context,
        loginCallBack: () => Get.toNamed(Routes.LOGIN_SPLASH));
  }
}

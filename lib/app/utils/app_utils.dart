import 'package:c9p/app/utils/log_utils.dart';
import 'package:event_bus/event_bus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:c9p/app/config/globals.dart' as globals;
import 'package:location/location.dart';
import '../components/date_picker.dart';
import '../config/app_translation.dart';
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
      DateFormat('yyyy-M-dd').format(time).toString().split(' ')[0];

  static String convertTimeToDDMMYY(DateTime time) =>
      DateFormat('dd-MM-yyyy').format(time).toString().split(' ')[0];

  static String convertTimeToHHMMSS(DateTime time) =>
      DateFormat('hh:mm:ss').format(time);

  static String formatMoney(int money) =>
      NumberFormat('#,###,###,#,###,###,###', 'vi').format(money);

  static String convertTimeToDDMMYYHHMMSS(DateTime time) =>
      DateFormat('dd/MM/yyy hh:mm:ss').format(time);

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
}

import 'package:c9p/app/utils/log_utils.dart';
import 'package:event_bus/event_bus.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:c9p/app/config/globals.dart' as globals;
import '../components/date_picker.dart';

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

  static void pickDate(BuildContext context, Function(String) callback) {
    var time = DateTime.now();
    DatePicker.showDatePicker(context,
        showTitleActions: true,
        minTime: DateTime(time.year, time.month, time.day),
        maxTime: DateTime(time.year + 10, time.month, time.day),
        onChanged: (date) {}, onConfirm: (date) {
      var result =
          "${date.day.toString().length == 1 ? '0' + date.day.toString() : date.day}-${date.month.toString().length == 1 ? '0' + date.month.toString() : date.month}-${date.year}";
      callback(result);
    }, currentTime: DateTime.now(), locale: LocaleType.vi);
  }

  static void showTimePicker(BuildContext context, Function(String) callback) {
    DatePicker.showTime12hPicker(context,
        showTitleActions: true, onChanged: (date) {}, onConfirm: (date) {
      callback(DateFormat("h:mma").format(date));
    }, currentTime: DateTime.now(), locale: LocaleType.vi);
  }

  static String convertTimeToMMMYYDD(DateTime time) =>
      DateFormat('MMMM-yyyy-dd').format(time).toString().split(' ')[0];

  bool isLogin() => globals.isLogin;
}

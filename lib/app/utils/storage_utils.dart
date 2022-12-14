import 'package:c9p/app/config/constant.dart';
import 'package:c9p/app/config/globals.dart';
import 'package:c9p/app/config/globals.dart' as globals;
import 'package:c9p/app/data/model/user_model.dart';
import 'package:c9p/app/data/model/weather_model.dart';
import 'package:c9p/app/utils/log_utils.dart';
import 'package:get_storage/get_storage.dart';

class StorageUtils {
  static Future<void> saveUser(UserModel userModel) async {
    globals.isLogin = true;
    globals.accessToken = userModel.data?.token?.token ?? '';
    globals.avatarUrl = userModel.data?.userData?.image ?? '';
    globals.userName = userModel.data?.userData?.name ?? '';
    await GetStorage().write(StorageKey.AccountInfo, userModel.toJson());
  }

  static Future<UserModel?> getUser() async {
    var userString = await GetStorage().read(StorageKey.AccountInfo);
    try {
      if (userString != null) {
        var userModel = UserModel.fromJson(userString);
        globals.isLogin = true;
        globals.accessToken = userModel.data?.token?.token ?? '';
        // globals.accessToken = "NjM2.fkfMwEt4IJG0VNPV-510MleIjwjFRXrSuTYw-MKqiJSPkBCKBD-fiGJEbFCn";
        globals.isNeedUpdateProfile = userModel.needUpdate ?? true;
        globals.userName = userModel.data?.userData?.name ?? '';
        globals.phoneNumber = userModel.data?.userData?.phone ?? '';
        globals.avatarUrl = userModel.data?.userData?.image ?? '';
        globals.isMissPinCode = userModel.missingPinCode?? false;
        globals.isActive =
            ((userModel.data?.userData?.status ?? '') == 'active')
                ? true
                : false;
        return userModel;
      } else {
        globals.isActive = false;
        globals.isMissPinCode = false;
        globals.accessToken = '';
        globals.userName = '';
        globals.phoneNumber = '';
        globals.avatarUrl = '';
        globals.isNeedUpdateProfile = false;
        globals.isLogin = false;
      }
    } catch (ex) {
      globals.isActive = false;
      globals.isMissPinCode = false;
      globals.accessToken = '';
      globals.userName = '';
      globals.avatarUrl = '';
      globals.phoneNumber = '';
      globals.isNeedUpdateProfile = false;
      globals.isLogin = false;
    }
    return null;
  }

  static Future<void> clearUser() async {
    globals.accessToken = '';
    globals.userName = '';
    globals.phoneNumber = '';
    globals.avatarUrl = '';
    globals.isNeedUpdateProfile = false;
    globals.isLogin = false;
    await setIsFirstOrder(true);
    await GetStorage().remove(StorageKey.AccountInfo);
  }

  static Future<void> setIsFirstOrder(bool value) async =>
      GetStorage().write(StorageKey.firstOpenOrder, value);

  static Future<bool> isFirstOrder() async =>
      await GetStorage().read(StorageKey.firstOpenOrder) ?? true;

  static Future<void> saveWeather(WeatherModel model) async {
    await GetStorage().write(StorageKey.weather, model.toJson());
  }

  static Future<WeatherModel?> getWeather() async {
    var str = GetStorage().read(StorageKey.weather);
    if (str != null) {
      return WeatherModel.fromJson(str);
    }
    return null;
  }

  static Future<bool> isRequestWeather() async {
    var currentTime = DateTime.now().millisecondsSinceEpoch;
    var scheduleTime =
        GetStorage().read(StorageKey.scheduleWeather) ?? currentTime;
    if (currentTime >= scheduleTime) {
      GetStorage()
          .write(StorageKey.scheduleWeather, currentTime + AppConstant.ONE_DAY);
      return true;
    }
    return false;
  }

  static Future<void> setRegisterDevice(bool isRegister) async =>
      await GetStorage().write(AppConstant.REGISTER_DEVICE, isRegister);

  static Future<bool> isRegisterDevice() async =>
      await GetStorage().read(AppConstant.REGISTER_DEVICE) ?? false;

  static Future<String> getOrderId() async =>
      await GetStorage().read(StorageKey.orderId) ?? '';

  static Future<void> saveOrderId(String orderId) async =>
      await GetStorage().write(StorageKey.orderId, orderId);
}

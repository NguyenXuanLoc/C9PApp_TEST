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
    await GetStorage().write(StorageKey.AccountInfo, userModel.toJson());
  }

  static Future<UserModel?> getUser() async {
    var userString = await GetStorage().read(StorageKey.AccountInfo);
    logE("TAG userString: ${userString}");
    try {
      if (userString != null) {
        var userModel = UserModel.fromJson(userString);
        globals.isLogin = true;
        globals.accessToken = userModel.data?.token?.token ?? '';
        globals.isNeedUpdateProfile = userModel.needUpdate ?? true;
        globals.userName = userModel.data?.userData?.name ?? '';
        globals.phoneNumber = userModel.data?.userData?.phone ?? '';
        return userModel;
      } else {
        globals.isNeedUpdateProfile = true;
        globals.isLogin = false;
      }
    } catch (ex) {
      globals.isNeedUpdateProfile = true;
      globals.isLogin = false;
    }
    return null;
  }

  static Future<void> clearUser() async {
    isLogin = false;
    globals.accessToken = '';
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

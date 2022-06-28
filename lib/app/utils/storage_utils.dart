import 'package:c9p/app/config/constant.dart';
import 'package:c9p/app/config/globals.dart';
import 'package:c9p/app/data/model/user_model.dart';
import 'package:get_storage/get_storage.dart';
import 'package:c9p/app/config/globals.dart' as globals;

class StorageUtils {
  static Future<void> saveUser(UserModel userModel) async {
    globals.isLogin = true;
    globals.accessToken = userModel.data?.token?.token ?? '';
    await GetStorage().write(StorageKey.AccountInfo, userModel.toJson());
  }

  static Future<UserModel?> getUser() async {
    var userString = await GetStorage().read(StorageKey.AccountInfo);
    try {
      if (userString != null) {
        var userModel = UserModel.fromJson(userString);
        globals.isLogin = true;
        globals.accessToken = userModel.data?.token?.token ?? '';
        globals.isNeedUpdateProfile = userModel.needUpdate ?? true;
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
    await GetStorage().remove(StorageKey.AccountInfo);
  }

  static Future<void> setIsFirstOrder(bool value) async =>
      GetStorage().write(StorageKey.firstOpenOrder, value);

  static Future<bool> isFirstOrder() async =>
      await GetStorage().read(StorageKey.firstOpenOrder) ?? true;
}

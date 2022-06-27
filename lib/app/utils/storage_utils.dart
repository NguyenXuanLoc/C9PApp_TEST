import 'package:c9p/app/config/constant.dart';
import 'package:c9p/app/config/globals.dart';
import 'package:c9p/app/data/model/user_model.dart';
import 'package:get_storage/get_storage.dart';
import 'package:c9p/app/config/globals.dart' as globals;

class StorageUtils {
  static void saveUser(UserModel userModel) async {
    globals.isLogin = true;
    globals.accessToken = userModel.data?.bearerToken?.token ?? '';
    await GetStorage().write(StorageKey.AccountInfo, userModel.toJson());
  }

  static Future<void> getUser() async {
    var userString = await GetStorage().read(StorageKey.AccountInfo);
    try {
      if (userString != null) {
        var userModel = UserModel.fromJson(userString);
        globals.isLogin = true;
        globals.accessToken = userModel.data?.bearerToken?.token ?? '';
      } else {
        globals.isLogin = false;
      }
    } catch (ex) {
      globals.isLogin = false;
    }
  }

  static void clearUser() {
    isLogin = false;
    GetStorage().remove(StorageKey.AccountInfo);
  }
}

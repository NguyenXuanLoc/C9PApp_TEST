import 'package:c9p/app/config/constant.dart';
import 'package:c9p/app/config/globals.dart';
import 'package:c9p/app/data/model/user_model.dart';
import 'package:get_storage/get_storage.dart';

class StorageUtils {
  static void saveUser(UserModel userModel) async {
    isLogin = true;
    await GetStorage().write(StorageKey.AccountInfo, userModel.toJson());
  }

  static Future<void> getUser() async {
    var userString = await GetStorage().read(StorageKey.AccountInfo);
    // var result = UserModelFromJson(str).fromJson(userString);
    if (userString != null) {
      isLogin = true;
    } else {
      isLogin = false;
    }
  }

  static void clearUser() {
    isLogin = false;
    GetStorage().remove(StorageKey.AccountInfo);
  }
}

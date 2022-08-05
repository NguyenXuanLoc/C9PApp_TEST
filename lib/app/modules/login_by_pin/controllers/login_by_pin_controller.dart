import 'package:c9p/app/components/dialogs.dart';
import 'package:c9p/app/data/provider/user_provider.dart';
import 'package:c9p/app/routes/app_pages.dart';
import 'package:c9p/app/utils/log_utils.dart';
import 'package:c9p/app/utils/toast_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../config/app_translation.dart';
import '../../../data/model/user_model.dart';
import '../../../utils/storage_utils.dart';

class LoginByPinController extends GetxController {
  final count = 0.obs;
  final pin = ''.obs;
  final errorPin = ''.obs;
  final userProvider = UserProvider();
  var phone = '';

  @override
  void onInit() {
    phone = Get.arguments;
    super.onInit();
  }

  @override
  void onClose() {}

  void increment() => count.value++;

  void onClickLogin(BuildContext context) {
    if (isValid()) {
      loginByAccount(context);
    }
  }

  bool isValid() {
    if (pin.value.length != 4) {
      toast(LocaleKeys.pin_invalid.tr);
      return false;
    }
    errorPin.value = '';
    return true;
  }

  void loginByAccount(BuildContext context) async {
    Dialogs.showLoadingDialog(context);
    var response = await userProvider.loginByAccount(
        phone: phone.replaceAll('+84', '0'), pass: pin.value);
    Dialogs.hideLoadingDialog();
    if (response.error == null && response.data != null) {
      try {
        var model = UserModel.fromJson(response.data);
        await StorageUtils.saveUser(model);
        await StorageUtils.getUser();
        Get.offAllNamed(Routes.HOME, arguments: false);
      } catch (ex) {
        toast(response.data['data']['responseText']);
      }
    } else {
      toast(response.error.toString());
    }
  }

  void setPin(String pin) {
    this.pin.value = pin;
  }
}


import 'package:c9p/app/components/dialogs.dart';
import 'package:c9p/app/data/provider/user_provider.dart';
import 'package:c9p/app/routes/app_pages.dart';
import 'package:c9p/app/utils/toast_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../config/app_translation.dart';
import '../../../data/model/user_model.dart';
import '../../../utils/app_utils.dart';
import '../../../utils/storage_utils.dart';

class LoginByPinController extends GetxController {
  final pin = ''.obs;
  final errorPin = ''.obs;
  final userProvider = UserProvider();
  var phone = '';
  var otpController = TextEditingController();
  var focusNode = FocusNode();
  @override
  void onInit() {
    phone = Get.arguments;
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}


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
    Utils.hideKeyboard(context);
    var response = await userProvider.loginByAccount(
        phone: phone.replaceAll('+84', '0'), pass: pin.value);
   await Dialogs.hideLoadingDialog();
    if (response.error == null && response.data != null) {
      try {
        var model = UserModel.fromJson(response.data);
        await StorageUtils.saveUser(model);
        await StorageUtils.getUser();
        Get.offAllNamed(Routes.HOME, arguments: false);
      } catch (ex) {
        toast(response.data['data']['message']??response.data['data']['responseText']);
      }
    } else {
      otpController.text = '';
      pin.value='';
      toast(response.error.toString());
      focusNode.requestFocus();
    }
  }

  void setPin(String pin,BuildContext context) {
    this.pin.value = pin;
    if(this.pin.value.length ==4){
      loginByAccount(context);
    }
  }
}

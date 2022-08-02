import 'package:c9p/app/data/provider/user_provider.dart';
import 'package:c9p/app/routes/app_pages.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../config/app_translation.dart';
import '../../../utils/app_utils.dart';
import '../../../utils/toast_utils.dart';

class LoginController extends GetxController {
  var userProvider = UserProvider();
  final phoneController = TextEditingController();
  final errorPhone = ''.obs;
  final isValid = false.obs;
  final isPhoneChange = false.obs;

  void openOtp() {
    if (isValid.value) {
      Get.toNamed(Routes.OTP,
          arguments: Utils.formatPhone(phoneController.text));
    }
  }

  void onClickContinue() async {
    if (isValid.value) {
      var isPassExist = await checkPasswordExist();
      if (isPassExist == null) return;
      if (isPassExist)
        toast("Login  == PIN");
      else {
        Get.toNamed(Routes.OTP,
            arguments: Utils.formatPhone(phoneController.text));
      }
    }
  }

  void checkValid() {
    if (!isPhoneChange.value) isPhoneChange.value = true;
    var phone = phoneController.text;
    if (phone.isEmpty) {
      setIsValid(false);
      errorPhone.value = LocaleKeys.please_input_phone_number.tr;
    } else if (!Utils.validateMobile(phone)) {
      setIsValid(false);
      errorPhone.value = LocaleKeys.phone_number_khong_hop_le.tr;
    } else {
      errorPhone.value = LocaleKeys.phone_number_hop_le.tr;
      setIsValid(true);
    }
  }

  Future<bool?> checkPasswordExist() async {
    var response = await userProvider.checkPasswordExits();
    if (response.error == null && response.data != null) {
      var isExist = response.data['data']['exist'] ?? false;
      return isExist;
    } else {
      toast(response.error.toString());
      return null;
    }
  }

  void setIsValid(bool isValid) => this.isValid.value = isValid;
}

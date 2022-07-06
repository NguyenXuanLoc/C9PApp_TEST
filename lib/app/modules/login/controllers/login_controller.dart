import 'package:c9p/app/routes/app_pages.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../config/app_translation.dart';
import '../../../utils/app_utils.dart';

class LoginController extends GetxController {
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

  void setIsValid(bool isValid) => this.isValid.value = isValid;
}

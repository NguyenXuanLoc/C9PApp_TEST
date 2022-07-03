import 'package:c9p/app/routes/app_pages.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../utils/app_utils.dart';

class LoginController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final phoneController = TextEditingController();
  final isValid = false.obs;

  void openOtp() {
    if (formKey.currentState!.validate()) {
      Get.toNamed(Routes.OTP,
          arguments: Utils.formatPhone(phoneController.text));
    }
  }

  void setIsValid(bool isValid) => this.isValid.value = isValid;
}

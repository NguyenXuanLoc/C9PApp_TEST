import 'package:c9p/app/components/otp_widget.dart';
import 'package:c9p/app/routes/app_pages.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../config/app_translation.dart';
import '../../../data/provider/user_provider.dart';
import '../../../utils/toast_utils.dart';

class RegisterPinController extends GetxController {
  var userProvider = UserProvider();
  var pin=''.obs;
  var otpController = OtpFieldController();

  @override
  void onReady() {
    WidgetsBinding.instance
        .addPostFrameCallback((timeStamp) => otpController.setFocus(0));
    super.onReady();
  }

  bool isValid() {
    if (pin.value.length != 4) {
      toast(LocaleKeys.pin_invalid.tr);
      return false;
    }
    return true;
  }

  void setPin(String text) => pin.value = text;

  void onClickContinue() async{
    if(isValid()){
      var response = await userProvider.createNewPass(pass: pin.value);
      if(response.error ==null) Get.offAllNamed(Routes.REGISTER_SUCCESS);
    }
  }
}

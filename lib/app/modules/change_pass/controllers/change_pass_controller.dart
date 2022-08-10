import 'package:c9p/app/data/provider/user_provider.dart';
import 'package:c9p/app/utils/log_utils.dart';
import 'package:c9p/app/utils/toast_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../components/dialogs.dart';
import '../../../config/app_translation.dart';

class ChangePassController extends GetxController {
  var oldPassController = TextEditingController();
  var newPassController = TextEditingController();
  var confirmPassController = TextEditingController();
  var errorOldPass = ''.obs;
  var errorNewPass = ''.obs;
  var errorConfirmPass = ''.obs;
var userProvider = UserProvider();
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  void saveOnclick(BuildContext context) async{
    if (isValid()) {
      var oldPass = oldPassController.text;
      var newPass = newPassController.text;
      var confirmPass = confirmPassController.text;
      Dialogs.showLoadingDialog(context);
    var response =await  userProvider.changePass(oldPass, newPass, confirmPass);
    Dialogs.hideLoadingDialog();
    if(response.error !=null) toast(response.error.toString());
    else{
      toast(response.data['message']);
      Get.back();
    }
    }
  }

  bool isValid() {
    var oldPass = oldPassController.text;
    var newPass = newPassController.text;
    var confirmPass = confirmPassController.text;
    if (oldPass.length != 4 || newPass.length != 4 || confirmPass.length != 4) {
      toast(LocaleKeys.please_input_pass.tr);
      return false;
    } else if (newPass != confirmPass) {
      toast(LocaleKeys.pass_not_match.tr);
      return false;
    }
    return true;
  }
}

import 'dart:async';

import 'package:c9p/app/data/event_bus/jump_to_tab_event.dart';
import 'package:c9p/app/data/event_bus/reload_user_event.dart';
import 'package:c9p/app/utils/app_utils.dart';
import 'package:c9p/app/utils/log_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../components/dialogs.dart';
import '../../../config/app_translation.dart';
import '../../../data/model/user_model.dart';
import '../../../data/provider/user_provider.dart';
import '../../../routes/app_pages.dart';
import '../../../utils/storage_utils.dart';
import '../../../utils/toast_utils.dart';
import '../views/tab_account_view.dart';
import 'package:c9p/app/config/globals.dart'as globals;
class TabAccountController extends GetxController {
  final userProvider = UserProvider();
  final fullNameController = TextEditingController();
  final phoneController = TextEditingController();
  final errorFullName = ''.obs;
  var isFirstOpen = true;
  var isSave = false.obs;
  final currentName = ''.obs;

  @override
  void onInit() {
    getUserInfo();
    super.onInit();
  }

  void getUserInfo() async {
    var userModel = await StorageUtils.getUser();
    if (userModel != null) {
      fullNameController.text = userModel.data?.userData?.name ?? '';
      phoneController.text =
          userModel.data?.userData?.phone?.replaceAll('+84', '0') ?? '';
      currentName.value = fullNameController.text;
    }
  }

  bool isValid() {
    if (fullNameController.text.isEmpty) {
      errorFullName.value = LocaleKeys.please_input_full_name.tr;
      return false;
    }
    errorFullName.value = '';
    return true;
  }

  void updateProfile(BuildContext context) async {
    if (isValid()) {
      Utils.hideKeyboard(context);
      Dialogs.showLoadingDialog(context);
      var response = await userProvider.updateProfile(fullNameController.text);
      await Dialogs.hideLoadingDialog();
      if (response.error == null && response.data != null) {
        var userData = await getProfile();
        var userCache = await StorageUtils.getUser();
        if (userCache != null && userData != null) {
          var userModel = userCache.copyOf(
              data: userCache.data!.copyOf(userData: userData),
              needUpdate: false);
          currentName.value = userModel.data?.userData?.name ?? '';
          isSave.value = false;
          await StorageUtils.saveUser(userModel);
          Utils.fireEvent(ReloadUserEvent());
          getUserInfo();
        } else {
          toast(LocaleKeys.network_error.tr);
        }
      }
    }
  }

  void logout(BuildContext context) async {
    bool isLogout = false;
    await Dialogs.showLogoutDialog(context,
        deleteCallBack: () => isLogout = true);
    if (isLogout) {
      Timer(Duration(milliseconds: 300), () async {
        Dialogs.showLoadingDialog(context);
        var deviceToken = await Utils.getFirebaseToken();
        await userProvider.unregisterDevice(deviceToken ?? '');
        await userProvider.logout(deviceToken ?? '');
        StorageUtils.clearUser();
        StorageUtils.setRegisterDevice(false);
        await Dialogs.hideLoadingDialog();
        Get.offAllNamed(Routes.HOME);
      });
    }
  }

  Future<UserData?> getProfile() async {
    var response = await userProvider.getProfile();
    if (response.error == null && response.data != null) {
      return UserData.fromJson(response.data['data']);
    }
    return null;
  }

  void onFullNameChange(String text) =>
      isSave.value = (text == currentName) ? false : true;

  void handleAction(AccountAction action,BuildContext context) {
    switch (action) {
      case AccountAction.PROFILE:
        Get.toNamed(Routes.PROFILE);
        break;
      case AccountAction.MY_COMBO:
        Get.toNamed(Routes.MY_COMBO);
        break;
      case AccountAction.MY_LOCATION:
        // Get.toNamed(Routes.YOUR_ORDER);
        break;
      case AccountAction.METHOD_PAYMENT:
        break;
      case AccountAction.MY_ORDER:
        Get.toNamed(Routes.YOUR_ORDER);
        break;
      case AccountAction.REGULATION:
        Get.toNamed(Routes.WEBVIEW,
            arguments: [LocaleKeys.regulation.tr, globals.tempOfUseUrl]);
        break;
      case AccountAction.LOGOUT:
        logout(context);
        break;
    }
  }
}

import 'package:c9p/app/data/event_bus/reload_user_event.dart';
import 'package:c9p/app/utils/app_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../components/dialogs.dart';
import '../../../config/app_translation.dart';
import '../../../data/model/user_model.dart';
import '../../../data/provider/user_provider.dart';
import '../../../routes/app_pages.dart';
import '../../../utils/storage_utils.dart';
import '../../../utils/toast_utils.dart';

class TabAccountController extends GetxController {
  final userProvider = UserProvider();
  final fullNameController = TextEditingController();
  final phoneController = TextEditingController();
  final errorFullName = ''.obs;
  var isFirstOpen = true;
  var isSave = false.obs;
  var currentName = '';

  void init() async {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      if (isFirstOpen) {
        getUserInfo();
        isFirstOpen = false;
      }
    });
  }

  void getUserInfo() async {
    var userModel = await StorageUtils.getUser();
    if (userModel != null) {
      fullNameController.text = userModel.data?.userData?.name ?? '';
      phoneController.text =
          userModel.data?.userData?.phone?.replaceAll('+84', '0') ?? '';
      currentName = fullNameController.text;
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
          currentName = userModel.data?.userData?.name ?? '';
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

  void logout(BuildContext context) {}

  Future<UserData?> getProfile() async {
    var response = await userProvider.getProfile();
    if (response.error == null && response.data != null) {
      return UserData.fromJson(response.data['data']);
    }
    return null;
  }

  void onFullNameChange(String text) =>
      isSave.value = (text == currentName) ? false : true;
}

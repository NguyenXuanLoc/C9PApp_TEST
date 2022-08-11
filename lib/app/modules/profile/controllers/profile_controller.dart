import 'package:c9p/app/data/model/user_model.dart';
import 'package:c9p/app/utils/log_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../components/dialogs.dart';
import '../../../config/app_translation.dart';
import '../../../data/event_bus/reload_user_event.dart';
import '../../../data/provider/user_provider.dart';
import '../../../utils/app_utils.dart';
import '../../../utils/storage_utils.dart';
import '../../../utils/toast_utils.dart';

class ProfileController extends GetxController {
  final userProvider = UserProvider();
  final fullNameController = TextEditingController();
  final phoneController = TextEditingController();
  UserModel? userModel;
  final isMale = true.obs;
  final count = 0.obs;
  final errorFullName = ''.obs;
  final currentName = ''.obs;
  final urlImage = ''.obs;
  final filePath = ''.obs;

  @override
  void onInit() async {
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
      urlImage.value = userModel.data?.userData?.image??'';
      update();
    }
  }

  @override
  void onReady() {
    super.onReady();
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
      if(filePath.value.isNotEmpty) userProvider.uploadAvatar(filePath.value);
      await Dialogs.hideLoadingDialog();
      if (response.error == null && response.data != null) {
        var userData = await getProfile();
        var userCache = await StorageUtils.getUser();
        if (userCache != null && userData != null) {
          var userModel = userCache.copyOf(
              data: userCache.data!.copyOf(userData: userData),
              needUpdate: false);
          currentName.value = userModel.data?.userData?.name ?? '';
          await StorageUtils.saveUser(userModel);
          Utils.fireEvent(ReloadUserEvent());
          getUserInfo();
          Get.back();
        } else {
          toast(LocaleKeys.network_error.tr);
        }
      }
    }
  }

  Future<UserData?> getProfile() async {
    var response = await userProvider.getProfile();
    if (response.error == null && response.data != null) {
      return UserData.fromJson(response.data['data']);
    }
    return null;
  }
  void pickImage(BuildContext context) async {
    Dialogs.showMethodPickImage(context,
        cameraCallBack: () async{
          var lResult = await Utils.takePhoto(1, 0);
      if (lResult != null) filePath.value = lResult[0].path;
    }, galleryCallBack: () async{
          var lResult = await Utils.imagePicker(1, 0);
          if (lResult != null) filePath.value = lResult[0].path;
          });

  }
  @override
  void onClose() {}

  void increment() => count.value++;
}

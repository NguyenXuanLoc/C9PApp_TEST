import 'package:c9p/app/components/dialogs.dart';
import 'package:c9p/app/config/app_translation.dart';
import 'package:c9p/app/data/model/user_model.dart';
import 'package:c9p/app/data/provider/user_provider.dart';
import 'package:c9p/app/routes/app_pages.dart';
import 'package:c9p/app/utils/toast_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../utils/storage_utils.dart';

class UpdateProfileController extends GetxController {
  final userProvider = UserProvider();
  final isMale = true.obs;
  final ImagePicker _picker = ImagePicker();
  final imageUri = ''.obs;
  final fullNameController = TextEditingController();
  final phoneController = TextEditingController();
  final errorFullName = ''.obs;
  final isDisableButton = true.obs;
  final isBackToHome = false.obs;

  @override
  void onInit() {
    init();
    super.onInit();
  }

  void init() async {
    try {
      isBackToHome.value = Get.arguments;
    } catch (ex) {
      isBackToHome.value = false;
    }
    var userModel = await StorageUtils.getUser();
    if (userModel != null) {
      fullNameController.text = userModel.data?.userData?.name ?? '';
      phoneController.text =
          userModel.data?.userData?.phone?.replaceAll('+84', '0') ?? '';
    }
  }

  void updateProfile(BuildContext context) async {
    if (isValid()) {
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
          StorageUtils.saveUser(userModel);
          if (isBackToHome.value) {
            Get.back();
          } else {
            Get.offAllNamed(Routes.HOME,
                arguments: await StorageUtils.isFirstOrder());
          }
        } else {
          toast(LocaleKeys.network_error.tr);
        }
      }
    }
  }

  void setDisableButton(String text) =>
      isDisableButton.value = (text.isEmpty) ? true : false;

  Future<UserData?> getProfile() async {
    var response = await userProvider.getProfile();
    if (response.error == null && response.data != null) {
      return UserData.fromJson(response.data['data']);
    }
    return null;
  }

  bool isValid() {
    if (fullNameController.text.isEmpty) {
      errorFullName.value = LocaleKeys.please_input_full_name.tr;
      return false;
    }
    errorFullName.value = '';
    return true;
  }

  void picImage(bool isCamera) async {
    XFile? file = isCamera
        ? await _picker.pickImage(source: ImageSource.camera)
        : await _picker.pickImage(source: ImageSource.gallery);
    Get.back();
    if (file != null) {
      imageUri.value = file.path;
    }
  }

  void changeSex() => isMale.value = !isMale.value;
}

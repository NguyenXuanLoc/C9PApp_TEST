import 'package:c9p/app/config/app_translation.dart';
import 'package:c9p/app/data/model/combo_best_seller_model.dart';
import 'package:c9p/app/routes/app_pages.dart';
import 'package:c9p/app/utils/storage_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/app_utils.dart';

class ByComboController extends GetxController {
  ComboSellingModel model = Get.arguments;
  final fullNameController = TextEditingController();
  final phoneController = TextEditingController();
  final qtyController = TextEditingController();

  final errorName = ''.obs;
  final errorPhone = ''.obs;
  final errorQty = ''.obs;

  final focusName = FocusNode();
  final focusPhone = FocusNode();
  final focusQty = FocusNode();

  List<String> suggestCount() => [
        '1',
        '2',
        '3',
        '4',
        '5',
      ];

  @override
  void onInit() async {
    checkUserCache();
    super.onInit();
  }

  void onClickContinues() {
    if (isValid()) {
      Get.toNamed(Routes.CONFIRM_ORDER,
          arguments: [model, qtyController.text, fullNameController.text,phoneController.text]);
    }
  }

  void checkUserCache() async {
    var userModel = await StorageUtils.getUser();
    if (userModel != null) {
      fullNameController.text = userModel.data?.userData?.name ?? '';
      phoneController.text = userModel.data?.userData?.phone ?? '';
      qtyController.text = '1';
    }
  }

  bool isValid() {
    bool isValid = true;
    var name = fullNameController.text;
    var phone = phoneController.text;
    var qty = qtyController.text;
    if (name.isEmpty) {
      errorName.value = LocaleKeys.please_input_full_name.tr;
      isValid = false;
    } else {
      errorName.value = '';
    }
    if (phone.isEmpty) {
      errorPhone.value = LocaleKeys.please_input_phone_number.tr;
      isValid = false;
    } else if (!Utils.validateMobile(phone)) {
      errorPhone.value = LocaleKeys.phone_number_khong_hop_le.tr;
      isValid = false;
    } else {
      errorPhone.value = '';
    }
    if (qty.isEmpty || qty == '0') {
      errorQty.value = LocaleKeys.please_input_count.tr;
      isValid = false;
    } else {
      errorQty.value = '';
    }
    return isValid;
  }

  void setQty(String qty) => qtyController.text = qty;

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}

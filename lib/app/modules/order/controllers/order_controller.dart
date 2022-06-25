import 'package:c9p/app/config/app_translation.dart';
import 'package:c9p/app/routes/app_pages.dart';
import 'package:c9p/app/utils/app_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../config/resource.dart';
import '../../../utils/email_validator.dart';

class OrderController extends GetxController {
  final lDescriptionImage = [
    R.assetsPngComSuon9p,
    R.assetsPngComSuon9p,
    R.assetsPngComSuon9p,
  ];
  final pageController = PageController();
  final fullNameController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();
  final dateController = TextEditingController();
  final hourController = TextEditingController();
  final countController = TextEditingController();

  final currentIndex = 0.obs;
  final errorFullName = ''.obs;
  final errorPhoneNumber = ''.obs;
  final errorAddress = ''.obs;
  final errorDate = ''.obs;
  final errorHours = ''.obs;
  final errorCount = ''.obs;

  @override
  void onInit() {
    switchPageListener();
    super.onInit();
  }

  void switchPageListener() {
    pageController.addListener(() {
      final newPage = pageController.page!.round();
      if (newPage != currentIndex) {
        currentIndex.value = newPage;
      }
    });
  }

  void continueOnclick() {
    if (isValid()) Get.toNamed(Routes.ORDER_SUCCESS);
  }

  bool isValid() {
    var fullName = fullNameController.text;
    var phone = phoneController.text;
    var address = addressController.text;
    var date = dateController.text;
    var hours = hourController.text;
    var count = countController.text;
    var isValid = true;
    if (fullName.isEmpty) {
      errorFullName.value = LocaleKeys.please_input_full_name.tr;
      isValid = false;
    } else {
      errorFullName.value = '';
    }
    if (phone.isEmpty) {
      errorPhoneNumber.value = LocaleKeys.please_input_phone_number.tr;
      isValid = false;
    } else if (!Utils.validateMobile(phone)) {
      errorPhoneNumber.value = LocaleKeys.phone_number_khong_hop_le.tr;
    } else {
      errorPhoneNumber.value = '';
    }
    if (address.isEmpty) {
      errorAddress.value = LocaleKeys.please_input_delivery_add.tr;
      isValid = false;
    } else {
      errorAddress.value = '';
    }
    if (date.isEmpty) {
      errorDate.value = LocaleKeys.please_input_delivery_date.tr;
      isValid = false;
    } else {
      errorDate.value = '';
    }
    if (fullName.isEmpty) {
      errorHours.value = LocaleKeys.please_input_delivery_hours.tr;
      isValid = false;
    } else {
      errorHours.value = '';
    }
    if (count.isEmpty) {
      errorCount.value = LocaleKeys.please_input_full_name.tr;
      isValid = false;
    } else {
      errorCount.value = '';
    }
    return isValid;
  }

  void pickTime(BuildContext context) =>
      Utils.showTimePicker(context, (p0) => hourController.text = p0);

  void pickDate(BuildContext context) =>
      Utils.pickDate(context, (p0) => dateController.text = p0);

  List<String> suggestCount() => ['1', '2', '3', '4'];

  void setCount(String count) => countController.text = count;

  @override
  void onReady() {
    super.onReady();
  }
}

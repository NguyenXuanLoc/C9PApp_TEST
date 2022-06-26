import 'dart:async';

import 'package:c9p/app/components/dialogs.dart';
import 'package:c9p/app/config/app_translation.dart';
import 'package:c9p/app/data/model/order_model.dart';
import 'package:c9p/app/data/provider/api_result.dart';
import 'package:c9p/app/data/provider/user_provider.dart';
import 'package:c9p/app/routes/app_pages.dart';
import 'package:c9p/app/utils/app_utils.dart';
import 'package:c9p/app/utils/log_utils.dart';
import 'package:c9p/app/utils/toast_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../config/resource.dart';

class OrderController extends GetxController {
  final lDescriptionImage = [
    R.assetsPngComSuon9p,
    R.assetsPngComSuon9p,
    R.assetsPngComSuon9p,
  ];
  final userProvider = UserProvider();
  final scrollController = ScrollController();
  final pageController = PageController();
  final fullNameController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();
  final dateController = TextEditingController();
  final hourController = TextEditingController();
  final countController = TextEditingController();
  DateTime? deliverTime;
  DateTime? deliverHours;
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

  void scrollToBottom() => Timer(
      const Duration(milliseconds: 500),
      () => scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 500),
          curve: Curves.fastOutSlowIn));

  void switchPageListener() {
    pageController.addListener(() {
      final newPage = pageController.page!.round();
      if (newPage != currentIndex) {
        currentIndex.value = newPage;
      }
    });
  }

  void continueOnclick(BuildContext context) async {
    if (isValid()) {
      Dialogs.showLoadingDialog(context);
      var response = await addOrder();
      await Dialogs.hideLoadingDialog();
      if (response.statusCode == 201) {
        Get.toNamed(Routes.ORDER_SUCCESS,
            arguments: OrderModel.fromJson(response.data));
      } else {
        try {
          toast(response.data['msg'].toString());
        } catch (ex) {
          toast(LocaleKeys.network_error.tr);
        }
      }
    }
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

  void setAddress(String address) => addressController.text = address;

  Future<ApiResult> addOrder() async {
    var name = fullNameController.text;
    var address = addressController.text;
    var phone = phoneController.text;
    var qty = countController.text;
    var lat = '0';
    var lng = '0';
    var deliverTimeStr =
        "${Utils.convertTimeToYYMMDD(deliverTime!)} ${Utils.convertTimeToHHMMSS(deliverHours!)}";
    var productId = '2';
    return await userProvider.addOrder(
        name: name,
        address: address,
        phone: phone,
        qty: qty,
        lat: lat,
        lng: lng,
        deliverTime: deliverTimeStr,
        productId: productId);
  }

  void pickTime(BuildContext context) {
    Utils.showTimePicker(context, (date) {
      deliverHours = date;
      hourController.text = DateFormat("h:mma").format(date);
    });
  }

  void pickDate(BuildContext context) => Utils.pickDate(context, (date) {
        deliverTime = date;
        dateController.text = Utils.convertTimeToDDMMYY(date);
      });

  List<String> suggestCount() => ['1', '2', '3', '4'];

  void setCount(String count) => countController.text = count;

  @override
  void onReady() {
    super.onReady();
  }
}

import 'dart:async';
import 'dart:math';

import 'package:c9p/app/config/globals.dart' as globals;
import 'package:c9p/app/data/provider/user_provider.dart';
import 'package:c9p/app/utils/app_utils.dart';
import 'package:c9p/app/utils/tag_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../components/dialogs.dart';
import '../../../config/app_translation.dart';
import '../../../config/constant.dart';
import '../../../config/globals.dart';
import '../../../data/model/order_model.dart';
import '../../../data/model/payment_info_model.dart';
import '../../../data/model/payment_success_model.dart';
import '../../../data/model/xu_model.dart';
import '../../../data/provider/api_result.dart';
import '../../../routes/app_pages.dart';
import '../../../utils/toast_utils.dart';
import '../../order/controllers/order_controller.dart';

enum MethodPayment { CASH, VNPAY, XU }

class ConfirmRiceOrderController extends GetxController {
  final String tag;
  late RiceOrderParam model;
  final isPaymentByCash = true.obs;
  final isSelectMethodPayment = false.obs;
  final userProvider = UserProvider();
  final currentMethodPayment = MethodPayment.CASH.obs;
  final descriptionController = TextEditingController();
  int countCheckPayment = 0;
  final noteCounter = 0.obs;

  ConfirmRiceOrderController() : tag = Random().nextInt(100).toString();
  final description = ''.obs;
  final xuModel = XuModel().obs;

  void changeMethodPayment(BuildContext context, MethodPayment method) {
    if (method == MethodPayment.XU &&
        ((xuModel.value.balance ?? 0) < getTotalPrice())) {
      toast(LocaleKeys.xu_not_enough_please_try_again.tr);
      return;
    }
    currentMethodPayment.value = method;
    Navigator.pop(context);
    update();
  }

  var deliverTimeStr = '';

  @override
  void onInit() {
    model = Get.arguments;
    deliverTimeStr =
        "${Utils.convertTimeToYYMMDD(model.deliverDate)} ${model.deliverHour.replaceAll('.000Z', '')}";
    getInfoWallet();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    TagUtils().tagsConfirmRiceOrder.removeAt(0);
    super.onReady();
  }

  int getPrice() => model.myComboModel != null
      ? double.parse(model.qty).toInt() * ricePrice
      : double.parse(model.qty).toInt() * ricePrice;

  int getPromotion() => model.myComboModel != null
      ? double.parse(model.qty).toInt() * ricePrice
      : 0 * ricePrice;

  int getTotalPrice() => model.myComboModel != null
      ? shipPrice
      : shipPrice + double.parse(model.qty).toInt() * ricePrice;

  void loadCoinOnClick() => Get.toNamed(Routes.BUY_XU);

  void paymentOnclick(BuildContext context) {
    var timeFormat = 'yyyy-MM-dd HH:mm';
    var deliverTime = DateFormat(timeFormat).parse(deliverTimeStr);
    var currentTime = DateFormat(timeFormat).parse(DateFormat(timeFormat)
        .format(DateTime.fromMillisecondsSinceEpoch(
            DateTime.now().millisecondsSinceEpoch +
                AppConstant.FIFTEN_MINIUTES)));
    if (deliverTime.isBefore(currentTime)) {
      toast(LocaleKeys.order_before_15_minutes.tr);
      return;
    }
    switch(currentMethodPayment.value){
      case MethodPayment.CASH:
        paymentByCash(context, deliverTime);
        break;
      case MethodPayment.VNPAY:
        paymentByVnpay(context, deliverTime);
        break;
      case MethodPayment.XU:

    }
  }

  void paymentByVnpay(BuildContext context, DateTime deliveryTime) async {
    Dialogs.showLoadingDialog(context);
    var response = await paymentRiceOrderByVnPay(deliveryTime);
    await Dialogs.hideLoadingDialog();
    if (response.error == null && response.data != null) {
      if (response.data['data'] == null) {
        try {
          toast(response.data['msg']);
        } catch (ex) {
          toast(LocaleKeys.network_error.tr);
        }
        return;
      }
      var paymentInfoModel = PaymentInfoModel.fromJson(response.data);
      if (!(paymentInfoModel.isSucess ?? true)) {
        toast(paymentInfoModel.message.toString());
      } else {
        var responseCode =
            await Get.toNamed(Routes.PAYMENT, arguments: paymentInfoModel);
        if (responseCode == null) {
          return;
        } else if (responseCode != AppConstant.PAYMENT_SUCCESSFULL) {
          toast(LocaleKeys.payment_failed.tr);
          return;
        }
        countCheckPayment = 0;
        Dialogs.showLoadingDialog(context);
        checkPayment(paymentInfoModel);
      }
    } else {
      toast(response.error.toString());
    }
  }

  void paymentByCash(BuildContext context, DateTime deliveryTime) async {
    Dialogs.showLoadingDialog(context);
    var response = await addOrder(deliveryTime);
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
  void paymentByXu(BuildContext context, DateTime deliveryTime) async {
    Dialogs.showLoadingDialog(context);
    var response = await addOrder(deliveryTime);
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

  Future<ApiResult> addOrder(DateTime deliveryTime) async {
    var name = model.name;
    var address = model.address;
    var phone = model.phone;
    var qty = model.qty;
    var currentLat = model.lat;
    var currentLng = model.long;
    var productId = '2';
    return await userProvider.addOrder(
        name: name,
        address: address,
        phone: phone,
        qty: qty,
        lat: currentLat.toString(),
        lng: currentLng.toString(),
        deliverTime: deliveryTime.microsecondsSinceEpoch.toString(),
        productId: productId,
        useCombo: model.myComboModel != null
            ? (model.myComboModel!.remainsCombo! > int.parse(qty)
                ? model.myComboModel!.remainsCombo! - int.parse(qty)
                : model.myComboModel!.remainsCombo!)
            : 0,
        comboId: model.myComboModel?.id,
        description: description.value);
  }

  Future<ApiResult> paymentRiceOrderByVnPay(DateTime deliveryTime) async {
    var name = model.name;
    var address = model.address;
    var phone = model.phone;
    var qty = model.qty;
    var currentLat = model.lat;
    var currentLng = model.long;
    var productId = '2';
    return await userProvider.paymentRiceOrderByVnPay(
        name: name,
        address: address,
        phone: phone,
        qty: qty,
        lat: currentLat.toString(),
        lng: currentLng.toString(),
        deliverTime: deliveryTime.microsecondsSinceEpoch.toString(),
        productId: productId,
        useCombo: model.myComboModel != null
            ? (model.myComboModel!.remainsCombo! > int.parse(qty)
                ? model.myComboModel!.remainsCombo! - int.parse(qty)
                : model.myComboModel!.remainsCombo!)
            : 0,
        comboId: model.myComboModel?.id,
        description: description.value);
  }

  void checkPayment(PaymentInfoModel model) async {
    countCheckPayment++;
    var response = await userProvider.checkPayment(model.data ?? '');
    if (response.error == null) {
      var paymentSuccessModel = PaymentSuccessModel.fromJson(response.data);
      if ((paymentSuccessModel.isSucess ?? false)) {
        await Dialogs.hideLoadingDialog();
        toast(paymentSuccessModel.message ?? '');
        Get.toNamed(Routes.ORDER_SUCCESS,
            arguments: OrderModel.fromJson(response.data['data']));
      } else {
        if (countCheckPayment == 3) {
          await Dialogs.hideLoadingDialog();
          toast(paymentSuccessModel.message ?? '');
          return;
        }
        Timer(const Duration(seconds: 7), () => checkPayment(model));
      }
    } else {
      if (countCheckPayment == 3) {
        await Dialogs.hideLoadingDialog();
        toast(LocaleKeys.payment_error.tr);
        return;
      }
      Timer(const Duration(seconds: 7), () => checkPayment(model));
    }
  }

  void cancelDescriptionDialog() {
    Get.back();
    setDescription('');
  }

  void finishDescriptionDialog() {
    Get.back();
    setDescription(descriptionController.text);
  }

  void getInfoWallet() async {
    if (globals.isLogin) {
      var response = await userProvider.getInfoWallet();
      if (response.error == null && response.data != null) {
        xuModel.value = XuModel.fromJson(response.data['data']);
      }
    }
  }

  void setDescription(String text) => description.value = text;

  void counterChange(String text) => noteCounter.value = text.length;
}

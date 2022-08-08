import 'dart:async';

import 'package:c9p/app/data/provider/user_provider.dart';
import 'package:c9p/app/utils/log_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../components/dialogs.dart';
import '../../../config/app_translation.dart';
import '../../../config/globals.dart';
import '../../../data/model/order_model.dart';
import '../../../data/model/payment_info_model.dart';
import '../../../data/model/payment_success_model.dart';
import '../../../data/provider/api_result.dart';
import '../../../routes/app_pages.dart';
import '../../../utils/toast_utils.dart';
import '../../order/controllers/order_controller.dart';
import 'package:c9p/app/utils/app_utils.dart';

class ConfirmRiceOrderController extends GetxController {
 late RiceOrderParam model;
  final isPaymentByCash = true.obs;
  final isSelectMethodPayment = false.obs;
  final userProvider = UserProvider();
  int countCheckPayment = 0;

  void changeMethodPayment(BuildContext context,{bool? isShow}){
    isPaymentByCash.value = isShow ?? !isPaymentByCash.value;
    Navigator.pop(context);  }

  void getAgurment() => model = Get.arguments;
  @override
  void onReady() {
    super.onReady();
  }

  int getPrice() => model.myComboModel != null
      ? 0
      : double.parse(model.qty).toInt() * ricePrice;

  int getPromotion() => model.myComboModel != null
      ? 0
      : double.parse(model.qty).toInt() * ricePrice;

  int getTotalPrice() => model.myComboModel != null
      ? shipPrice
      : shipPrice + double.parse(model.qty).toInt() * ricePrice;

  void paymentOnclick(BuildContext context) {
    if (isPaymentByCash.value) {
      paymentByCash(context);
    } else {
      paymentByVnpay(context);
    }
  }

  void paymentByVnpay(BuildContext context) async{
    Dialogs.showLoadingDialog(context);
    var response = await paymentRiceOrderByVnPay();
    await Dialogs.hideLoadingDialog();
    if (response.error == null && response.data != null) {
      var paymentInfoModel = PaymentInfoModel.fromJson(response.data);
      if (!(paymentInfoModel.isSucess ?? true)) {
        toast(paymentInfoModel.message.toString());
      } else {
        var isCheckPayment =
            await Get.toNamed(Routes.PAYMENT, arguments: paymentInfoModel) ??
                false;
        if (!isCheckPayment) return;
        countCheckPayment = 0;
        Dialogs.showLoadingDialog(context);
        checkPayment(paymentInfoModel);
      }
    } else {
      toast(response.error.toString());
    }
  }

  void paymentByCash(BuildContext context) async {
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

  Future<ApiResult> addOrder() async {
    var name = model.name;
    var address = model.address;
    var phone = model.phone;
    var qty = model.qty;
    var currentLat = model.lat;
    var currentLng = model.long;
    var deliverTimeStr =
        "${Utils.convertTimeToYYMMDD(model.deliverDate)} ${model.deliverHour.replaceAll('.000Z', '')}";
    var productId = '2';
    return await userProvider.addOrder(
        name: name,
        address: address,
        phone: phone,
        qty: qty,
        lat: currentLat.toString(),
        lng: currentLng.toString(),
        deliverTime: deliverTimeStr,
        productId: productId,
        useCombo: model.myComboModel != null
            ? (model.myComboModel!.remainsCombo! > int.parse(qty)
                ? model.myComboModel!.remainsCombo! - int.parse(qty)
                : model.myComboModel!.remainsCombo!)
            : 0,
        comboId: model.myComboModel?.id);
  }
  Future<ApiResult> paymentRiceOrderByVnPay() async {
    var name = model.name;
    var address = model.address;
    var phone = model.phone;
    var qty = model.qty;
    var currentLat = model.lat;
    var currentLng = model.long;
    var deliverTimeStr =
        "${Utils.convertTimeToYYMMDD(model.deliverDate)} ${model.deliverHour.replaceAll('.000Z', '')}";
    var productId = '2';
    return await userProvider.paymentRiceOrderByVnPay(
        name: name,
        address: address,
        phone: phone,
        qty: qty,
        lat: currentLat.toString(),
        lng: currentLng.toString(),
        deliverTime: deliverTimeStr,
        productId: productId,
        useCombo: model.myComboModel != null
            ? (model.myComboModel!.remainsCombo! > int.parse(qty)
                ? model.myComboModel!.remainsCombo! - int.parse(qty)
                : model.myComboModel!.remainsCombo!)
            : 0,
        comboId: model.myComboModel?.id);
  }

  void checkPayment(PaymentInfoModel model) async {
    countCheckPayment++;
    var response = await userProvider.checkPayment(model.data ?? '');
    if (response.error == null) {
      var paymentSuccessModel = PaymentSuccessModel.fromJson(response.data);
      if ((paymentSuccessModel.isSucess ?? false)) {
        await Dialogs.hideLoadingDialog();
        toast(paymentSuccessModel.message ?? '');
        Get.toNamed(Routes.ORDER_SUCCESS,);
      } else {
        if (countCheckPayment == 3) {
          await Dialogs.hideLoadingDialog();
          toast(paymentSuccessModel.message ?? '');
          return;
        }
        Timer(const Duration(seconds: 5), () => checkPayment(model));
      }
    } else {
      await Dialogs.hideLoadingDialog();
      toast(response.error.toString());
    }
  }

}

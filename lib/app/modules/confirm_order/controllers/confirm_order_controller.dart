import 'dart:async';

import 'package:c9p/app/config/app_translation.dart';
import 'package:c9p/app/config/constant.dart';
import 'package:c9p/app/data/model/combo_best_seller_model.dart';
import 'package:c9p/app/data/model/payment_success_model.dart';
import 'package:c9p/app/data/provider/user_provider.dart';
import 'package:c9p/app/routes/app_pages.dart';
import 'package:c9p/app/utils/app_utils.dart';
import 'package:c9p/app/utils/log_utils.dart';
import 'package:c9p/app/utils/tag_utils.dart';
import 'package:c9p/app/utils/toast_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:c9p/app/config/globals.dart' as globals;

import '../../../components/dialogs.dart';
import '../../../data/model/payment_info_model.dart';
import '../../../data/model/xu_model.dart';
import '../../confirm_rice_order/controllers/confirm_rice_order_controller.dart';

class ConfirmOrderController extends GetxController {
  String tag;
  ConfirmOrderController(): tag = Utils.getRandomTag();
  ComboSellingModel model = Get.arguments[0];
  String qty = Get.arguments[1];
  String receiver = Get.arguments[2];
  String phoneNumber = Get.arguments[3];
  var userProvider = UserProvider();
  int countCheckPayment = 0;
  final xuModel  = XuModel().obs;
  final currentMethodPayment = MethodPayment.VNPAY.obs;

  @override
  void onInit(){
    getInfoWallet();
    super.onInit();
  }
  int getTotalPrice() => (int.parse(model.price ?? '')) * int.parse(qty);

  void paymentOnClick(BuildContext context) {
    logE("TAG currentMethodPayment.value: ${currentMethodPayment.value}");
    switch (currentMethodPayment.value) {
      case MethodPayment.VNPAY:
        paymentByVnPay(context);
        break;
      case MethodPayment.XU:
        paymentByXu(context);
        break;
    }
  }

  void paymentByXu(BuildContext context) async {
    Dialogs.showLoadingDialog(context);
    var response = await userProvider.buyComboByXu(model.id ?? 0,qty);
    await Dialogs.hideLoadingDialog();
    if (response.error == null && response.data != null) {
      var paymentSuccessModel = PaymentSuccessModel.fromJson(response.data);
      logE("TAG paymentSuccessModel: ${paymentSuccessModel.toJson()}");
      Get.toNamed(Routes.BUY_COMBO_SUCCESS, arguments: [
        model,
        qty,
        receiver,
        phoneNumber,
        paymentSuccessModel,
        PaymentInfoModel(),
        paymentSuccessModel.data?.id.toString()??'0',
        true
      ]);
    } else {
      toast(response.error.toString());
    }
  }
  void paymentByVnPay(BuildContext context) async {
    Dialogs.showLoadingDialog(context);
    var response = await userProvider.buyCombo(model.id ?? 0,qty);
    await Dialogs.hideLoadingDialog();
    if (response.error == null && response.data != null) {
      var paymentInfoModel = PaymentInfoModel.fromJson(response.data);
      if (!(paymentInfoModel.isSucess ?? true)) {
        toast(paymentInfoModel.message.toString());
      } else {
        var responseCode =
            await Get.toNamed(Routes.PAYMENT, arguments: paymentInfoModel);
        if(responseCode == null) {
          return;
        } else if(responseCode != AppConstant.PAYMENT_SUCCESSFULL){
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

  void checkPayment(PaymentInfoModel model) async {
    countCheckPayment++;
    var response = await userProvider.checkPayment(model.data ?? '');
    if (response.error == null) {
      var paymentSuccessModel = PaymentSuccessModel.fromJson(response.data);
      if ((paymentSuccessModel.isSucess ?? false)) {
        await Dialogs.hideLoadingDialog();
        toast(paymentSuccessModel.message ?? '');
        Get.toNamed(Routes.BUY_COMBO_SUCCESS, arguments: [
          this.model,
          qty,
          receiver,
          phoneNumber,
          paymentSuccessModel,
          model,
          response.data['data']['id'],
          false
        ]);
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
        toast(LocaleKeys.payment_error.toString());
        return;
      }
      Timer(const Duration(seconds: 7), () => checkPayment(model));
    }
  }
  void getInfoWallet() async{
    if(globals.isLogin){
      var response = await userProvider.getInfoWallet();
      if(response.error== null && response.data!=null){
        xuModel.value = XuModel.fromJson(response.data['data']);
      }
    }
  }
  void loadCoinOnClick(BuildContext context){
    Navigator.pop(context);
    Get.toNamed(Routes.BUY_XU);
  }
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
  @override
  void onClose() {
    TagUtils().tagsConfirmBuyCombo.removeAt(0);
    super.onClose();
  }
}

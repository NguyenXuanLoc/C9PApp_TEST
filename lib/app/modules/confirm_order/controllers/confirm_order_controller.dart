import 'dart:async';

import 'package:c9p/app/config/app_translation.dart';
import 'package:c9p/app/config/constant.dart';
import 'package:c9p/app/data/model/combo_best_seller_model.dart';
import 'package:c9p/app/data/model/payment_success_model.dart';
import 'package:c9p/app/data/provider/user_provider.dart';
import 'package:c9p/app/routes/app_pages.dart';
import 'package:c9p/app/utils/log_utils.dart';
import 'package:c9p/app/utils/tag_utils.dart';
import 'package:c9p/app/utils/toast_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:c9p/app/config/globals.dart' as globals;

import '../../../components/dialogs.dart';
import '../../../data/model/payment_info_model.dart';
import '../../../data/model/xu_model.dart';

class ConfirmOrderController extends GetxController {
  ComboSellingModel model = Get.arguments[0];
  String qty = Get.arguments[1];
  String receiver = Get.arguments[2];
  String phoneNumber = Get.arguments[3];
  var userProvider = UserProvider();
  int countCheckPayment = 0;
  final xuModel  = XuModel().obs;


  void onClickPayment(BuildContext context) async {
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
          response.data['data']['id']
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
}

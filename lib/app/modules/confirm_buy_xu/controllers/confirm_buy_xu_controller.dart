import 'dart:async';

import 'package:c9p/app/data/model/active_xu_model.dart';
import 'package:c9p/app/data/model/user_model.dart';
import 'package:c9p/app/data/provider/user_provider.dart';
import 'package:c9p/app/utils/app_utils.dart';
import 'package:c9p/app/utils/log_utils.dart';
import 'package:c9p/app/utils/storage_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../components/dialogs.dart';
import '../../../config/app_translation.dart';
import '../../../config/constant.dart';
import '../../../data/model/payment_info_model.dart';
import '../../../data/model/payment_success_model.dart';
import '../../../routes/app_pages.dart';
import '../../../utils/toast_utils.dart';

class ConfirmBuyXuController extends GetxController {
  String tag;

  ConfirmBuyXuController() : tag = Utils.getRandomTag();

  ActiveXuModel model = Get.arguments;
  var userProvider = UserProvider();
  UserModel? userModel;
  final userName = ''.obs;
  int countCheckPayment = 0;

  @override
  void onInit() async {
    getUserInfo();
    super.onInit();
  }

  void getUserInfo() async {
    userModel = await StorageUtils.getUser();
    userName.value = userModel?.data?.userData?.name;
  }

  void confirmOnclick() {
    userProvider.buyXuPackage(model.packId.toString(), '1');
  }

  void paymentOnClick(BuildContext context) async {
    Dialogs.showLoadingDialog(context);
    var response =
        await userProvider.buyXuPackage(model.packId.toString(), '1');
    await Dialogs.hideLoadingDialog();
    if (response.error == null && response.data != null) {
      var paymentInfoModel = PaymentInfoModel.fromJson(response.data);
      if (!(paymentInfoModel.isSucess ?? true)) {
        toast(paymentInfoModel.message.toString());
      } else {
        var responseCode =
            await Get.toNamed(Routes.PAYMENT, arguments: paymentInfoModel);
        if (responseCode == null) {
          // return;
        } else if (responseCode != AppConstant.PAYMENT_SUCCESSFULL) {
          toast(LocaleKeys.payment_failed.tr);
          return;
        }
        countCheckPayment = 0;
        Dialogs.showLoadingDialog(context);
        checkPayment(paymentInfoModel.copyOf(data: 'C9PXuPackGX_291110332862781186205'));
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
        Get.toNamed(Routes.BUY_XU_SUCCESS, arguments: [
          paymentSuccessModel,
          (this.model.freeXu ?? 0) + (this.model.buyXu ?? 0)
        ]);
        /*   Get.toNamed(Routes.BUY_COMBO_SUCCESS, arguments: [
          this.model,
          qty,
          receiver,
          phoneNumber,
          paymentSuccessModel,
          model,
          response.data['data']['id']
        ]);*/
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
}

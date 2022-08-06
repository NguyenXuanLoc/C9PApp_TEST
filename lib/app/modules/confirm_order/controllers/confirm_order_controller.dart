import 'package:c9p/app/data/model/combo_best_seller_model.dart';
import 'package:c9p/app/data/provider/user_provider.dart';
import 'package:c9p/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../components/dialogs.dart';

class ConfirmOrderController extends GetxController {
  ComboSellingModel model = Get.arguments[0];
  String qty = Get.arguments[1];
  String receiver = Get.arguments[2];
  String phoneNumber = Get.arguments[3];
  var userProvider = UserProvider();

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  void onClickPayment(BuildContext context) async{
    Dialogs.showLoadingDialog(context);
    userProvider.buyCombo(model.saleId ?? '');
   await Dialogs.hideLoadingDialog();
    Get.toNamed(Routes.BUY_COMBO_SUCCESS,
        arguments: [model, qty, receiver, phoneNumber]);
  }
}

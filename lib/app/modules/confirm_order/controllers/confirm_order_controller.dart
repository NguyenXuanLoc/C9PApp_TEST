import 'package:c9p/app/data/model/combo_best_seller_model.dart';
import 'package:c9p/app/data/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../components/dialogs.dart';

class ConfirmOrderController extends GetxController {
  ComboSellingModel model = Get.arguments[0];
  String qty = Get.arguments[1];
  String receiver = Get.arguments[2];
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

  void onClickPayment(BuildContext context) {
    Dialogs.showLoadingDialog(context);
    userProvider.buyCombo(model.saleId ?? '');
    Dialogs.hideLoadingDialog();
  }
}

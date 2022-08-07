import 'package:c9p/app/data/model/combo_best_seller_model.dart';
import 'package:c9p/app/data/model/my_combo_model.dart';
import 'package:c9p/app/data/provider/user_provider.dart';
import 'package:c9p/app/utils/log_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';

class TabPromotionController extends GetxController {
  var userProvider = UserProvider();
  final lComboSellingModel =
      List<ComboSellingModel>.empty(growable: true).obs;
  final lMyCombo = List<MyComboModel>.empty(growable: true).obs;
  final isLoadingBestSeller = true.obs;
  final isLoadingMyCombo = true.obs;
  final currentIndexMyCombo = 0.obs;
  @override
  void onInit() {
    getComboSelling();
    getMyCombo();
    super.onInit();
  }

  void openOrder(MyComboModel model) =>
      Get.toNamed(Routes.ORDER, arguments: model);
  void setIndexMyCombo(int index)=> currentIndexMyCombo.value= index;
  void openMyCombo() => Get.toNamed(Routes.MY_COMBO);

  void onClickSeeMore() => Get.toNamed(Routes.COMBO_SELLING);

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  void onRefresh() {
    lMyCombo.value = [];
    lComboSellingModel.value = [];
    getMyCombo();
    getComboSelling();
  }

  void getMyCombo() async {
    isLoadingMyCombo.value = true;
    var response = await userProvider.getMyCombo();
    isLoadingMyCombo.value = false;
    if (response.error == null && response.data != null) {
      lMyCombo.value = myComboModelFromJson(response.data['data']['data']);
    }
  }

  void getComboSelling() async {
    isLoadingBestSeller.value = true;
    var response = await userProvider.getComboSelling();
    isLoadingBestSeller.value = false;
    if (response.error == null && response.data != null) {
      lComboSellingModel.value =
          comboSellingModelFromJson(response.data['data']['data']);
    }
  }

  void openSaleCombo(ComboSellingModel model) =>
      Get.toNamed(Routes.BY_COMBO, arguments: model);
}

import 'package:c9p/app/data/model/combo_best_seller_model.dart';
import 'package:c9p/app/data/model/my_combo_model.dart';
import 'package:c9p/app/data/provider/user_provider.dart';
import 'package:c9p/app/utils/log_utils.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';

class TabPromotionController extends GetxController {
  var userProvider = UserProvider();
  final lComboBestSellerModel =
      List<ComboBestSellerModel>.empty(growable: true).obs;
  final lMyCombo = List<MyComboModel>.empty(growable: true).obs;
  final isLoadingBestSeller = true.obs;
  final isLoadingMyCombo = true.obs;

  @override
  void onInit() {
    getComboBestSellerModel();
    getMyCombo();
    super.onInit();
  }

  void openMyCombo() => Get.toNamed(Routes.MY_COMBO);

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  void onRefresh() {
    lMyCombo.value = [];
    lComboBestSellerModel.value = [];
    getMyCombo();
    getComboBestSellerModel();
  }

  void getMyCombo() async {
    isLoadingMyCombo.value = true;
    var response = await userProvider.getMyCombo();
    isLoadingMyCombo.value = false;
    if (response.error == null && response.data != null) {
      lMyCombo.value = myComboModelFromJson(response.data['data']['data']);
    }
  }

  void getComboBestSellerModel() async {
    isLoadingBestSeller.value = true;
    var response = await userProvider.getComboBestSellerModel();
    isLoadingBestSeller.value = false;
    if (response.error == null && response.data != null) {
      lComboBestSellerModel.value =
          comboBestSellerModelFromJson(response.data['data']['data']);
    }
  }
}

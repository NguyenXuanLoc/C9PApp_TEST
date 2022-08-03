import 'package:c9p/app/data/model/combo_best_seller_model.dart';
import 'package:c9p/app/data/provider/user_provider.dart';
import 'package:c9p/app/utils/log_utils.dart';
import 'package:get/get.dart';

class TabPromotionController extends GetxController {
  var lPromotion = [
    "https://vcdn-dulich.vnecdn.net/2020/09/04/1-Meo-chup-anh-dep-khi-di-bien-9310-1599219010.jpg",
    "https://toanthaydinh.com/wp-content/uploads/2020/04/wallpaper-4k-hinh-nen-4k-hinh-anh-ve-ruong-bac-thang-dep_101311157-1400x788-1.jpg",
    "https://nhattientuu.com/wp-content/uploads/2020/08/hinh-anh-dep-1.jpg"
  ];
  var userProvider = UserProvider();
  final lComboBestSellerModel = List<ComboBestSellerModel>.empty(growable: true).obs;
  final isLoadingBestSeller = true.obs;

  final isLoadingMyCombo= true.obs;
  @override
  void onInit() {
    getComboBestSellerModel();
    getMyCombo();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
void getMyCombo()async{
    isLoadingMyCombo.value = true;
    var response = await userProvider.getMyCombo();
    isLoadingMyCombo.value = false;
}
  void getComboBestSellerModel() async {
    isLoadingBestSeller.value = true;
    var response = await userProvider.getComboBestSellerModel();
    isLoadingBestSeller.value = false;
    if (response.error == null && response.data != null) {
      lComboBestSellerModel.value =
          comboBestSellerModelFromJson(response.data['data']['data']);
      logE("TAG lComboBestSellerModel: ${lComboBestSellerModel.value.length}");
    }
  }
}

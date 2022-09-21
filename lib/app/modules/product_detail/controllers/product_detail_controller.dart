import 'package:c9p/app/config/app_translation.dart';
import 'package:c9p/app/data/database/app_database.dart';
import 'package:c9p/app/data/model/product_model.dart';
import 'package:c9p/app/routes/app_pages.dart';
import 'package:c9p/app/utils/app_utils.dart';
import 'package:c9p/app/utils/log_utils.dart';
import 'package:c9p/app/utils/toast_utils.dart';
import 'package:get/get.dart';

import '../../../data/provider/user_provider.dart';

class ProductDetailController extends GetxController {
  String tag;

  ProductDetailController() : tag = Utils.getRandomTag();
  ProductModel model = Get.arguments;
  final count = 1.obs;
  final lMenu = List<ProductModel>.empty(growable: true).obs;
  final isLoading = true.obs;
  final isReadEnd = false.obs;
  final userProvider = UserProvider();
  var nextPage = 1;
  final totalPrice = 0.obs;
  final quantity = 0.obs;

  @override
  void onInit() {
    getTotalPrice();
    getMenu();
    getQuantity();
    super.onInit();
  }

  void getQuantity() async {
    quantity.value = await AppDatabase.instance.getQuantity();
  }

  void getMenu({bool isPaging = false}) async {
    if (!isPaging) nextPage = 1;
    isLoading.value = true;
    var response = await userProvider.getMenu(nextPage: nextPage);
    isLoading.value = false;
    if (response.error == null && response.data != null) {
      nextPage = response.data['data']['meta']['current_page'];
      var lResponse = productModelFromJson(response.data['data']['data']);
      for (int i = 0; i < lResponse.length; i++) {
        if (lResponse[i].id == model.id) lResponse.removeAt(i);
      }
      if (lResponse.isEmpty) {
        isReadEnd.value = true;
      }
      if (isPaging) {
        lMenu.addAll(lResponse);
        update();
      } else {
        lMenu.value = lResponse;
        // lMyCombo.addAll(lResponse);
        // lMyCombo.addAll(lResponse);
        // lMyCombo.addAll(lResponse);
        update();
      }
      update();
    }
  }

  void decreasing() {
    if (count.value <= 1) return;
    count.value -= 1;
    getTotalPrice();
  }

  void increasing() {
    count.value += 1;
    getTotalPrice();
  }

  void cartOnClick() async {
    try {
      var cacheProduct = await AppDatabase.instance.readProduct(model.id ?? 0);
      if (cacheProduct != null) {
        AppDatabase.instance.update(
            model.copyOf(count: (cacheProduct.count ?? 1) + count.value));
      } else {
        AppDatabase.instance.create(model.copyOf(count: count.value));
      }
      toast(LocaleKeys.add_to_cart_success.tr);
    } catch (ex) {
      toast(LocaleKeys.add_to_cart_fail.tr);
    }
    getQuantity();
  }

  void productOnClick(ProductModel model) => Get.toNamed(Routes.PRODUCT_DETAIL,
      arguments: model, preventDuplicates: false);

  void getTotalPrice() => totalPrice.value = count.value * (model.price ?? 1);

  @override
  void onClose() {}
}

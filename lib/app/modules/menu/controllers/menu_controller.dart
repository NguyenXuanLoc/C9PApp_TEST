import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../data/model/product_model.dart';
import '../../../data/model/my_combo_model.dart';
import '../../../data/provider/user_provider.dart';
import '../../../utils/log_utils.dart';

class MenuController extends GetxController {
  final lMenu = List<ProductModel>.empty(growable: true).obs;
  final isLoadingMyCombo = true.obs;
  final isReadEnd = false.obs;
  final userProvider = UserProvider();
  var scrollController = ScrollController();
  var nextPage = 1;

  @override
  void onInit() {
    getMyCombo();
    paging();
    super.onInit();
  }

  void paging() {
    scrollController.addListener(() {
      var maxScroll = scrollController.position.maxScrollExtent;
      var currentScroll = scrollController.position.pixels;
      if (maxScroll - currentScroll <= 200 &&
          !isLoadingMyCombo.value &&
          !isReadEnd.value) {
        logE("TAG LOAD NEW ITEM: ");
        nextPage++;
        getMyCombo(isPaging: true);
      }
    });
  }

  @override
  void onReady() {
    super.onReady();
  }

  void onRefresh() {
    nextPage = 1;
    isReadEnd.value = false;
    lMenu.value = [];
    getMyCombo();
  }

  void getMyCombo({bool isPaging = false}) async {
    if (!isPaging) nextPage = 1;
    isLoadingMyCombo.value = true;
    var response = await userProvider.getMenu(nextPage: nextPage);
    isLoadingMyCombo.value = false;
    if (response.error == null && response.data != null) {
      nextPage = response.data['data']['meta']['current_page'];
      var lResponse = productModelFromJson(response.data['data']['data']);
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

  void onClickOrderRice(MyComboModel model) {}

  void openComboDetail(MyComboModel model) {}
}

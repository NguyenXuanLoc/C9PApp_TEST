import 'package:c9p/app/data/model/combo_best_seller_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../data/provider/user_provider.dart';
import '../../../utils/log_utils.dart';

class ComboSellingController extends GetxController {
  final lMyCombo = List<ComboSellingModel>.empty(growable: true).obs;
  final isLoadingMyCombo = true.obs;
  final isReadEnd = false.obs;
  final userProvider = UserProvider();
  var scrollController = ScrollController();
  var currentPage = 1;

  @override
  void onInit() {
    getCombo();
    paging();
    super.onInit();
  }

  void paging() {
    scrollController.addListener(() {
      var maxScroll = scrollController.position.maxScrollExtent;
      var currentScroll = scrollController.position.pixels;
      if (maxScroll - currentScroll <= 200 && !isLoadingMyCombo.value && !isReadEnd.value) {
        currentPage++;
        getCombo(isPaging: true);
      }
    });
  }

  @override
  void onReady() {
    super.onReady();
  }

  void onRefresh() {
    currentPage=1;
    isReadEnd.value = false;
    lMyCombo.value=[];
    getCombo();
  }

  void getCombo({bool isPaging = false}) async {
    if(!isPaging)currentPage=1;
    isLoadingMyCombo.value = true;
    var response = await userProvider.getComboSelling(nextPage: currentPage);
    isLoadingMyCombo.value = false;
    if (response.error == null && response.data != null) {
      currentPage = response.data['data']['meta']['current_page'];
      var lResponse = comboSellingModelFromJson(response.data['data']['data']);
      if (lResponse.isEmpty){
        isReadEnd.value = true;
      }
      if (isPaging) {
        lMyCombo.addAll(lResponse);
        update();
      } else {
        // lMyCombo.value = lResponse;
        lMyCombo.addAll(lResponse);
        lMyCombo.addAll(lResponse);
        lMyCombo.addAll(lResponse);
        lMyCombo.addAll(lResponse);
        lMyCombo.addAll(lResponse);
        lMyCombo.addAll(lResponse);
        update();
      }
    }
  }
  void onClickOrderRice(ComboSellingModel model){}
  void openComboDetail(ComboSellingModel model){}
}

import 'package:c9p/app/data/model/my_combo_model.dart';
import 'package:c9p/app/data/provider/user_provider.dart';
import 'package:c9p/app/routes/app_pages.dart';
import 'package:c9p/app/utils/log_utils.dart';
import 'package:c9p/app/utils/toast_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../data/model/combo_best_seller_model.dart';

class MyComboController extends GetxController {
  final lMyCombo = List<MyComboModel>.empty(growable: true).obs;
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
      if (maxScroll - currentScroll <= 200 && !isLoadingMyCombo.value && !isReadEnd.value) {
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
    nextPage=1;
    isReadEnd.value = false;
    lMyCombo.value=[];
    getMyCombo();
  }

  void getMyCombo({bool isPaging = false}) async {
    if(!isPaging)nextPage=1;
    isLoadingMyCombo.value = true;
    var response = await userProvider.getMyCombo(nextPage: nextPage);
    isLoadingMyCombo.value = false;
    if (response.error == null && response.data != null) {
      nextPage = response.data['data']['meta']['current_page'];
      var lResponse = myComboModelFromJson(response.data['data']['data']);
      if (lResponse.isEmpty){
        isReadEnd.value = true;
      }
      if (isPaging) {
        lMyCombo.addAll(lResponse);
        update();
      } else {
        lMyCombo.value = lResponse;
        // lMyCombo.addAll(lResponse);
        // lMyCombo.addAll(lResponse);
        // lMyCombo.addAll(lResponse);
        update();
      }
      update();
    }
  }
  void onClickOrderRice(MyComboModel model)=>Get.toNamed(Routes.ORDER,arguments: model);
  void openComboDetail(MyComboModel model){}
}

import 'package:c9p/app/config/constant.dart';
import 'package:c9p/app/data/model/payment_info_model.dart';
import 'package:c9p/app/utils/log_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
class PaymentController extends GetxController {
  InAppWebViewController? controller;
  var isLoading = true.obs;
  var isLoadError = false.obs;
  PaymentInfoModel model = Get.arguments;

  Future<bool> browserBack(BuildContext context) async {
    return true;
    if (await controller!.canGoBack()) {
      controller!.goBack();
      return false;
    }
    return true;
  }

  void setLoading(bool isLoading) => this.isLoading.value = isLoading;

  void setIsLoadError(bool isLoadError) => this.isLoadError.value = isLoadError;

  void reloadWebView() {
    isLoadError.value = false;
    controller?.reload();
  }

  void setController(InAppWebViewController controller) =>
      this.controller = controller;

  void detectPaymentSuccessful(Uri? uri) {
    var responseCode = uri?.queryParameters[ApiKey.vnp_ResponseCode];
    if (responseCode != null) Get.back(result: responseCode);
  }
}

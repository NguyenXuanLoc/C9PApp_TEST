import 'package:c9p/app/utils/log_utils.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';

class WebviewController extends GetxController {
  InAppWebViewController? controller;
  var isLoading = true.obs;
  var isLoadError = false.obs;
  late String title;
  late String url;

  @override
  onInit() {
    title = Get.arguments[0];
    url = Get.arguments[1];
    super.onInit();
  }

  void setLoading(bool isLoading) => this.isLoading.value = isLoading;

  void setIsLoadError(bool isLoadError) => this.isLoadError.value = isLoadError;

  void reloadWebView() {
    isLoadError.value = false;
    controller?.reload();
  }

  void setController(InAppWebViewController controller) =>
      this.controller = controller;
}

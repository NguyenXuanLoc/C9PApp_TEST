import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';

import '../../../components/app_loading_widget.dart';
import '../../../components/app_scalford.dart';
import '../../../components/app_text.dart';
import '../../../config/app_translation.dart';
import '../../../config/resource.dart';
import '../../../theme/app_styles.dart';
import '../../../theme/colors.dart';
import '../controllers/payment_controller.dart';

class PaymentView extends GetView<PaymentController> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () => controller.browserBack(context),
        child: AppScaffold(
            fullStatusBar: true,
            body: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).padding.top,
                  child: Image.asset(
                    R.assetsBackgroundHeaderTabMainPng,
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.fitWidth,
                  ),
                ),
                Expanded(
                    child: RefreshIndicator(
                        child: Stack(
                          children: [
                            InAppWebView(
                              onWebViewCreated: (ctrl) =>
                                  controller.setController(ctrl),
                              onLoadStop: (ctrl, uri) {
                                controller.detectPaymentSuccessful(uri);
                                controller.setLoading(false);
                              },
                              onLoadStart: (ctrl, uri) =>
                                  controller.setLoading(true),
                              onLoadError: (ctrl, uri, status, message) =>
                                  controller.setIsLoadError(true),
                              onLoadHttpError: (InAppWebViewController ctrl,
                                      Uri? uri, status, String? message) =>
                                  controller.setIsLoadError(true),
                              initialUrlRequest: URLRequest(
                                  url: Uri.parse(
                                      controller.model.message ?? '')),
                            ),
                            Obx(() => Visibility(
                                  visible: controller.isLoading.value,
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: MediaQuery.of(context).size.height,
                                    color: colorWhite,
                                  ),
                                )),
                            Obx(() => Visibility(
                                  visible: controller.isLoading.value,
                                  child: const AppCircleLoading(),
                                )),
                            Obx(() => controller.isLoadError.value
                                ? Center(
                                    child: InkWell(
                                      child: AppText(
                                        LocaleKeys
                                            .net_work_error_click_to_retry.tr,
                                        style: typoSuperSmallTextRegular,
                                      ),
                                      onTap: () => controller.reloadWebView(),
                                    ),
                                  )
                                : SizedBox())
                          ],
                        ),
                        onRefresh: () async => controller.reloadWebView()))
              ],
            )));
  }
}

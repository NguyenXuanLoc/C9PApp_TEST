import 'package:c9p/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../components/app_loading_widget.dart';
import '../../../components/app_scalford.dart';
import '../../../components/app_text.dart';
import '../../../config/app_translation.dart';
import '../../../config/globals.dart';
import '../../../config/resource.dart';
import '../../../theme/app_styles.dart';
import '../../../theme/colors.dart';
import '../controllers/payment_controller.dart';

class PaymentView extends GetView<PaymentController> {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        appbar: AppBar(
          actions: [InkWell(
          child: Icon(Icons.clear,size: 20.w,),
          onTap: () => Get.offAllNamed(Routes.HOME),
        ),SizedBox(width: contentPadding,)],
          leadingWidth: 28.w,
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: AppText(
            LocaleKeys.payment.tr,
            style: typoTitleHeader,
          ),
          flexibleSpace: Container(
            alignment: Alignment.bottomCenter,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(R.assetsBackgroundHeaderTabMainPng),
                    fit: BoxFit.fitWidth)),
          ),
        ),
        fullStatusBar: true,
        isTabToHideKeyBoard: true,
        body: Column(
          children: [
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
        ));
  }
}

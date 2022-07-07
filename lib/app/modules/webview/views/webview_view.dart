import 'package:c9p/app/components/app_loading_widget.dart';
import 'package:c9p/app/components/app_scalford.dart';
import 'package:c9p/app/components/app_text.dart';
import 'package:c9p/app/theme/app_styles.dart';
import 'package:c9p/app/utils/log_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';

import '../../../config/app_translation.dart';
import '../../../config/resource.dart';
import '../../../theme/colors.dart';
import '../controllers/webview_controller.dart';

class WebviewView extends GetView<WebviewController> {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        appbar: AppBar(
          automaticallyImplyLeading: false,
          // toolbarHeight: 30.h,
          centerTitle: true,
          leading: IconButton(
            splashRadius: 20,
            icon: SvgPicture.asset(
              R.assetsBackSvg,
              color: colorWhite,
            ),
            onPressed: () => Get.back(),
          ),
          title: AppText(
            controller.title,
            style: typoTitleHeader.copyWith(
                fontWeight: FontWeight.w700, color: colorText0),
          ),
          flexibleSpace: Container(
            alignment: Alignment.bottomCenter,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(R.assetsBackgroundHeaderTabMainPng),
                    fit: BoxFit.fitWidth)),
          ),
        ),
        body: RefreshIndicator(
            child: Stack(
              children: [
                InAppWebView(
                  onWebViewCreated: (ctrl) => controller.setController(ctrl),
                  onLoadStop: (ctrl, uri) => controller.setLoading(false),
                  onLoadStart: (ctrl, uri) => controller.setLoading(true),
                  onLoadError: (ctrl, uri, status, message) =>
                      controller.setIsLoadError(true),
                  onLoadHttpError: (InAppWebViewController ctrl, Uri? uri,
                          status, String? message) =>
                      controller.setIsLoadError(true),
                  initialUrlRequest:
                      URLRequest(url: Uri.parse(controller.url)),
                ),
                Obx(() => Visibility(
                      visible: controller.isLoading.value,
                      child: const AppCircleLoading(),
                    )),
                Obx(() => controller.isLoadError.value
                    ? Center(
                        child: InkWell(
                          child: AppText(
                            LocaleKeys.net_work_error_click_to_retry.tr,
                            style: typoSuperSmallTextRegular,
                          ),
                          onTap: () => controller.reloadWebView(),
                        ),
                      )
                    : SizedBox())
              ],
            ),
            onRefresh: () async => controller.reloadWebView()));
  }
}

import 'package:c9p/app/components/app_text.dart';
import 'package:c9p/app/config/app_translation.dart';
import 'package:c9p/app/modules/tab_account/views/tab_account_view.dart';
import 'package:c9p/app/modules/tab_main/views/tab_main_view.dart';
import 'package:c9p/app/modules/tab_notify/views/tab_notify_view.dart';
import 'package:c9p/app/modules/tab_promotion/views/tab_promotion_view.dart';
import 'package:c9p/app/routes/app_pages.dart';
import 'package:c9p/app/theme/app_styles.dart';
import 'package:c9p/app/theme/colors.dart';
import 'package:c9p/app/utils/log_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:c9p/app/config/resource.dart';
import 'package:get/get.dart';

import '../../../components/app_keep_alive.dart';
import '../../../components/app_scalford.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    controller.setContext(context);
    return WillPopScope(
        child: AppScaffold(
          resizeToAvoidBottomInset: false,
          fullStatusBar: true,
          body: PageView(
            controller: controller.pageController,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              KeepAliveWrapper(
                child: TabMainView(),
              ),
              KeepAliveWrapper(
                child: TabPromotionView(),
              ),
              KeepAliveWrapper(
                child: TabNotifyView(),
              ),
              KeepAliveWrapper(
                child: TabAccountView(),
              ),
            ],
          ),
          floatingActionButton: Padding(
            padding: EdgeInsets.only(top: 15.h),
            child: FloatingActionButton(
              backgroundColor: Colors.transparent,
              child: SvgPicture.asset(
                R.assetsAddOrderSvg,
                width: 50.w,
              ),
              onPressed: () => Get.toNamed(Routes.ORDER),
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: bottomNavigationWidget(),
        ),
        onWillPop: () async => await controller.onBackPress());
  }

  Widget bottomNavigationWidget() {
    return Container(
      decoration: BoxDecoration(
        color: colorWhite,
        borderRadius: const BorderRadius.only(
            topRight: Radius.circular(10), topLeft: Radius.circular(10)),
        boxShadow: [
          BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 0,
              blurRadius: 1),
        ],
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
        child: BottomAppBar(
          elevation: 0,
          color: colorWhite,
          child: SizedBox(
            height: 50.h,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Obx(() =>
                    itemBottomBar(R.assetsMainSvg, LocaleKeys.main.tr, 0)),
                Obx(() => itemBottomBar(
                    R.assetsPromotionSvg, LocaleKeys.promotion.tr, 1)),
                const Expanded(child: SizedBox()),
                Obx(() =>
                    itemBottomBar(R.assetsNotifySvg, LocaleKeys.notify.tr, 2)),
                Obx(() =>
                    itemBottomBar(R.assetsPersonSvg, LocaleKeys.account.tr, 3)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget itemBottomBar(String assetSvg, String title, int index) {
    return Expanded(
        child: Container(
      color: controller.currentIndex.value == index ? colorGrey5 : colorWhite,
      child: InkWell(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 20.w,
              height: 20.w,
              child: SvgPicture.asset(
                assetSvg,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(
              height: 3,
            ),
            AppText(
              title,
              style: typoSuperSmallTextBold.copyWith(
                  color: colorText40, fontSize: 9.5.sp),
            )
          ],
        ),
        onTap: () => controller.jumToTap(index),
      ),
    ));
  }
}

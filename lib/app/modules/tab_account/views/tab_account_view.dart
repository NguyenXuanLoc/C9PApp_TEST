import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';

import '../../../components/app_scalford.dart';
import '../../../components/app_text.dart';
import '../../../config/app_translation.dart';
import '../../../config/globals.dart';
import '../../../config/resource.dart';
import '../../../theme/app_styles.dart';
import '../../../theme/colors.dart';
import '../controllers/tab_account_controller.dart';

enum AccountAction {
  PROFILE,
  MY_COMBO,
  MY_LOCATION,
  METHOD_PAYMENT,
  MY_ORDER,
  REGULATION,
  CHANGE_PIN,
  LOGOUT
}

class TabAccountView extends GetView<TabAccountController> {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        fullStatusBar: true,
        isTabToHideKeyBoard: true,
        appbar: AppBar(
          actions: [
            Obx(() => Visibility(
                  visible: controller.isSave.value,
                  child: TextButton(
                      onPressed: () => controller.updateProfile(context),
                      child: AppText(
                        LocaleKeys.save.tr,
                        style: typoSmallTextBold.copyWith(color: colorText0),
                      )),
                ))
          ],
          automaticallyImplyLeading: false,
          // centerTitle: true,
          title: Row(
            children: [
              SvgPicture.asset(R.assetsSvgCircleAvatar),
              const SizedBox(
                width: 10,
              ),
              Obx(() => AppText(
                controller.currentName.value,
                style: typoSmallText700.copyWith(color: colorText0),
              ))
            ],
          ),
          flexibleSpace: Container(
            alignment: Alignment.bottomCenter,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(R.assetsBackgroundHeaderTabMainPng),
                    fit: BoxFit.fitWidth)),
          ),
        ),
        body: Column(
          children: [
            itemTitle(R.assetsSvgPerson3, LocaleKeys.profile.tr),
            line(context),
            itemTitle(
                R.assetsSvgPromotionCircleOrange, LocaleKeys.my_promotion.tr),
            line(context),
            itemTitle(R.assetsSvgOrangeLocation, LocaleKeys.my_location.tr),
            line(context),
            itemTitle(R.assetsSvgDolaCircle, LocaleKeys.method_payment.tr),
            line(context),
            itemTitle(R.assetsSvgPerson3, LocaleKeys.profile.tr),
            line(context),
            itemTitle(R.assetsSvgOrder, LocaleKeys.my_order.tr),
            Container(
              width: MediaQuery.of(context).size.width,
              color: colorSeparatorListView,
              padding: EdgeInsets.all(contentPadding),
              child: AppText(
                LocaleKeys.more_setting.tr,
                style: typoSmallTextBold.copyWith(fontSize: 14.sp),
              ),
            ),
            itemTitle(R.assetsSvgFile, LocaleKeys.regulation.tr),
            line(context),
            itemTitle(R.assetsSvChangePin, LocaleKeys.change_pin.tr),
            line(context),
            itemTitle(R.assetsSvgLogout, LocaleKeys.profile.tr),
            Expanded(
                child: Container(
              color: colorSeparatorListView,
            ))
          ],
        ));
  }

  Widget line(BuildContext context) => Container(
        height: 0.1,
        color: colorBlack,
        width: MediaQuery.of(context).size.width,
      );

  Widget itemTitle(String icon, String title) => Padding(
        padding: EdgeInsets.only(
            left: contentPadding,
            right: contentPadding,
            top: 11.h,
            bottom: 11.h),
        child: Row(
          children: [
            SvgPicture.asset(
              icon,
              width: 15.w,
            ),
            const SizedBox(
              width: 10,
            ),
            AppText(
              title,
              style: typoSuperSmallText600.copyWith(fontSize: 13.sp),
            ),
            const Spacer(),
            const Icon(
              Icons.arrow_forward_ios_outlined,
              size: 11,
            )
          ],
        ),
      );
}

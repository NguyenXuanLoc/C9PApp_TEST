import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';

import '../../../components/app_circle_image.dart';
import '../../../components/app_scalford.dart';
import '../../../components/app_text.dart';
import '../../../config/app_translation.dart';
import '../../../config/constant.dart';
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
  MY_XU,
  REGULATION,
  CHANGE_PIN,
  LOGOUT,
  DELETE
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
              InkWell(
                child: Obx(() => controller.avatarUrl.value.isNotEmpty &&
                        controller.avatarUrl.value != MessageKey.avatarDefault
                    ? AppCircleImage(
                        url: controller.avatarUrl.value,
                        size: 28.w,
                      )
                    : SvgPicture.asset(
                        R.assetsSvgCircleAvatar,
                        width: 28.w,
                      )),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(child: Obx(() => AppText(
                        controller.currentName.value,
                        maxLine: 1,
                        textOverflow: TextOverflow.ellipsis,
                        style: typoSmallText700.copyWith(color: colorText0),
                      )))
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
            itemTitle(R.assetsSvgPerson3, LocaleKeys.profile.tr,AccountAction.PROFILE,context,),
            line(context),
            itemTitle(
                R.assetsSvgPromotionCircleOrange, LocaleKeys.my_promotion.tr,AccountAction.MY_COMBO,context,),
            line(context),
            itemTitle(R.assetsSvgOrangeLocation, LocaleKeys.my_location.tr,AccountAction.MY_LOCATION,context,),
            line(context),
            itemTitle(R.assetsSvgDolaCircle, LocaleKeys.method_payment.tr,AccountAction.METHOD_PAYMENT,context,),
            line(context),
            itemTitle(R.assetsSvgOrder, LocaleKeys.my_order.tr,AccountAction.MY_ORDER,context,),
            line(context),
            itemTitle(R.assetsPngXu, LocaleKeys.my_com_9_phut_xu.tr,AccountAction.MY_XU,context,isSvg: false),
            Container(
              width: MediaQuery.of(context).size.width,
              color: colorSeparatorListView,
              padding: EdgeInsets.all(contentPadding),
              child: AppText(
                LocaleKeys.more_setting.tr,
                style: typoSmallTextBold.copyWith(fontSize: 14.sp),
              ),
            ),
            itemTitle(R.assetsSvgFile, LocaleKeys.regulation.tr,AccountAction.REGULATION,context,),
            line(context),
            itemTitle(R.assetsSvChangePin, LocaleKeys.change_pin.tr,AccountAction.CHANGE_PIN,context),
            line(context),
            itemTitle(R.assetsSvgDelete, LocaleKeys.delete_account.tr,
                AccountAction.DELETE, context,
                isShowSuffixIcon: false),
            line(context),
            InkWell(
              child: itemTitle(
                  R.assetsSvgLogout, LocaleKeys.logout.tr, AccountAction.LOGOUT,context,
                  isShowSuffixIcon: false),
              onTap: () => controller.logout(context),
            ),
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

  Widget itemTitle(
          String icon, String title, AccountAction action, BuildContext context,
          {bool isShowSuffixIcon = true, bool isSvg = true}) =>
      Padding(
        padding: EdgeInsets.only(
            left: contentPadding,
            right: contentPadding,
            top: 11.h,
            bottom: 11.h),
        child: InkWell(child: Row(
          children: [
              isSvg
                  ? SvgPicture.asset(
                      icon,
                      width: 15.w,
                    )
                  : Image.asset(
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
              Visibility(
                visible: isShowSuffixIcon,
                child: const Icon(
                  Icons.arrow_forward_ios_outlined,
                  size: 11,
                ),
              )
            ],
        ),onTap: ()=>controller.handleAction(action,context),),
      );
}

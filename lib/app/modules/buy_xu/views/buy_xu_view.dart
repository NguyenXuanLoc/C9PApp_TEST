import 'package:c9p/app/components/app_loading_widget.dart';
import 'package:c9p/app/components/app_not_data_widget.dart';
import 'package:c9p/app/components/app_scalford.dart';
import 'package:c9p/app/components/app_separaror.dart';
import 'package:c9p/app/components/app_text.dart';
import 'package:c9p/app/data/model/active_xu_model.dart';
import 'package:c9p/app/extension/string_extension.dart';
import 'package:c9p/app/theme/app_styles.dart';
import 'package:c9p/app/utils/app_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';

import '../../../components/app_button.dart';
import '../../../components/app_line_space.dart';
import '../../../components/app_refresh_widget.dart';
import '../../../config/app_translation.dart';
import '../../../config/globals.dart';
import '../../../config/resource.dart';
import '../../../theme/colors.dart';
import '../../../utils/tag_utils.dart';
import '../controllers/buy_xu_controller.dart';

class BuyXuView extends StatelessWidget {
  var controller = TagUtils().findBuyXuController();

  BuyXuView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        appbar: appbar(context),
        body: AppRefreshWidget(
          onRefresh: () => controller!.onRefresh(),
          body: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Container(
                      padding: EdgeInsets.only(bottom: 35.h),
                      width: MediaQuery.of(context).size.width,
                      child: SvgPicture.asset(
                        R.assetsBackgroundHeaderTabMainSvg,
                        fit: BoxFit.fitWidth,
                        height: 30.h,
                        width: MediaQuery.of(context).size.width,
                      ),
                    ),
                    Positioned.fill(
                        child: Align(
                      alignment: Alignment.topCenter,
                      child: infoWalletWidget(context),
                    ))
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                paddingWidget(AppText(
                  LocaleKeys.deposit_xu_into_your_account.tr,
                  style: typoSmallTextBold,
                )),
                itemSpace(),
                paddingWidget(Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: colorOrange40.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8)),
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText(
                        LocaleKeys.amount_want_to_deposit.tr,
                        style: typoSuperSmallTextRegular,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Obx(() => AppText(
                            "${Utils.formatXu(controller!.selectModel.value.buyXu ?? 0)} ${LocaleKeys.xu.tr}",
                            style: typoSuperSmallText600.copyWith(
                                color: colorOrange70),
                          )),
                      itemSpace(),
                      SizedBox(
                        height: 33.h,
                        child: Center(
                          child: Obx(() => controller!.lPackageXu.isEmpty &&
                                  controller!.isLoading.value
                              ? const AppCircleLoading()
                              : controller!.lPackageXu.isNotEmpty
                                  ? ListView.separated(
                                      controller: controller!.scrollController,
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      physics: const BouncingScrollPhysics(),
                                      itemBuilder: (c, i) =>
                                          (i == controller!.lPackageXu.length)
                                              ? const AppCircleLoading()
                                              : itemXu(context,
                                                  controller!.lPackageXu[i]),
                                      separatorBuilder: (i, x) =>
                                          const SizedBox(
                                            width: 10,
                                          ),
                                      itemCount: (controller!.isLoading.value &&
                                              controller!
                                                  .lPackageXu.isNotEmpty &&
                                              !controller!.isReadEnd.value)
                                          ? controller!.lPackageXu.length + 1
                                          : controller!.lPackageXu.length)
                                  : AppText(
                                      LocaleKeys.not_data_pull_to_refresh.tr,
                                      textAlign: TextAlign.center,
                                      style: typoSuperSmallTextBold.copyWith(
                                        color: colorText60,
                                      ),
                                    )),
                        ),
                      )
                    ],
                  ),
                )),
                itemSpace(),
                Obx(() => itemInfoXu(
                    context,
                    LocaleKeys.number_of_coins_received.tr,
                    "${Utils.formatXu((controller!.selectModel.value.buyXu ?? 0) + (controller!.selectModel.value.freeXu ?? 0))} ${LocaleKeys.xu.tr}")),
                const SizedBox(
                  height: 7,
                ),
                paddingWidget(const AppSeparator()),
                const SizedBox(
                  height: 7,
                ),
                Obx(() => itemInfoXu(context, LocaleKeys.need_payment.tr,
                    '${Utils.formatXu(controller?.selectModel.value.price ?? 0)}đ')),
                itemSpace(),
                const AppLineSpace(),
                itemSpace(),
                paddingWidget(AppText(
                  LocaleKeys.introduce_com_9_phut_xu.tr,
                  style: typoSmallTextBold.copyWith(fontSize: 16.sp),
                )),
                itemContent(LocaleKeys.introduce_1.tr),
                line(context),
                itemContent(LocaleKeys.introduce_2.tr),
                line(context),
                itemContent(LocaleKeys.introduce_3.tr),
                line(context),
                itemContent(LocaleKeys.introduce_4.tr),
                line(context),
                itemContent(LocaleKeys.introduce_5.tr),
                line(context),
                itemContent(LocaleKeys.introduce_6.tr),
                itemSpace(),
                Obx(() => paddingWidget(AppButton(
                      disable: controller!.selectModel.value.price == null
                          ? true
                          : false,
                      height: heightContinue,
                      onPress: () => controller!.confirmOnclick(),
                      title: LocaleKeys.payment.tr.toCapitalized(),
                      textStyle: typoButton.copyWith(color: colorWhite),
                      backgroundColor:
                          controller?.selectModel.value.price != null
                              ? colorGreen40
                              : colorGrey10,
                      width: MediaQuery.of(context).size.width,
                      shapeBorder:
                          shapeBorderButton /*RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(17))*/
                      ,
                    )))
              ],
            ),
          ),
        ));
  }

  Widget itemInfoXu(BuildContext context, String title, String content) =>
      paddingWidget(Row(
        children: [
          AppText(
            title,
            style: typoSuperSmallTextRegular,
          ),
          const Spacer(),
          AppText(
            content,
            style: typoSuperSmallTextRegular,
          )
        ],
      ));

  Widget itemXu(BuildContext context, ActiveXuModel model) => InkWell(
        child: Container(
          padding: EdgeInsets.only(left: 13.w, right: 13.w),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: colorBlack, width: 0.2)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AppText(
                '${Utils.formatXu(model.price ?? 0)}đ',
                style: typoSuperSmallTextRegular,
              ),
              AppText(
                '(${LocaleKeys.donate.tr} ${Utils.formatXu(model.freeXu ?? 0)} ${LocaleKeys.xu.tr})',
                style: typoSuperSmallTextRegular.copyWith(
                    fontSize: 9.sp, color: colorBlue30),
              )
            ],
          ),
        ),
        onTap: () => controller!.selectPackageXu(model),
      );

  Widget paddingWidget(Widget widget) => Padding(
        padding: EdgeInsets.only(left: contentPadding, right: contentPadding),
        child: widget,
      );

  Widget infoWalletWidget(BuildContext context) => Padding(
        padding: EdgeInsets.only(left: contentPadding, right: contentPadding),
        child: Container(
          padding: EdgeInsets.only(
              left: contentPadding,
              right: contentPadding - 2,
              top: contentPadding,
              bottom: contentPadding),
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 4,
              offset: const Offset(0, 0.5),
            )
          ], borderRadius: BorderRadius.circular(15), color: colorWhite),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  AppText(
                    LocaleKeys.xu_in_wallet.tr,
                    style: typoSuperSmallText600,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.asset(
                        R.assetsPngXu,
                        width: 14.w,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      AppText(
                          '${Utils.formatXu(controller!.xuModel.value.balance ?? 0)} ${LocaleKeys.xu.tr}',
                          style:
                              typoSmallTextBold.copyWith(color: colorOrange70))
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      );

  Widget itemSpace() => SizedBox(
        height: 11.h,
      );

  Widget line(BuildContext context) => Container(
        margin: EdgeInsets.only(left: contentPadding, right: contentPadding),
        height: 0.1,
        color: colorBlack,
        width: MediaQuery.of(context).size.width,
      );

  Widget itemContent(String title) => Padding(
        padding: EdgeInsets.only(
            left: contentPadding, right: contentPadding, bottom: 10, top: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              R.assetsPngTick,
              width: 20.w,
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
                child: AppText(
              title,
              style: typoSuperSmallText500,
            )),
          ],
        ),
      );

  PreferredSizeWidget appbar(BuildContext context) => AppBar(
        leadingWidth: 28.w,
        leading: Padding(
            padding: EdgeInsets.only(left: contentPadding),
            child: InkWell(
              child: SvgPicture.asset(
                R.assetsBackSvg,
                color: colorWhite,
              ),
              onTap: () => Get.back(),
            )),
        title: AppText(
          LocaleKeys.deposit_xu_com9p.tr,
          style: typoTitleHeader,
        ),
        automaticallyImplyLeading: false,
        centerTitle: true,
        flexibleSpace: SvgPicture.asset(
          R.assetsBackgroundHeaderTabMainSvg,
          fit: BoxFit.cover,
        ),
      );
}

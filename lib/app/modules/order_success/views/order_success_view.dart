import 'package:c9p/app/components/app_line_space.dart';
import 'package:c9p/app/config/globals.dart';
import 'package:c9p/app/data/model/weather_model.dart';
import 'package:c9p/app/utils/app_utils.dart';
import 'package:c9p/app/utils/tag_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../components/app_button.dart';
import '../../../components/app_scalford.dart';
import '../../../components/app_text.dart';
import '../../../config/app_translation.dart';
import '../../../config/constant.dart';
import '../../../config/resource.dart';
import '../../../theme/app_styles.dart';
import '../../../theme/colors.dart';

class OrderSuccessView extends StatelessWidget {
  OrderSuccessView({Key? key}) : super(key: key);
  var controller = TagUtils().findRiceOrderSuccessController();

  @override
  Widget build(BuildContext context) {
    return controller?.model != null ?
    WillPopScope(
        child: AppScaffold(
          appbar: AppBar(
            centerTitle: true,
            automaticallyImplyLeading: false,
            flexibleSpace: Container(
              alignment: Alignment.bottomCenter,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(R.assetsBackgroundHeaderTabMainPng),
                      fit: BoxFit.fitWidth)),
              child: Container(
                height: 30.h,
                decoration: BoxDecoration(
                    color: colorWhite,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(15.w),
                        topLeft: Radius.circular(15.w))),
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Center(
                  child: Image.asset(
                    R.assetsPngOrderSuccessLike,
                    width: MediaQuery
                        .of(context)
                        .size
                        .width / 2.2,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 30.w, right: 30.w),
                  child: AppText(
                    LocaleKeys.order_success.tr,
                    textAlign: TextAlign.center,
                    style: typoMediumTextBold.copyWith(
                        fontWeight: FontWeight.w800),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 30.w, right: 30.w),
                  child: AppText(
                    LocaleKeys.you_have_just_order_success.tr +
                        controller!.model!.orderId.toString(),
                    textAlign: TextAlign.center,
                    style: typoSuperSmallText500.copyWith(
                        color: colorText60, fontSize: 12.sp),
                  ),
                ),
                itemSpace(),
                itemSpace(),
                itemSpace(),
                const AppLineSpace(),
                itemTitle(R.assetsSvgBag, LocaleKeys.order.tr),
                line(context),
                itemContent(LocaleKeys.com_suong_9p.tr,
                    'x${controller?.model?.itemQty.toString() ?? ''}'),
                line(context),
                itemContent(LocaleKeys.payment.tr,
                        "${Utils.formatMoney((controller?.model?.amount ?? 0) + (controller?.model?.paymentType == MessageKey.VNPay ? 0 : controller?.model?.shippingFee ?? 0))}đ"),
                    line(context),
                    itemContent(
                        LocaleKeys.method_payment.tr,
                        (controller?.model?.paymentType != null)
                            ? (controller?.model?.paymentType ==
                                    MessageKey.VNPay
                                ? LocaleKeys.vn_pay.tr
                                : LocaleKeys.cash.tr)
                            : LocaleKeys.cash.tr),
                    const AppLineSpace(),
                    itemInfoXu(
                        R.assetsPngXu,
                        "${LocaleKeys.one_precent_of_order_value.tr}- ${"${Utils.formatXu(controller?.model?.returnXu ?? 0)} ${LocaleKeys.xu.tr}"}"),
                    const AppLineSpace(),
                    itemTitle(R.assetsSvgPerson3, LocaleKeys.buyer.tr),
                line(context),
                itemContent(LocaleKeys.full_name.tr,
                    controller?.model?.buyerName ?? ''),
                line(context),
                itemContent(LocaleKeys.phone_number.tr, controller?.model?.buyerPhone
                    ?? ''),
                line(context),
                itemContent(
                    LocaleKeys.address.tr, controller?.model?.toAddress ?? ''),
                itemSpace(),
                // itemSpace(),
                Padding(
                  padding: EdgeInsets.only(
                      left: contentPadding, right: contentPadding),
                  child: AppButton(
                    height: heightContinue,
                    onPress: () => controller?.mainOnclick(),
                    title: LocaleKeys.main.tr,
                    backgroundColor: colorWhite,
                    shapeBorder: shapeBorderButton.copyWith(
                        side: BorderSide(color: colorGreen55)),
                    textStyle: typoButton.copyWith(color: colorText100),
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: contentPadding, right: contentPadding),
                  child: AppButton(
                    height: heightContinue,
                    onPress: () => controller?.myOrderOnclick(),
                    title: LocaleKeys.my_order.tr,
                    backgroundColor: colorGreen55,
                    shapeBorder: shapeBorderButton,
                    textStyle: typoButton.copyWith(color: colorText0),
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                  ),
                ),
                SizedBox(
                  height: 10,
                )
              ],
            ),
          ),
        ),
        onWillPop: () async => controller!.onBackPress()) :
     WillPopScope(
        child: AppScaffold(
          padding: EdgeInsets.all(15.w),
          appbar: AppBar(
            centerTitle: true,
            automaticallyImplyLeading: false,
            flexibleSpace: Container(
              alignment: Alignment.bottomCenter,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(R.assetsBackgroundHeaderTabMainPng),
                      fit: BoxFit.fitWidth)),
              child: Container(
                height: 30.h,
                decoration: BoxDecoration(
                    color: colorWhite,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(15.w),
                        topLeft: Radius.circular(15.w))),
              ),
            ),
          ),
          body: Column(
            children: [
              const Spacer(),
              SvgPicture.asset(R.assetsSvgOrderSuccess),
              const SizedBox(
                height: 40,
              ),
              Padding(
                padding: EdgeInsets.only(left: 30.w, right: 30.w),
                child: AppText(
                  LocaleKeys.order_success.tr,
                  textAlign: TextAlign.center,
                  style:
                  typoMediumTextBold.copyWith(fontWeight: FontWeight.w800),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: EdgeInsets.only(left: 30.w, right: 30.w),
                child: AppText(
                  LocaleKeys.order_succes_choose_option.tr,
                  textAlign: TextAlign.center,
                  style: typoSuperSmallText500.copyWith(
                      color: colorText60, fontSize: 12.sp),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              AppButton(
                height: heightContinue,
                onPress: () => controller?.mainOnclick(),
                title: LocaleKeys.main.tr,
                backgroundColor: colorWhite,
                shapeBorder: shapeBorderButton.copyWith(
                    side: BorderSide(color: colorGreen55)),
                textStyle: typoButton.copyWith(color: colorText100),
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
              ),
              const SizedBox(
                height: 10,
              ),
              AppButton(
                height: heightContinue,
                onPress: () => controller?.myOrderOnclick(),
                title: LocaleKeys.my_order.tr,
                backgroundColor: colorGreen55,
                shapeBorder: shapeBorderButton,
                textStyle: typoButton.copyWith(color: colorText0),
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
              ),
              const Spacer(),
              const Spacer(),
            ],
          ),
        ),
        onWillPop: () async => controller!.onBackPress());
  }

  Widget itemTitle(String icon, String title) => Padding(
        padding: EdgeInsets.only(
            left: contentPadding, right: contentPadding, top: 10, bottom: 10),
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
              style: typoSuperSmallText600,
            )
          ],
        ),
      );
  Widget itemInfoXu(String icon, String title) => Padding(
        padding: EdgeInsets.only(
            left: contentPadding, right: contentPadding, top: 10, bottom: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              icon,
              width: 15.w,
            ),
            const SizedBox(
              width: 10,
            ),
            AppText(
              LocaleKeys.cash_back.tr,
              style: typoSuperSmallText600,
            ),
            const SizedBox(
              width: 20,
            ),
            Expanded(
                child: AppText(
              title,textAlign: TextAlign.end,
              style: typoSuperSmallTextRegular,
            ))
          ],
        ),
      );

  Widget itemContent(String title, String content) => Padding(
        padding: EdgeInsets.only(
            left: contentPadding, right: contentPadding, bottom: 10, top: 10),
        child: Row(crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: AppText(
              title,
              style: typoSuperSmallText500,
            )),
            Expanded(
                child: AppText(
              content,
              style: typoSuperSmallText500,
              textAlign: TextAlign.end,
              maxLine: 2,
            ))
          ],
        ),
      );

  Widget itemSpace() => const SizedBox(
        height: 10,
      );

  Widget line(BuildContext context) => Container(
        margin: EdgeInsets.only(left: contentPadding, right: contentPadding),
        height: 0.1,
        color: colorBlack,
        width: MediaQuery.of(context).size.width,
      );
}

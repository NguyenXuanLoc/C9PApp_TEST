import 'package:c9p/app/components/app_button.dart';
import 'package:c9p/app/components/app_line_space.dart';
import 'package:c9p/app/config/app_translation.dart';
import 'package:c9p/app/config/globals.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../components/app_scalford.dart';
import '../../../components/app_text.dart';
import '../../../config/resource.dart';
import '../../../theme/app_styles.dart';
import '../../../theme/colors.dart';
import '../../../utils/app_utils.dart';
import '../controllers/buy_combo_success_controller.dart';

class BuyComboSuccessView extends GetView<BuyComboSuccessController> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: AppScaffold(
          appbar: AppBar(
            automaticallyImplyLeading: false,
            elevation: 0,
            centerTitle: true,
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Image.asset(
                    R.assetsPngOrderSuccessLike,
                    width: MediaQuery.of(context).size.width / 2.2,
                  ),
                ),
                itemSpace(),
                itemSpace(),
                Center(
                  child: AppText(
                    LocaleKeys.order_success.tr,
                    style: typoMediumText700,
                  ),
                ),
                Center(
                  child: AppText(
                    "${LocaleKeys.you_have_successfully_placed_order_number.tr} #12345",
                    style: typoSuperSmallText500.copyWith(
                        fontSize: 12.sp, color: colorText40),
                  ),
                ),
                itemSpace(),
                itemSpace(),
                itemSpace(),
                const AppLineSpace(
                  height: 10,
                ),
                itemSpace(),
                itemTitle(R.assetsSvgBag, LocaleKeys.order.tr),
                itemSpace(),
                itemContent(controller.model.name ?? '', "x${controller.qty}"),
                line(context),
                itemSpace(),
                itemContent(LocaleKeys.payment.tr,
                    getTotalPrice() * int.parse(controller.qty)),
                line(context),
                itemSpace(),
                itemContent(
                    LocaleKeys.method_payment.tr, LocaleKeys.vnpay_wallet.tr),
                line(context),
                itemSpace(),
                itemContent(LocaleKeys.trading_code.tr,
                    controller.paymentInfoModel.data ?? ""),
                const AppLineSpace(
                  height: 10,
                ),
                itemSpace(),
                itemTitle(R.assetsSvgPerson2, LocaleKeys.buyer.tr),
                itemSpace(),
                line(context),
                itemSpace(),
                itemContent(LocaleKeys.full_name.tr, controller.receiver),
                line(context),
                itemSpace(),
                itemContent(LocaleKeys.phone_number.tr, controller.phoneNumber),
                itemSpace(),
                itemSpace(),
                Padding(
                  padding: EdgeInsets.only(
                      left: contentPadding, right: contentPadding),
                  child: AppButton(
                    onPress: () => controller.onClickMain(),
                    title: LocaleKeys.main.tr,
                    height: heightContinue,
                    textStyle: typoButton.copyWith(color: colorBlack),
                    width: MediaQuery.of(context).size.width,
                    shapeBorder: RoundedRectangleBorder(
                        side: const BorderSide(color: colorGreen55),
                        borderRadius: BorderRadius.circular(17)),
                  ),
                ),
                itemSpace(),
                Padding(
                  padding: EdgeInsets.only(
                      left: contentPadding, right: contentPadding),
                  child: AppButton(
                    onPress: () => controller.onClickMyCombo(),
                    backgroundColor: colorGreen40,
                    title: LocaleKeys.my_promotion.tr,
                    textStyle: typoButton.copyWith(color: colorWhite),
                    height: heightContinue,
                    width: MediaQuery.of(context).size.width,
                    shapeBorder: RoundedRectangleBorder(
                        side: const BorderSide(color: colorGreen55),
                        borderRadius: BorderRadius.circular(17)),
                  ),
                )
              ],
            ),
          ),
        ),
        onWillPop: () async => controller.interceptor(context));
  }

  String getPrice() =>
      "${Utils.formatMoney(((controller.model.getFree ?? 1) * 45000 + int.parse(controller.model.price!)) * int.parse(controller.qty))}đ";

  String getTotalPrice() =>
      "${Utils.formatMoney((int.parse(controller.model.price ?? '')) * int.parse(controller.qty))}đ";

  Widget itemSpace() => const SizedBox(
        height: 10,
      );

  Widget line(BuildContext context) => Container(
        margin: EdgeInsets.only(left: contentPadding, right: contentPadding),
        height: 0.1,
        color: colorBlack,
        width: MediaQuery.of(context).size.width,
      );

  Widget itemTitle(String icon, String title) => Padding(
        padding: EdgeInsets.only(left: contentPadding, right: contentPadding),
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

  Widget itemContent(String title, String content) => Padding(
        padding: EdgeInsets.only(
            left: contentPadding, right: contentPadding, bottom: 10),
        child: Row(
          children: [
            AppText(
              title,
              style: typoSuperSmallText500,
            ),
            Expanded(
                child: AppText(
              content,
              style: typoSuperSmallText500,
              textAlign: TextAlign.end,
              maxLine: 1,
            ))
          ],
        ),
      );
}
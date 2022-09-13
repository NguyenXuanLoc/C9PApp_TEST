import 'package:c9p/app/utils/app_utils.dart';
import 'package:c9p/app/utils/tag_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';

import '../../../components/app_button.dart';
import '../../../components/app_line_space.dart';
import '../../../components/app_scalford.dart';
import '../../../components/app_text.dart';
import '../../../config/app_translation.dart';
import '../../../config/globals.dart';
import '../../../config/resource.dart';
import '../../../theme/app_styles.dart';
import '../../../theme/colors.dart';

class BuyXuSuccessView extends StatelessWidget {
  var controller = TagUtils().findBuyXuSuccessController();
  @override
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
                    LocaleKeys.payment_success.tr,
                    style: typoMediumText700,
                  ),
                ),
                Center(
                  child: AppText(
                    "${LocaleKeys.you_have_just_successfully_recharged.tr}  ${Utils.formatXu(controller!.totalXuRecived)} ${LocaleKeys.com9p_xu.tr}",
                    style: typoSuperSmallText500.copyWith(
                        fontSize: 12.sp, color: colorText40),
                  ),
                ),
                itemSpace(),
                itemSpace(),
                const AppLineSpace(),
                itemSpace(),
                itemTitle(R.assetsSvgBag, LocaleKeys.order.tr),
                itemSpace(),
                itemContent(controller!.model.data?.description,
                    "${Utils.formatXu(controller!.totalXuRecived)} ${LocaleKeys.xu.tr}"),
                line(context),
                itemSpace(),
                itemContent(LocaleKeys.payment.tr,
                    '${Utils.formatMoney(controller!.model.data?.amount ?? 0)}đ'),
                line(context),
                itemSpace(),
                itemContent(
                    LocaleKeys.method_payment.tr, LocaleKeys.vnpay_wallet.tr),
                line(context),
                itemSpace(),
                itemContent(LocaleKeys.trading_code.tr,
                    controller!.model.data?.id.toString() ?? ""),
                const AppLineSpace(
                  height: 10,
                ),
                itemSpace(),
                itemTitle(R.assetsSvgPerson2, LocaleKeys.buyer.tr),
                itemSpace(),
                itemContent(LocaleKeys.full_name.tr,
                    controller!.model.data?.buyerName ?? ''),
                line(context),
                itemSpace(),
                itemContent(LocaleKeys.phone_number.tr,
                    controller!.model.data?.buyerPhone ?? ''),
                itemSpace(),
                Padding(
                  padding: EdgeInsets.only(
                      left: contentPadding, right: contentPadding),
                  child: AppButton(
                    onPress: () => controller!.mainOnclick(),
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
                    onPress: () =>controller!.yourXuOnclick(),
                    backgroundColor: colorGreen40,
                    title: LocaleKeys.your_xu.tr,
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
        onWillPop: () async => controller!.interceptor(context));
  }


  Widget itemSpace() => SizedBox(
        height: 11.h,
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                flex: 6,
                child: AppText(
                  title,
                  style: typoSuperSmallText500,
                )),
            Expanded(
                flex: 4,
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

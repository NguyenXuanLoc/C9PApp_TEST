import 'package:c9p/app/components/app_button.dart';
import 'package:c9p/app/components/app_scalford.dart';
import 'package:c9p/app/extension/string_extension.dart';
import 'package:c9p/app/utils/tag_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';

import '../../../components/app_text.dart';
import '../../../config/app_translation.dart';
import '../../../config/globals.dart';
import '../../../config/resource.dart';
import '../../../theme/app_styles.dart';
import '../../../theme/colors.dart';
import '../../../utils/app_utils.dart';
import '../../confirm_rice_order/controllers/confirm_rice_order_controller.dart';

class ConfirmOrderView extends StatelessWidget {
  var controller = TagUtils().findConfirmBuyComboController();
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      fullStatusBar: true,
      isTabToHideKeyBoard: true,
      appbar: AppBar(
        leading: Padding(
          padding: EdgeInsets.only(left: contentPadding),
          child: InkWell(
            child: SvgPicture.asset(
              R.assetsBackSvg,
              color: colorWhite,
            ),
            onTap: () => Get.back(),
          ),
        ),
        leadingWidth: 28.w,
        automaticallyImplyLeading: true,
        centerTitle: true,
        title: AppText(
          LocaleKeys.confirm_order.tr,
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
      body: Column(
        children: [
          itemSpace(),
          itemTitle(R.assetsSvgBag, LocaleKeys.order.tr),
          itemSpace(),
          itemSpace(),
          itemContent(controller!.model.name ?? '', 'x${controller!.qty}'),
          line(context),
          itemSpace(),
          itemContent(LocaleKeys.bowl_of_rice.tr.toCapitalized(),
              '${((controller!.model.discount ?? 0) + (controller!.model.getFree ?? 0)) * int.parse(controller!.qty)} ${LocaleKeys.slot.tr}'),
          line(context),
          itemSpace(),
          itemContent(
              LocaleKeys.received.tr.toCapitalized(), controller!.receiver),
          Container(
            height: 10,
            color: colorSeparatorListView,
          ),
          itemSpace(),
          itemTitle(R.assetsSvgCoin, LocaleKeys.payment.tr.toCapitalized()),
          itemSpace(),
          itemSpace(),
          itemContent(LocaleKeys.price.tr, getPrice()),
          line(context),
          itemSpace(),
          itemContent(LocaleKeys.promotion.tr,
              "${(Utils.formatMoney(((controller!.model.getFree ?? 1) * ricePrice) * int.parse(controller!.qty)))}đ"),
          line(context),
          itemSpace(),
          itemContent(LocaleKeys.total_price.tr, getTotalPrice()),
          const Spacer(),
          paymentButton(context),
          itemSpace()
        ],
      ),
    );
  }

  Widget paymentButton(BuildContext context) => Container(
        padding: EdgeInsets.all(contentPadding),
        decoration: BoxDecoration(
            color: colorWhite,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                spreadRadius: 0.2,
                blurRadius: 0.5,
                offset: const Offset(0, -1), // changes position of shadow
              ),
            ],
            borderRadius: const BorderRadius.only(
                topRight: Radius.circular(17), topLeft: Radius.circular(17))),
        child: Column(
          children: [
            Row(
              children: [
                SvgPicture.asset(
                  R.assetsSvgCoin,
                  width: 15.w,
                ),
                const SizedBox(
                  width: 7,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: colorBackgroundGrey2,
                      borderRadius: BorderRadius.circular(20)),
                  child: Row(
                    children: [
                      InkWell(
                        child: Container(
                          decoration: BoxDecoration(
                              color: colorOrange40,
                              borderRadius: BorderRadius.circular(20)),
                          padding: const EdgeInsets.only(
                              left: 10, right: 5, top: 2, bottom: 2),
                          child: Row(
                            children: [
                              Obx(() => AppText(
                                    controller!.currentMethodPayment.value ==
                                            MethodPayment.VNPAY
                                        ? LocaleKeys.vn_pay.tr
                                        : LocaleKeys.C9P_xu.tr,
                                    style: typoSuperSmallText600.copyWith(
                                        color: colorWhite),
                                  )),
                              Icon(
                                Icons.keyboard_arrow_down_rounded,
                                color: colorWhite,
                                size: 13.w,
                              )
                            ],
                          ),
                        ),
                        onTap: () => showMethodPaymentWidget(context),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      AppText(
                        getPrice(),
                        style: typoSuperSmallText600.copyWith(
                            fontSize: 9.sp,
                            decoration: TextDecoration.lineThrough),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      AppText(
                        getTotalPrice(),
                        style: typoSuperSmallText600.copyWith(fontSize: 11.sp),
                      ),
                      const SizedBox(
                        width: 10,
                      )
                    ],
                  ),
                ),
                const Spacer(),
                AppText(
                  controller!.model.saleId ?? '',
                  style: typoSuperSmallText500,
                )
              ],
            ),
            itemSpace(),
            itemSpace(),
            AppButton(
              height: heightContinue,
              onPress: () => controller!.paymentOnClick(context),
              title: LocaleKeys.payment.tr.toCapitalized(),
              textStyle: typoButton.copyWith(color: colorWhite),
              backgroundColor: colorGreen40,
              width: MediaQuery.of(context).size.width,
              shapeBorder:
                  shapeBorderButton /*RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(17))*/
              ,
            )
          ],
        ),
      );

  Widget itemSpace() =>  SizedBox(
        height: 11.h,
      );

  String getPrice() =>
      "${Utils.formatMoney(((controller!.model.getFree ?? 1) * ricePrice + int.parse(controller!.model.price!)) * int.parse(controller!.qty))}đ";

  String getTotalPrice() =>
      "${Utils.formatMoney((int.parse(controller!.model.price ?? '')) * int.parse(controller!.qty))}đ";

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

  void showMethodPaymentWidget(BuildContext context) {
    showModalBottomSheet<void>(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (BuildContext context) {
          return Wrap(
            children: [
              Container(
                padding: EdgeInsets.only(
                  top: 15.h,
                ),
                decoration: const BoxDecoration(color: colorWhite),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Stack(
                        children: [
                          Container(
                            alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width,
                            child: AppText(
                              LocaleKeys.method_payment.tr,
                              style: typoSuperSmallText600.copyWith(
                                  fontSize: 14.sp),
                            ),
                          ),
                          Positioned.fill(
                            child: Container(
                              alignment: Alignment.centerLeft,
                              padding: EdgeInsets.only(left: contentPadding),
                              child: InkWell(
                                child: SvgPicture.asset(R.assetsBackSvg),
                                onTap: () => Navigator.pop(context),
                              ),
                            ),
                          )
                        ],
                      ),
                      itemSpace(),
                      Container(
                        height: 0.1,
                        color: colorBlack,
                        width: MediaQuery.of(context).size.width,
                      ),
                      itemPaymentDialog(
                          R.assetsPngVnpay,
                          LocaleKeys.vn_pay.tr.toUpperCase(),
                          true,
                          () => controller!.changeMethodPayment(
                              context, MethodPayment.VNPAY),
                          MethodPayment.VNPAY),
                      Container(
                        height: 0.1,
                        color: colorBlack,
                        width: MediaQuery.of(context).size.width,
                      ),
                      itemPaymentBuyXu(context),
                      itemSpace()
                    ],
                  ),
                ),
              )
            ],
          );
        });
  }

  Widget itemPaymentBuyXu(BuildContext context) => Padding(
        padding: EdgeInsets.only(
            left: contentPadding,
            right: contentPadding,
            top: contentPadding - 1,
            bottom: contentPadding - 1),
        child: InkWell(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                R.assetsPngXu,
                width: 20.w,
                fit: BoxFit.cover,
              ),
              const SizedBox(
                width: 15,
              ),
              AppText(
                ((controller!.xuModel.value.balance ?? 0) >=
                        controller!.getTotalPrice())
                    ? ('${LocaleKeys.number_coins.tr} ${Utils.formatMoney(controller!.xuModel.value.balance ?? 0)} ${LocaleKeys.xu.tr}')
                    : LocaleKeys.xu_not_enough.tr,
                style: typoSuperSmallTextRegular,
              ),
              const Spacer(),
              Visibility(
                visible: ((controller!.xuModel.value.balance ?? 0) <
                    controller!.getTotalPrice()),
                child: InkWell(
                  child: Row(
                    children: [
                      AppText(
                        LocaleKeys.load_cents.tr,
                        style: typoSuperSmallTextRegular.copyWith(
                            color: colorBlue65),
                      ),
                      Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 10.w,
                      )
                    ],
                  ),
                  onTap: () => controller!.loadCoinOnClick(context),
                ),
              ),
              (((controller!.xuModel.value.balance ?? 0) >=
                          controller!.getTotalPrice()) &&
                      controller!.currentMethodPayment.value ==
                          MethodPayment.XU)
                  ? Image.asset(
                      R.assetsPngLikeGreen,
                      width: 17.w,
                    )
                  : SizedBox()
            ],
          ),
          onTap: () =>
              controller!.changeMethodPayment(context, MethodPayment.XU),
        ),
      );

  Widget itemPaymentDialog(String icon, String title, bool isSelect,
          VoidCallback callBack, MethodPayment methodPayment) =>
      Padding(
        padding: EdgeInsets.only(
            left: contentPadding,
            right: contentPadding,
            top: contentPadding - 1,
            bottom: contentPadding - 1),
        child: InkWell(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                icon,
                width: 20.w,
                fit: BoxFit.cover,
              ),
              const SizedBox(
                width: 15,
              ),
              AppText(
                title,
                style: typoSuperSmallTextRegular,
              ),
              const Spacer(),
              methodPayment == controller!.currentMethodPayment.value
                  ? Image.asset(
                      R.assetsPngLikeGreen,
                      width: 17.w,
                    )
                  : const SizedBox()
              /* Icon(
                Icons.check,
                color: methodPayment == controller!.currentMethodPayment
                    ? colorGreen55
                    : Colors.transparent,
                size: 17.w,
              )*/
            ],
          ),
          onTap: () => callBack.call(),
        ),
      );
}

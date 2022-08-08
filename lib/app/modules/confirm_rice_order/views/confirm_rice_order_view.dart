import 'package:c9p/app/components/app_line_space.dart';
import 'package:c9p/app/data/model/weather_model.dart';
import 'package:c9p/app/extension/string_extension.dart';
import 'package:c9p/app/utils/app_utils.dart';
import 'package:c9p/app/utils/log_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:simple_tooltip/simple_tooltip.dart';

import '../../../components/app_button.dart';
import '../../../components/app_scalford.dart';
import '../../../components/app_text.dart';
import '../../../config/app_translation.dart';
import '../../../config/globals.dart';
import '../../../config/resource.dart';
import '../../../theme/app_styles.dart';
import '../../../theme/colors.dart';
import '../controllers/confirm_rice_order_controller.dart';

class ConfirmRiceOrderView extends GetView<ConfirmRiceOrderController> {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      fullStatusBar: true,
      isTabToHideKeyBoard: false,
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
          Expanded(
              child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(contentPadding),
                  child: Row(
                    children: [
                      Image.asset(
                        R.assetsPngDeliveryMan,
                        width: 20.w,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppText(
                            LocaleKeys.delivery_to.tr,
                            style: typoSuperSmallText500.copyWith(
                                color: colorText40),
                          ),
                          AppText(
                            controller.model.address,
                            style: typoMediumText700,
                          ),
                          AppText(
                            LocaleKeys.add_note.tr,
                            style: typoSuperSmallText500.copyWith(
                                color: colorText40, fontSize: 12.sp),
                          )
                        ],
                      ))
                    ],
                  ),
                ),
                AppLineSpace(),
                itemSpace(),
                itemTitle(R.assetsSvgBag, LocaleKeys.order.tr),
                itemContent(
                    LocaleKeys.com_suon_ngon.tr, "x${controller.model.qty}"),
                line(context),
                itemContent(LocaleKeys.time_rice_receive.tr,
                    '${Utils.convertTimeToDDMMYY(controller.model.deliverDate).replaceAll('-', '/')} - ${controller.model.deliverHour}'),
                Visibility(
                  visible: controller.model.myComboModel != null,
                  child: line(context),
                ),
                Visibility(
                  visible: controller.model.myComboModel != null,
                  child: itemContent(LocaleKeys.name_package_promotion.tr,
                      controller.model.myComboModel?.sale?.name ?? ''),
                ),
                Visibility(
                  visible: controller.model.myComboModel != null,
                  child: line(context),
                ),
                Visibility(
                  visible: controller.model.myComboModel != null,
                  child: itemContent(LocaleKeys.slot_remain.tr,
                      "${(controller.model.myComboModel?.remainsCombo ?? 0) - int.parse(controller.model.qty)}"),
                ),
                line(context),
                itemContent(LocaleKeys.receiver.tr, controller.model.name),
                const AppLineSpace(),
                itemSpace(),
                itemTitle(R.assetsSvgCoin, LocaleKeys.payment.tr),
                itemContent(LocaleKeys.price.tr,
                    "${Utils.formatMoney(controller.getPrice())}đ"),
                line(context),
                itemContent(LocaleKeys.ship_price.tr,
                    "${Utils.formatMoney(shipPrice)}đ"),
                line(context),
                itemContent(LocaleKeys.promotion.tr,
                    "${Utils.formatMoney(controller.getPromotion())}đ"),
                line(context),
                itemContent(LocaleKeys.total_price.tr,
                    "${Utils.formatMoney(controller.getTotalPrice())}đ"),
                itemSpace(),
                Container(
                  padding: EdgeInsets.only(left: contentPadding),
                  alignment: Alignment.centerLeft,
                  child: Visibility(
                    visible: controller.model.myComboModel != null,
                    child: Container(
                      width: MediaQuery.of(context).size.width -
                          MediaQuery.of(context).size.width / 3,
                      height: 56.h,
                      alignment: Alignment.centerLeft,
                      child: Stack(
                        children: [
                          SvgPicture.asset(
                            R.assetsSvgBackGroundMyCombo,
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                left: contentPadding, right: contentPadding),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 8,
                                  child: Container(
                                    alignment: Alignment.centerLeft,
                                    padding: const EdgeInsets.only(
                                        left: 5, right: 5),
                                    child: AppText(
                                      "${controller.model.myComboModel?.sale?.saleId ?? ''}\n${(controller.model.myComboModel?.sale?.name ?? '')}",
                                      style: typoSuperSmallText700.copyWith(
                                          color: colorText0, fontSize: 11.sp),
                                      textAlign: TextAlign.start,
                                      maxLine: 3,
                                      textOverflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: AppText(
                                      LocaleKeys.cancel.tr,
                                      style: typoSuperSmallText700.copyWith(
                                          color: colorText0, fontSize: 14.sp),
                                      textOverflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )),
          paymentButton(context)
        ],
      ),
    );
  }

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
                      Container(
                        decoration: BoxDecoration(
                            color: colorOrange40,
                            borderRadius: BorderRadius.circular(20)),
                        padding: const EdgeInsets.only(
                            left: 10, right: 5, top: 2, bottom: 2),
                        child: Row(
                          children: [
                            Obx(() => InkWell(
                                  child: AppText(
                                    controller.isPaymentByCash.value
                                        ? LocaleKeys.cash.tr
                                        : LocaleKeys.vn_pay.tr,
                                    style: typoSuperSmallText600.copyWith(
                                        color: colorText0),
                                  ),
                                  onTap: () => showMethodPaymentWidget(context),
                                )),
                            Icon(
                              Icons.keyboard_arrow_down_rounded,
                              color: colorWhite,
                              size: 13.w,
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      AppText(
                        "${Utils.formatMoney(controller.getTotalPrice())}đ",
                        style: typoSuperSmallText600.copyWith(fontSize: 11.sp),
                      ),
                      const SizedBox(
                        width: 10,
                      )
                    ],
                  ),
                ),
                const Spacer(),
              ],
            ),
            itemSpace(),
            itemSpace(),
            AppButton(
              height: heightContinue,
              onPress: () => controller.paymentOnclick(context),
              title: LocaleKeys.payment.tr.toCapitalized(),
              textStyle: typoSuperSmallText600.copyWith(
                  fontSize: 16.sp, color: colorWhite),
              backgroundColor: colorGreen40,
              width: MediaQuery.of(context).size.width,
              shapeBorder: shapeBorderButton,
            )
          ],
        ),
      );

  Widget itemPaymentDialog(
          String icon, String title, bool isSelect, VoidCallback callBack) =>
      Padding(
        padding: EdgeInsets.only(
            left: contentPadding, right: contentPadding, top: 7, bottom: 7),
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
                style: typoSuperSmallText600,
              ),
              Spacer(),
              Icon(
                Icons.check,
                color: isSelect ? colorGreen55 : Colors.transparent,
                size: 17.w,
              )
            ],
          ),
          onTap: () => callBack.call(),
        ),
      );

  void showMethodPaymentWidget(BuildContext context) {
    showModalBottomSheet<void>(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (BuildContext context) {
          return Container(
            padding: EdgeInsets.only(
              top: 15.h,
            ),
            decoration: const BoxDecoration(
                color: colorWhite,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10),
                    topLeft: Radius.circular(10))),
            height: 140.h,
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
                          style: typoSmallText700.copyWith(fontSize: 14.sp),
                        ),
                      ),
                      Positioned.fill(
                        child: Container(
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(left: contentPadding),
                          child: InkWell(
                            child: Icon(Icons.arrow_back),
                            onTap: () => Navigator.pop(context),
                          ),
                        ),
                      )
                    ],
                  ),itemSpace(),
                  Container(
                    height: 0.1,
                    color: colorBlack,
                    width: MediaQuery.of(context).size.width,
                  ),
                  itemPaymentDialog(
                      R.assetsPngVnpay,
                      LocaleKeys.vn_pay.tr.toUpperCase(),
                      !controller.isPaymentByCash.value,
                      () => controller.changeMethodPayment(context)),
                  line(context),
                  itemPaymentDialog(
                      R.assetsPngDola,
                      LocaleKeys.cash.tr.toCapitalized(),
                      controller.isPaymentByCash.value,
                      () => controller.changeMethodPayment(context)),
                  itemSpace()
                ],
              ),
            ),
          );
        });
  }

  Widget itemContent(String title, String content) => Padding(
        padding: EdgeInsets.only(
            left: contentPadding, right: contentPadding, bottom: 10, top: 10),
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

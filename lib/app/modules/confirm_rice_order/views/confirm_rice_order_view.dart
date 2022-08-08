import 'package:c9p/app/components/app_line_space.dart';
import 'package:c9p/app/data/model/weather_model.dart';
import 'package:c9p/app/extension/string_extension.dart';
import 'package:c9p/app/utils/app_utils.dart';
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
                itemContent(LocaleKeys.price.tr,
                    controller.model.myComboModel != null ? '0đ' : '1'),
                line(context),
                itemContent(
                    LocaleKeys.ship_price.tr, "${Utils.formatMoney(10000)}đ"),
                line(context),
                itemContent(LocaleKeys.promotion.tr,
                    controller.model.myComboModel != null ? '0đ' : '1'),
                line(context),
                itemContent(
                    LocaleKeys.total_price.tr, "${Utils.formatMoney(10000)}đ"),
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
                SimpleTooltip(
                  tooltipTap: () {
                    print("Tooltip tap");
                  },
                  animationDuration: Duration(seconds: 3),
                  show: true,
                  tooltipDirection: TooltipDirection.up,
                  child: Container(
                    width: 200,
                    height: 120,
                    child: Placeholder(),
                  ),
                  content: Text(
                    "Some text example!!!!",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      decoration: TextDecoration.none,
                    ),
                  ),
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
                            Obx(() => Tooltip(
                                triggerMode: TooltipTriggerMode.tap,
                                verticalOffset: 10.h,
                                preferBelow: false,
                                message: !controller.isPaymentByCash.value
                                    ? LocaleKeys.cash.tr
                                    : LocaleKeys.vn_pay.tr,
                                showDuration: const Duration(seconds: 10),
                                waitDuration: const Duration(seconds: 0),
                                textStyle: typoSuperSmallText600.copyWith(
                                  color: colorText0,
                                ),
                                child: AppText(
                                  controller.isPaymentByCash.value
                                      ? LocaleKeys.cash.tr
                                      : LocaleKeys.vn_pay.tr,
                                  style: typoSuperSmallText600.copyWith(
                                      color: colorWhite),
                                ))),
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
              ],
            ),
            itemSpace(),
            itemSpace(),
            AppButton(
              height: heightContinue,
              onPress: () {},
              title: LocaleKeys.payment.tr.toCapitalized(),
              textStyle: typoSuperSmallText600.copyWith(
                  fontSize: 16.sp, color: colorWhite),
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

  String getPrice() => "${Utils.formatMoney((10))}đ";

  String getTotalPrice() => "${Utils.formatMoney(10000)}đ";

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

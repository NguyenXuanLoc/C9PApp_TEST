import 'package:c9p/app/components/app_line_space.dart';
import 'package:c9p/app/components/app_text_field.dart';
import 'package:c9p/app/data/model/xu_model.dart';
import 'package:c9p/app/extension/string_extension.dart';
import 'package:c9p/app/utils/app_utils.dart';
import 'package:c9p/app/utils/tag_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';

import '../../../components/app_button.dart';
import '../../../components/app_scalford.dart';
import '../../../components/app_text.dart';
import '../../../config/app_translation.dart';
import '../../../config/globals.dart';
import '../../../config/resource.dart';
import '../../../theme/app_styles.dart';
import '../../../theme/colors.dart';
import '../controllers/confirm_rice_order_controller.dart';

class ConfirmRiceOrderView extends StatelessWidget {
  var controller = TagUtils().findConfirmRiceOrderController();

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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 5.h),
                            child: Image.asset(
                              R.assetsPngDeliveryMan,
                              width: 20.w,
                            ),
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
                                    controller!.model.address,
                                    style: typoMediumText700,
                                  ),
                                  InkWell(
                                    child: Obx(() =>
                                        AppText(
                                          controller!.description.value.isEmpty
                                              ? LocaleKeys.add_note.tr
                                              : "${LocaleKeys.note
                                              .tr}: ${controller!.description
                                              .value}",
                                          style: typoSuperSmallText500.copyWith(
                                              color: colorText40,
                                              fontSize: 12.sp),
                                        )),
                                    onTap: () => showNoteDialog(context),
                                  )
                                ],
                              ))
                        ],
                      ),
                    ),
                    const AppLineSpace(),
                    itemSpace(),
                    itemTitle(R.assetsSvgBag, LocaleKeys.order.tr),
                    itemContent(
                        LocaleKeys.com_suon_ngon.tr,
                        "x${controller!.model.qty}"),
                    line(context),
                    itemContent(LocaleKeys.time_rice_receive.tr,
                        '${Utils.convertTimeToDDMMYY(
                            controller!.model.deliverDate).replaceAll(
                            '-', '/')} - ${controller!.model.deliverHour}'),
                    Visibility(
                      visible: controller!.model.myComboModel != null,
                      child: line(context),
                    ),
                    Visibility(
                      visible: controller!.model.myComboModel != null,
                      child: itemContent(LocaleKeys.name_package_promotion.tr,
                          controller!.model.myComboModel?.sale?.name ?? ''),
                    ),
                    Visibility(
                      visible: controller!.model.myComboModel != null,
                      child: line(context),
                    ),
                    Visibility(
                      visible: controller!.model.myComboModel != null,
                      child: itemContent(LocaleKeys.slot_remain.tr,
                          "${(controller!.model.myComboModel?.remainsCombo ??
                              0) - int.parse(controller!.model.qty)}"),
                    ),
                    line(context),
                    itemContent(LocaleKeys.receiver.tr, controller!.model.name),
                    const AppLineSpace(),
                    itemSpace(),
                    itemTitle(R.assetsSvgCoin, LocaleKeys.payment.tr),
                    itemContent(LocaleKeys.price.tr,
                        "${Utils.formatMoney(controller!.getPrice())}??"),
                    line(context),
                    itemContent(LocaleKeys.ship_price.tr,
                        "${Utils.formatMoney(shipPrice)}??"),
                    line(context),
                    itemContent(LocaleKeys.promotion.tr,
                        "${Utils.formatMoney(controller!.getPromotion())}??"),
                    line(context),
                    itemContent(LocaleKeys.total_price.tr,
                        "${Utils.formatMoney(controller!.getTotalPrice())}??"),
                    itemSpace(),
                    Container(
                      padding: EdgeInsets.only(left: contentPadding),
                      alignment: Alignment.centerLeft,
                      child: Visibility(
                        visible: controller!.model.myComboModel != null,
                        child: Container(
                          width: MediaQuery
                              .of(context)
                              .size
                              .width -
                              MediaQuery
                                  .of(context)
                                  .size
                                  .width / 3,
                          height: 56.h,
                          alignment: Alignment.centerLeft,
                          child: Stack(
                            children: [
                              SvgPicture.asset(
                                R.assetsSvgBackGroundMyCombo,
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    left: contentPadding,
                                    right: contentPadding),
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
                                          "${controller!.model.myComboModel
                                              ?.sale?.saleId ??
                                              ''}\n${(controller!.model
                                              .myComboModel?.sale?.name ??
                                              '')}",
                                          style: typoSuperSmallText700.copyWith(
                                              color: colorText0,
                                              fontSize: 11.sp),
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
                                              color: colorText0,
                                              fontSize: 14.sp),
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
                const SizedBox(
                  height: 20,
                ),
              ],
                ),
              )),
          paymentButton(context)
        ],
      ),
    );
  }

  Widget itemSpace() =>
      SizedBox(
        height: 11.h,
      );

  Widget line(BuildContext context) =>
      Container(
        margin: EdgeInsets.only(left: contentPadding, right: contentPadding),
        height: 0.1,
        color: colorBlack,
        width: MediaQuery
            .of(context)
            .size
            .width,
      );

  Widget itemTitle(String icon, String title) =>
      Padding(
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

  Widget paymentButton(BuildContext context) =>
      Container(
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
                            Obx(() =>
                                InkWell(
                                  child: AppText(
                                    controller!.currentMethodPayment.value ==
                                            MethodPayment.CASH
                                        ? LocaleKeys.cash.tr
                                        : (controller!.currentMethodPayment.value ==
                                                MethodPayment.VNPAY
                                            ? LocaleKeys.vn_pay.tr
                                            : LocaleKeys.C9P_xu.tr),
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
                        "${Utils.formatMoney(controller!.getTotalPrice())}??",
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
              onPress: () => controller!.paymentOnclick(context),
              title: LocaleKeys.payment.tr.toCapitalized(),
              textStyle: typoSuperSmallText600.copyWith(
                  fontSize: 16.sp, color: colorWhite),
              backgroundColor: colorGreen40,
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              shapeBorder: shapeBorderButton,
            )
          ],
        ),
      );
  Widget itemPaymentBuyXu(BuildContext context) =>
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
                    ? ('${LocaleKeys.number_coins.tr} ${Utils.formatMoney(
                            controller!.xuModel.value.balance ?? 0)} ${LocaleKeys.xu.tr}')
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
                        style:
                        typoSuperSmallTextRegular.copyWith(color: colorBlue65),
                      ),
                      Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 10.w,
                      )
                    ],
                  ),
                  onTap: () => controller!.loadCoinOnClick(),
                ),
              ),
              (((controller!.xuModel.value.balance ?? 0) >=
                          controller!.getTotalPrice()) &&
                      controller!.currentMethodPayment.value == MethodPayment.XU)
                  ? Image.asset(
                      R.assetsPngLikeGreen,
                      width: 17.w,
                    )
                  : SizedBox()

            ],
          ),
          onTap: ()=>controller!.changeMethodPayment(context, MethodPayment.XU),
        ),
      );
  Widget itemPaymentDialog(String icon, String title, bool isSelect,
      VoidCallback callBack,MethodPayment methodPayment) =>
      Padding(
        padding: EdgeInsets.only(
            left: contentPadding, right: contentPadding, top: contentPadding-1, bottom: contentPadding-1),
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
                            width: MediaQuery
                                .of(context)
                                .size
                                .width,
                            child: AppText(
                              LocaleKeys.method_payment.tr,
                              style: typoSuperSmallText600.copyWith(fontSize: 14.sp),
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
                        width: MediaQuery
                            .of(context)
                            .size
                            .width,
                      ),
                      itemPaymentDialog(
                          R.assetsPngVnpay,
                          LocaleKeys.vn_pay.tr.toUpperCase(),
                          !controller!.isPaymentByCash.value,
                              () => controller!.changeMethodPayment(context,   MethodPayment.VNPAY),
                          MethodPayment.VNPAY),
                      Container(
                        height: 0.1,
                        color: colorBlack,
                        width: MediaQuery
                            .of(context)
                            .size
                            .width,
                      ),
                      itemPaymentDialog(
                          R.assetsPngMoneyBag,
                          LocaleKeys.cash.tr.toCapitalized(),
                          controller!.isPaymentByCash.value,
                          () => controller!
                              .changeMethodPayment(context, MethodPayment.CASH),
                          MethodPayment.CASH),
                      Container(
                        height: 0.1,
                        color: colorBlack,
                        width: MediaQuery
                            .of(context)
                            .size
                            .width,
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

  Widget itemContent(String title, String content) =>
      Padding(
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


  void showNoteDialog(BuildContext context) async {
    await showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        builder: (ctx) {
          return Container(
            // padding: const EdgeInsets.all(30),
            decoration: const BoxDecoration(
                color: colorWhite,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15))),
            width: MediaQuery
                .of(context)
                .size
                .width,
            child: Container(
              height: MediaQuery
                  .of(context)
                  .size
                  .height,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(contentPadding),
                    color: colorBackgroundGrey10,
                    child: Row(
                      children: [
                        InkWell(
                          child: AppText(
                            LocaleKeys.cancel.tr,
                            style: typoSmallTextBold,
                          ),
                          onTap: () => controller!.cancelDescriptionDialog(),
                        ),
                        Expanded(
                            child: AppText(
                              LocaleKeys.add_note_.tr,
                              style: typoSmallText700,
                              textAlign: TextAlign.center,
                            )),
                        InkWell(
                          child: AppText(LocaleKeys.finish.tr,
                              style: typoSmallTextBold.copyWith(
                                  color: colorSemanticRed100)),
                          onTap: () => controller!.finishDescriptionDialog(),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                    child: AppTextField(
                      onChanged: (text) => controller!.counterChange(text),
                      controller: controller!.descriptionController,
                      autofocus: true,
                      maxLine: 3,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(100),
                      ],
                      // maxLength: 100,
                      textStyle: typoSuperSmallText500,
                      decoration: decorTextField.copyWith(
                          hintText: 'Vui l??ng ????? l???i ghi ch??',
                          hintStyle: typoSuperSmallText500.copyWith(
                              color: colorText40),
                          border: InputBorder.none,
                          errorBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none),
                    ),
                  ),
                  Obx(() =>
                      Container(
                        alignment: Alignment.centerRight,
                        padding: EdgeInsets.only(right: contentPadding),
                        child: AppText(
                          "${controller!.noteCounter.value}/100",
                          style: typoSuperSmallText600.copyWith(
                              color: colorText40),
                        ),
                      ))
                ],
              ),
            ),
          );
        });
  }
}

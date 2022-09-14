import 'package:c9p/app/components/app_button.dart';
import 'package:c9p/app/components/app_scalford.dart';
import 'package:c9p/app/components/app_text.dart';
import 'package:c9p/app/config/app_translation.dart';
import 'package:c9p/app/config/globals.dart';
import 'package:c9p/app/config/resource.dart';
import 'package:c9p/app/theme/app_styles.dart';
import 'package:c9p/app/theme/colors.dart';
import 'package:c9p/app/utils/app_utils.dart';
import 'package:c9p/app/utils/log_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../components/app_line_space.dart';
import '../../../components/rate_bar_indicator.dart';
import '../../../config/constant.dart';
import '../../../utils/tag_utils.dart';

class DetailOrderView extends StatelessWidget {
  var controller = TagUtils().findDetailOrderController();

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        body: Stack(
      children: [
        SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          AspectRatio(
            aspectRatio: 1 / 0.8,
            child: Image.asset(
              R.assetsPngBackgroundOrderDetail,
              fit: BoxFit.fitWidth,
            ),
          ),
          const AppLineSpace(),
          Padding(
            padding: EdgeInsets.all(contentPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  LocaleKeys.com_suong_9p.tr,
                  style:
                      typoLargeTextBold.copyWith(fontWeight: FontWeight.w700),
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Obx(() => AppText(
                        "${Utils.formatMoney(controller?.orderModer.value.amount ?? 0)}đ",
                        style: typoMediumTextBold.copyWith(
                            color: colorSemanticRed100,
                            fontWeight: FontWeight.w700))),
                    const SizedBox(
                      width: 20,
                    ),
                    Container(padding: EdgeInsets.only(left: 10,right: 10,top: 2,bottom: 2),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: colorOrange40.withOpacity(0.25),
                      ),
                      child: AppText(
                        '${LocaleKeys.ship_price.tr} ${Utils.formatMoney(controller?.orderModer.value.shippingFee ?? 0)}đ',
                        style: typoSuperSmallText500.copyWith(
                            color: colorOrange50),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                        child: Obx(() => AppText(
                              '${LocaleKeys.code.tr} #${controller?.orderModer.value.id} / ${controller?.orderModer.value.itemQty} ${LocaleKeys.bowl_of_rice.tr}',
                              style: typoSuperSmallText500.copyWith(
                                  color: colorGreen60),
                            ))),
                    const SizedBox(
                      width: 20,
                    ),
                    Row(
                      children: [
                        SvgPicture.asset(R.assetsSvgMoto),
                        SizedBox(
                          width: 5,
                        ),
                        Obx(() => AppText(
                              Utils.getOrderStatus(
                                  controller?.orderModer.value.status ?? ''),
                              style: typoSuperSmallText500.copyWith(
                                  color: colorOrange80),
                            ))
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Obx(() => Visibility(
                    visible: controller?.orderModer.value.description != null
                        ? true
                        : false,
                    child: Obx(() => AppText(
                          controller?.orderModer.value.description ?? '',
                          style: typoExtraSmallTextBold.copyWith(
                              color: const Color(0xff999977)),
                        )))),
              ],
            ),
          ),
          const AppLineSpace(),
          paddingWidget(
            children: [
              titleWidget(R.assetsSvgWatch, LocaleKeys.time.tr),
              const SizedBox(
                height: 10,
              ),
              Obx(() => AppText(
                    "${LocaleKeys.order_time.tr} : ${Utils.convertTimeToDDMMYYHHMMSS(controller?.orderModer.value.createdTime ?? DateTime.now())}",
                    style: typoSuperSmallText500.copyWith(color: colorText70),
                  )),
              const SizedBox(
                height: 6,
              ),
              Obx(() => AppText(
                    "${LocaleKeys.delivery_time.tr} : ${Utils.convertTimeToDDMMYYHHMMSS(controller?.orderModer.value.deliverTime ?? DateTime.now())}",
                    style: typoSuperSmallText500.copyWith(color: colorText70),
                  )),
            ],
          ),
          const AppLineSpace(),
          paddingWidget(
            children: [
              titleWidget(
                R.assetsSvgLocation,
                LocaleKeys.address_order.tr,
              ),
              const SizedBox(
                height: 10,
              ),
              Obx(() => AppText(
                    controller?.orderModer.value.toAddress ?? '',
                    style: typoSuperSmallText500.copyWith(color: colorText70),
                  )),
            ],
          ),
          const AppLineSpace(),
                  paddingWidget(
                    children: [
                      titleWidget(
                        R.assetsSvgLocation,
                        LocaleKeys.method_payment.tr,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
              Obx(() => AppText(
                    getMethodPayment(),
                    style: typoSuperSmallText500.copyWith(color: colorText70),
                  )),
            ],
          ),
          const AppLineSpace(),
          Obx(() => Visibility(
                visible: controller?.orderModer.value.shipperName == null
                    ? false
                    : true,
                child: paddingWidget(children: [
                  titleWidget(R.assetsPngMotoBike, LocaleKeys.shipper.tr,
                      isSvg: false),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Obx(() => AppText(
                            "${controller?.orderModer.value.shipperName ?? ''}  ${controller?.orderModer.value.shipperRate}",
                            style: typoSuperSmallText500.copyWith(
                                color: colorText70),
                          )),
                      SvgPicture.asset(
                        R.assetsSvgStar,
                        height: 10,
                        fit: BoxFit.cover,
                      )
                    ],
                  ),
                ]),
              )),
          Padding(
            padding: EdgeInsets.all(contentPadding),
            child: AppButton(
              textStyle: typoButton.copyWith(color: colorText0),
              title: LocaleKeys.re_order.tr,
              onPress: () => controller?.reOrderOnclick(),
              width: MediaQuery.of(context).size.width,
              backgroundColor: colorGreen50,
              height: heightContinue,
              shapeBorder: shapeBorderButton,
            ),
          ),
        ])),
        Padding(
          padding: EdgeInsets.only(left: contentPadding, top: 10.h),
          child: Container(
            padding: EdgeInsets.all(2.w),
            decoration: BoxDecoration(
                color: colorGrey10, borderRadius: BorderRadius.circular(100)),
            child: IconButton(
                splashRadius: 20,
                constraints: BoxConstraints(maxHeight: 30.w, maxWidth: 30.w),
                padding: const EdgeInsets.all(0),
                onPressed: () => Get.back(),
                icon: SvgPicture.asset(R.assetsBackSvg)),
          ),
        )
      ],
    ));
  }

  Widget titleWidget(String assetImage, String title, {bool isSvg = true}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        isSvg
            ? SvgPicture.asset(
                assetImage,
                // width: 17.w,
                fit: BoxFit.cover,
              )
            : Image.asset(
                assetImage,
                width: 17.w,
                fit: BoxFit.cover,
              ),
        const SizedBox(
          width: 10,
        ),
        AppText(
          title,
          style: typoSuperSmallText600.copyWith(fontSize: 13.sp),
        )
      ],
    );
  }

  Widget paddingWidget({required List<Widget> children}) {
    return Padding(
      padding: EdgeInsets.all(contentPadding),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    );
  }
  String getMethodPayment() {
    if (controller?.orderModer.value.paymentType == null) return LocaleKeys.cash.tr;
    switch (controller?.orderModer.value.paymentType) {
      case MessageKey.VNPay:
        return LocaleKeys.vn_pay.tr;
      case MessageKey.COD:
        return LocaleKeys.cash.tr;
      case MessageKey.XU:
        return LocaleKeys.C9P_xu.tr;
    }
    return LocaleKeys.cash.tr;
  }
}

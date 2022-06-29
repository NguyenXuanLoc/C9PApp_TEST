import 'package:c9p/app/components/app_button.dart';
import 'package:c9p/app/components/app_scalford.dart';
import 'package:c9p/app/components/app_text.dart';
import 'package:c9p/app/config/app_translation.dart';
import 'package:c9p/app/config/globals.dart';
import 'package:c9p/app/config/resource.dart';
import 'package:c9p/app/theme/app_styles.dart';
import 'package:c9p/app/theme/colors.dart';
import 'package:c9p/app/utils/app_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../components/app_line_space.dart';
import '../../../components/rate_bar_indicator.dart';
import '../controllers/detail_order_controller.dart';

class DetailOrderView extends GetView<DetailOrderController> {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        body: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Stack(
        children: [
          AspectRatio(
            aspectRatio: 1 / 0.8,
            child: Image.asset(
              R.assetsPngBackgroundOrderDetail,
              fit: BoxFit.fitWidth,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: contentPadding, top: 10.h),
            child: SizedBox(
              width: 20.w,
              child: IconButton(
                  splashRadius: 20,
                  padding: const EdgeInsets.all(0),
                  onPressed: () => Get.back(),
                  icon: SvgPicture.asset(R.assetsBackSvg)),
            ),
          ),
        ],
      ),
      const AppLineSpace(),
      Padding(
        padding: EdgeInsets.all(contentPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText(
              LocaleKeys.com_suong_9p.tr,
              style: typoLargeTextBold.copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              children: [
                AppText(
                    "${Utils.formatMoney(controller.orderModer.value.codAmount ?? 0)}đ",
                    style: typoMediumTextBold.copyWith(
                        color: colorSemanticRed100,
                        fontWeight: FontWeight.w700)),
                const SizedBox(
                  width: 20,
                ),
                RatingBarIndicator(
                  rating: 5,
                  itemBuilder: (context, index) => const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  itemCount: 5,
                  itemSize: 18,
                  unratedWidget: const Icon(
                    Icons.star,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            AppText(
              '${LocaleKeys.code.tr} #${controller.orderModer.value.id} / ${controller.orderModer.value.itemQty} ${LocaleKeys.bowl_of_rice.tr}',
              style: typoSuperSmallTextBold.copyWith(color: colorGreen60),
            ),
            const SizedBox(
              height: 10,
            ),
            Visibility(
                visible: controller.orderModer.value.description != null
                    ? true
                    : false,
                child: AppText(
                  controller.orderModer.value.description ?? '',
                  style: typoExtraSmallTextBold.copyWith(color: colorText70),
                )),
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
          AppText(
            "${LocaleKeys.order_time.tr} : ${Utils.convertTimeToDDMMYYHHMMSS(controller.orderModer.value.createdTime ?? DateTime.now())}",
            style: typoExtraSmallTextBold.copyWith(color: colorText70),
          ),
          const SizedBox(
            height: 6,
          ),
          AppText(
            "${LocaleKeys.delivery_time.tr} : ${Utils.convertTimeToDDMMYYHHMMSS(controller.orderModer.value.deliverTime ?? DateTime.now())}",
            style: typoExtraSmallTextBold.copyWith(color: colorText70),
          ),
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
          AppText(
            controller.orderModer.value.toAddress ?? '',
            style: typoExtraSmallTextBold.copyWith(color: colorText70),
          ),
        ],
      ),
      /*paddingWidget(children: [
        titleWidget(R.assetsPngMotoBike, LocaleKeys.shipper.tr, isSvg: false),
        const SizedBox(
          height: 10,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AppText(
              "Hoang Tuan Vu 5",
              style: typoExtraSmallTextBold.copyWith(color: colorText70),
            ),
            SvgPicture.asset(
              R.assetsSvgStar,
              height: 10,
              fit: BoxFit.cover,
            )
          ],
        )
      ]),*/
      Padding(
        padding: EdgeInsets.all(contentPadding),
        child: AppButton(
          textStyle: typoSmallTextBold.copyWith(
              color: colorText0, fontWeight: FontWeight.w700),
          title: LocaleKeys.re_order.tr,
          onPress: () => controller.reOrderOnclick(),
          width: MediaQuery.of(context).size.width,
          backgroundColor: colorGreen50,
          height: 40.h,
          shapeBorder:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
        ),
      )
    ])));
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
          style: typoSuperSmallTextBold.copyWith(fontWeight: FontWeight.w700),
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
}

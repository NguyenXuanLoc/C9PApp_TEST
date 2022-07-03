import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';

import '../../../components/app_button.dart';
import '../../../components/app_scalford.dart';
import '../../../components/app_text.dart';
import '../../../config/app_translation.dart';
import '../../../config/resource.dart';
import '../../../theme/app_styles.dart';
import '../../../theme/colors.dart';
import '../controllers/order_success_controller.dart';

class OrderSuccessView extends GetView<OrderSuccessController> {
  const OrderSuccessView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.init();
    return AppScaffold(
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
              style: typoMediumTextBold.copyWith(fontWeight: FontWeight.w800),
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
              style: typoSuperSmallTextBold.copyWith(
                  color: colorText60, fontSize: 12.sp),
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          AppButton(
            onPress: () => controller.mainOnclick(),
            title: LocaleKeys.main.tr,
            backgroundColor: colorGrey15,
            shapeBorder: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(13.w)),
            textStyle: typoSmallTextBold.copyWith(color: colorText60),
            width: MediaQuery.of(context).size.width,
          ),
          const SizedBox(
            height: 10,
          ),
          AppButton(
            onPress: () => controller.followOrderOnclick(),
            title: LocaleKeys.follow_order.tr,
            backgroundColor: colorGreen55,
            shapeBorder: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(13.w)),
            textStyle: typoSmallTextBold.copyWith(color: colorText0),
            width: MediaQuery.of(context).size.width,
          ),
          const Spacer(),
          const Spacer(),
        ],
      ),
    );
  }
}

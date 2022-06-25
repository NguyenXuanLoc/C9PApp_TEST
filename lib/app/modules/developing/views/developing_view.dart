import 'package:c9p/app/components/app_button.dart';
import 'package:c9p/app/components/app_scalford.dart';
import 'package:c9p/app/config/globals.dart';
import 'package:c9p/app/theme/app_styles.dart';
import 'package:c9p/app/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';

import '../../../components/app_text.dart';
import '../../../config/app_translation.dart';
import '../../../config/resource.dart';
import '../controllers/developing_controller.dart';

class DevelopingView extends GetView<DevelopingController> {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      padding: EdgeInsets.all(15.w),
      appbar: AppBar(
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
      body: Column(
        children: [
          const Spacer(),
          Image.asset(R.assetsPngDeveloping),
          AppText(
            LocaleKeys.developing.tr,
            textAlign: TextAlign.center,
            style: typoSuperSmallTextBold.copyWith(
                color: colorText60, fontSize: 12.sp),
          ),
          const SizedBox(
            height: 50,
          ),
          AppButton(
            onPress: () => controller.reOrderOnclick(),
            title: LocaleKeys.reorder_rice.tr,
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

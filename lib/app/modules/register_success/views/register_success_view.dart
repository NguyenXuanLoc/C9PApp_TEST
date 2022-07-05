import 'package:flutter/material.dart';
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
import '../controllers/register_success_controller.dart';

class RegisterSuccessView extends GetView<RegisterSuccessController> {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      padding: EdgeInsets.all(15.w),
      body: Column(
        children: [
          const Spacer(),
          SvgPicture.asset(R.assetsSvgRegisterSuccess),
          const SizedBox(
            height: 40,
          ),
          Padding(
            padding: EdgeInsets.only(left: 15.w, right: 15.w),
            child: AppText(
              LocaleKeys.register_success.tr,
              textAlign: TextAlign.center,
              style: typoMediumTextBold.copyWith(fontWeight: FontWeight.w800),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: EdgeInsets.only(left: 15.w, right: 15.w),
            child: AppText(
              LocaleKeys.message_register_success.tr,
              textAlign: TextAlign.center,
              style: typoSuperSmallTextBold.copyWith(
                  color: colorText60, fontSize: 12.sp),
            ),
          ),
          const Spacer(),
          AppButton(
            height: heightContinue,
            onPress: () => controller.onClickContinues(),
            title: LocaleKeys.continues.tr,
            backgroundColor: colorGreen55,
            shapeBorder: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(13.w)),
            textStyle: typoButton.copyWith(color: colorText0),
            width: MediaQuery.of(context).size.width,
          ),
          const SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }
}

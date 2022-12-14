import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:otp_text_field/style.dart';

import '../../../components/app_button.dart';
import '../../../components/app_scalford.dart';
import '../../../components/app_text.dart';
import '../../../components/otp_widget.dart';
import '../../../config/app_translation.dart';
import '../../../config/globals.dart';
import '../../../config/resource.dart';
import '../../../theme/app_styles.dart';
import '../../../theme/colors.dart';
import '../controllers/register_pin_controller.dart';

class RegisterPinView extends GetView<RegisterPinController> {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(isTabToHideKeyBoard: true,
        padding: EdgeInsets.all(contentPadding),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
        const SizedBox(
          height: 20,
        ),
        AppText(
          LocaleKeys.create_pin.tr,
          style: typoLargeTextBold.copyWith(fontWeight: FontWeight.w700),
        ),
        const SizedBox(
          height: 10,
        ),
        AppText(
          LocaleKeys.please_update_pin_to_login.tr,
          style: typoSuperSmallTextRegular.copyWith(
              color: colorText40, fontSize: 12.sp),
        ),
        const SizedBox(
          height: 40,
        ),
        Padding(
          padding: EdgeInsets.only(left: 30.w, right: 30.w),
          child: OTPTextField(cursorColor: colorGreen57,
                controller: controller.otpController,
                hintText: '',
            boxDecoration: BoxDecoration(
              borderRadius: BorderRadius.circular(7),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  spreadRadius: 0.5,
                  blurRadius: 0.5,
                  offset: const Offset(0, 0.2), // changes position of shadow
                ),
              ],
            ),
            length: 4,contentPadding:const EdgeInsets.all(0),
            width: MediaQuery
                .of(context)
                .size
                .width,onChanged: (pin)=>controller.setPin(pin),
            fieldWidth: 42.w,
            textAlign: TextAlign.center,
            style: typoLargeTextBold600.copyWith(color: colorGreen57),
            textFieldAlignment: MainAxisAlignment.spaceAround,
          ),
        ),
        SizedBox(
          height: 1.h,
        ),
        SizedBox(
          height: 100.h,
        ),
        Obx(() =>
            AppButton(
                height: heightContinue,
                title: LocaleKeys.continues.tr,
                textStyle: typoButton.copyWith(
                    color:  controller.pin.value.length == 4
                ? colorText0
                    : colorText60),
                shapeBorder: shapeBorderButton,
                  onPress: () => controller.onClickContinue(),
                  width: MediaQuery
              .of(context)
              .size
              .width,
          backgroundColor:  controller.pin.value.length == 4
          ? colorGreen50
          : colorGrey10,
        )),]
    ,
    )
    );
  }
}

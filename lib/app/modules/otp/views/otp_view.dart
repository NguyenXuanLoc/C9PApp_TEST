import 'package:c9p/app/components/app_button.dart';
import 'package:c9p/app/components/app_scalford.dart';
import 'package:c9p/app/components/app_text.dart';
import 'package:c9p/app/components/app_text_field.dart';
import 'package:c9p/app/config/app_translation.dart';
import 'package:c9p/app/theme/app_styles.dart';
import 'package:c9p/app/theme/colors.dart';
import 'package:c9p/app/utils/app_utils.dart';
import 'package:c9p/app/utils/log_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../components/otp_text_field_widget.dart';
import '../../../components/otp_widget.dart';
import '../../../components/pin_code/builder/color_builder.dart';
import '../../../components/pin_code/cursor/pin_cursor.dart';
import '../../../components/pin_code/decoration/decoration_boxloose.dart';
import '../../../config/globals.dart';
import '../../../config/resource.dart';
import '../controllers/otp_controller.dart';

class OtpView extends GetView<OtpController> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Utils.hideKeyboard(context),
      child: AppScaffold(
          // padding: EdgeInsets.all(contentPadding),
          body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: contentPadding),
            child: SizedBox(
              width: 20.w,
              child: IconButton(
                  splashRadius: 20,
                  padding: const EdgeInsets.all(0),
                  onPressed: () => Get.back(),
                  icon: SvgPicture.asset(R.assetsBackSvg)),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: EdgeInsets.only(left: contentPadding),
            child: AppText(
              LocaleKeys.send_otp.tr,
              style: typoLargeTextBold.copyWith(fontWeight: FontWeight.w700),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: EdgeInsets.only(left: contentPadding),
            child: AppText(
              "${LocaleKeys.otp_sent.tr} ${controller.phoneNumber.value}, ${LocaleKeys.ban_vui_long_kiem_tra_tin_nhan.tr}",
              style: typoSuperSmallTextRegular.copyWith(
                  color: colorText40, fontSize: 12.sp),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: EdgeInsets.only(left: contentPadding),
            child: RichText(
                text: TextSpan(
                    text: LocaleKeys.otp.tr,
                    style: typoSmallTextBold,
                    children: [
                  TextSpan(
                      text: '*',
                      style: typoSmallTextBold.copyWith(
                          color: colorSemanticRed100))
                ])),
          ),
          SizedBox(
            height: 1.h,
          ),
          SizedBox(
            height: 20,
          ),
          Stack(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
              ),
              Container(
                width: 200.w,padding: EdgeInsets.only(left: 4.w),
                child: OtpTextFieldWidget(
                  focusNode: controller.focusNode,
                  cursor: Cursor(
                    width: 2,
                  height: 18.h,
                  color: colorGreen57,
                  enabled: true,
                  ),
                  height: 30.h,
                  width: 5,
                  pinLength: 6,
                  pinDecoration: BoxLooseDecoration(
                    hintText: '******',
                    hintTextStyle: typoSmallTextRegular.copyWith(
                        color: colorText100, fontSize: 14.sp),
                    strokeWidth: 1.2,
                    gapSpace: 2.w,
                    strokeColorBuilder: PinListenColorBuilder(
                        Colors.black.withOpacity(0.00),
                        Colors.black.withOpacity(0.00)),
                    textStyle: typoMediumTextBold,
                  ),
                  padding: const EdgeInsets.all(0),
                  onSubmit: (String text) => controller.setPin(text,context),
                  onChanged: (String text) => controller.setPin(text,context),
                  controller: controller.otpController1,
                ),
              ),
              Positioned.fill(
                  child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  margin: EdgeInsets.only(
                      left: contentPadding, right: contentPadding),
                  height: 1,
                  width: MediaQuery.of(context).size.width,
                  color: colorUnderlineTextField,
                ),
              )),
              Positioned.fill(
                  child: Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: EdgeInsets.only(top: 5.h,right: contentPadding),
                        child: Obx(
                          () => controller.startCountDown.value == 0
                              ? InkWell(
                                  onTap: () =>
                                      controller.startTimer(isVerify: true),
                                  child: AppText(
                                    LocaleKeys.resent_otp.tr,
                                    style: typoSuperSmallTextBold.copyWith(
                                        color: colorSemanticRed100),
                                  ))
                              : AppText(
                                  controller.timeDisplay.value,
                                  style: typoSuperSmallTextBold.copyWith(
                                      color: colorSemanticRed100),
                                ),
                        ),
                      ))),
            ],
          ),
          SizedBox(
            height: 1.h,
          ),
          Obx(() => AppText(
                controller.errorOtp.value,
                style: typoSuperSmallTextRegular.copyWith(
                    color: colorSemanticRed100),
              )),
          SizedBox(
            height: 50.h,
          ),
          Obx(() => Padding(
                padding: EdgeInsets.only(
                    left: contentPadding, right: contentPadding),
                child: AppButton(
                  height: heightContinue,
                  title: LocaleKeys.continues.tr,
                  textStyle: typoButton.copyWith(
                      color: controller.pin.value.length == 6
                          ? colorText0
                          : colorText60),
                  shapeBorder: shapeBorderButton,
                  onPress: () => controller.confirm(context),
                  width: MediaQuery.of(context).size.width,
                  backgroundColor: controller.pin.value.length == 6
                      ? colorGreen50
                      : colorGrey10,
                ),
              )),
        ],
      )),
    );
  }
}

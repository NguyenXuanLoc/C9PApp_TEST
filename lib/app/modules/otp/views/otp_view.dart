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

import '../../../components/otp_widget.dart';
import '../../../config/globals.dart';
import '../../../config/resource.dart';
import '../controllers/otp_controller.dart';

class OtpView extends GetView<OtpController> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Utils.hideKeyboard(context),
      child: AppScaffold(
          padding: EdgeInsets.all(contentPadding),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: 20.w,
                child: IconButton(
                    splashRadius: 20,
                    padding: const EdgeInsets.all(0),
                    onPressed: () => Get.back(),
                    icon: SvgPicture.asset(R.assetsBackSvg)),
              ),
              const SizedBox(
                height: 20,
              ),
              AppText(
                LocaleKeys.send_otp.tr,
                style: typoLargeTextBold.copyWith(fontWeight: FontWeight.w700),
              ),
              const SizedBox(
                height: 10,
              ),
              AppText(
                "${LocaleKeys.otp_sent.tr} ${controller.phoneNumber.value}, ${LocaleKeys.ban_vui_long_kiem_tra_tin_nhan.tr}",
                style: typoSuperSmallTextRegular.copyWith(
                    color: colorText40, fontSize: 12.sp),
              ),
              const SizedBox(
                height: 20,
              ),
              RichText(
                  text: TextSpan(
                      text: LocaleKeys.otp.tr,
                      style: typoSmallTextBold,
                      children: [
                    TextSpan(
                        text: '*',
                        style: typoSmallTextBold.copyWith(
                            color: colorSemanticRed100))
                  ])),
              Stack(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                  ),
                  OTPTextField(
                    onChanged: (pin) => controller.setPin(pin),
                    controller: controller.otpController,
                    length: 6,
                    width: 300.w,
                    spaceBetween: 6,
                    style: typoMediumTextBold,
                    textFieldAlignment: MainAxisAlignment.start,
                    contentPadding: EdgeInsets.only(top: 10.h),
                  ),
                  Positioned.fill(
                      child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: 1,
                      width: MediaQuery.of(context).size.width,
                      color: colorUnderlineTextField,
                    ),
                  )),
                  Positioned.fill(
                      child: Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: EdgeInsets.only(top: 10.h),
                            child: Obx(
                              () =>controller.startCountDown.value==0 ?InkWell(
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
              ),SizedBox(height: 1.h,),
              Obx(() => AppText(
                    controller.errorOtp.value,
                    style: typoSuperSmallTextRegular.copyWith(
                        color: colorSemanticRed100),
                  )),
              SizedBox(
                height: 50.h,
              ),
              Obx(() => AppButton(
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
                  )),
              Visibility(
                visible: false,
                child: Center(
                  child: Obx(() => Visibility(
                        visible: controller.startCountDown.value == 0,
                        child: TextButton(
                            style: ButtonStyle(
                                padding: MaterialStateProperty.all(
                                    const EdgeInsets.all(0))),
                            onPressed: () =>
                                controller.startTimer(isVerify: true),
                            child: AppText(
                              LocaleKeys.resent_otp.tr,
                              style: typoSmallTextBold.copyWith(
                                  decoration: TextDecoration.underline,
                                  color: colorGreen50),
                            )),
                      )),
                ),
              )
            ],
          )),
    );
  }
}

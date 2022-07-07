import 'package:c9p/app/components/app_button.dart';
import 'package:c9p/app/components/app_scalford.dart';
import 'package:c9p/app/components/app_text.dart';
import 'package:c9p/app/components/app_text_field.dart';
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

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: AppScaffold(
          padding: EdgeInsets.all(contentPadding),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
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
                LocaleKeys.welcome_to_com_9_p.tr,
                style: typoLargeTextBold.copyWith(fontWeight: FontWeight.w700),
              ),
              const SizedBox(
                height: 10,
              ),
              AppText(
                LocaleKeys.input_phone_number_to_order_c9p.tr,
                style: typoSuperSmallTextRegular.copyWith(
                    color: colorText40, fontSize: 12.sp),
              ),
              const SizedBox(
                height: 30,
              ),
              RichText(
                  text: TextSpan(
                      text: LocaleKeys.phone_number.tr,
                      style: typoSuperSmallTextBold,
                      children: [
                    TextSpan(
                        text: '*',
                        style: typoSuperSmallTextBold.copyWith(
                            color: colorSemanticRed100))
                  ])),
              SizedBox(
                height: 12.h,
              ),
              SizedBox(
                height: 95.h,
                child: Stack(
                  children: [
                    Obx(
                      () => AppTextField(
                        autofocus: true,
                        controller: controller.phoneController,
                        onChanged: (text) => controller.checkValid(),
                        errorText: controller.errorPhone.value,
                        keyboardType: TextInputType.phone,
                        textStyle: typoSuperSmallTextBold,
                        decoration: InputDecoration(
                          contentPadding:
                              EdgeInsets.only(left: 50.w, bottom: 6.h),
                          hintStyle: typoSuperSmallTextBold.copyWith(
                              color: colorText40),
                          hintText: LocaleKeys.phone_number_of_you.tr,
                          border:
                              UnderlineInputBorder(borderSide: borderSize()),
                          focusedBorder:
                              UnderlineInputBorder(borderSide: borderSize()),
                          focusedErrorBorder: const UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: colorSemanticRed100)),
                          errorBorder:
                              UnderlineInputBorder(borderSide: borderSize()),
                          enabledBorder:
                              UnderlineInputBorder(borderSide: borderSize()),
                          enabled: true,
                          isDense: true,
                          prefixIconConstraints:
                              BoxConstraints(maxHeight: 15.h),
                        ),
                        hintStyle:
                            typoSuperSmallTextBold.copyWith(color: colorText40),
                        hintText: LocaleKeys.phone_number_of_you.tr,
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min, // <-- important
                      children: [
                        Image.asset(
                          R.assetsVnPng,
                          width: 20.w,
                        ),
                        const SizedBox(width: 4), // add a small gap
                        AppText(
                          "+84 ",
                          style: typoSuperSmallTextBold.copyWith(),
                        )
                      ],
                    )
                  ],
                ),
              ),
              Obx(() => AppButton(
                    height: heightContinue,
                    title: LocaleKeys.continues.tr,
                    textStyle: typoButton.copyWith(
                        color: controller.isValid.value
                            ? colorText0
                            : colorText60),
                    borderRadius: 200,
                    onPress: () => controller.openOtp(),
                    width: MediaQuery.of(context).size.width,
                    backgroundColor:
                        controller.isValid.value ? colorGreen50 : colorGrey10,
                  )),
            ],
          )),
      onTap: () => Utils.hideKeyboard(context),
    );
  }

  BorderSide borderSize() => BorderSide(
      color: controller.isPhoneChange.value
          ? colorSemanticRed100
          : colorUnderlineTextField);
}

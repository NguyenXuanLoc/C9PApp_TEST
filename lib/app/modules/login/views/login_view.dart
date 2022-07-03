import 'package:c9p/app/components/app_scalford.dart';
import 'package:c9p/app/components/app_text.dart';
import 'package:c9p/app/components/app_text_field.dart';
import 'package:c9p/app/config/app_translation.dart';
import 'package:c9p/app/config/globals.dart';
import 'package:c9p/app/theme/app_styles.dart';
import 'package:c9p/app/theme/colors.dart';
import 'package:c9p/app/utils/app_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:c9p/app/components/app_button.dart';

import 'package:get/get.dart';

import '../controllers/login_controller.dart';
import 'package:c9p/app/config/resource.dart';

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
                LocaleKeys.login.tr,
                style: typoLargeTextBold.copyWith(fontWeight: FontWeight.w700),
              ),
              const SizedBox(
                height: 10,
              ),
              AppText(
                LocaleKeys.login_by_phone_registed.tr,
                style: typoSuperSmallTextBold.copyWith(
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
                height: 95.h,
                child: Form(
                    key: controller.formKey,
                    child: TextFormField(
                      enabled: true,
                      controller: controller.phoneController,
                      onChanged: (c) =>
                          controller.formKey.currentState!.validate(),
                      autofocus: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          controller.setIsValid(false);
                          return LocaleKeys.please_input_phone_number.tr;
                        } else if (!Utils.validateMobile(value)) {
                          controller.setIsValid(false);
                          return LocaleKeys.phone_number_khong_hop_le.tr;
                        }
                        controller.setIsValid(true);
                        return null;
                      },
                      keyboardType: TextInputType.phone,
                      style: typoSuperSmallTextBold,
                      decoration: InputDecoration(
                        focusedErrorBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: colorSemanticRed100)),
                        errorBorder: const UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: colorUnderlineTextField)),
                        enabledBorder: const UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: colorUnderlineTextField)),
                        prefixText: '+84 ',
                        enabled: true,
                        isDense: true,
                        prefixStyle: typoSuperSmallTextBold.copyWith(),
                        suffixIconConstraints:
                            BoxConstraints(maxWidth: 30.w, maxHeight: 30.h),
                        prefixIconConstraints:
                            BoxConstraints(maxWidth: 25.w, maxHeight: 30.h),
                        prefixIcon: Container(
                          padding: EdgeInsets.only(top: 12.h),
                          alignment: Alignment.centerLeft,
                          child: Image.asset(
                            R.assetsVnPng,
                          ),
                        ),
                        border: const UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: colorUnderlineTextField)),
                        focusedBorder: const UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: colorUnderlineTextField),
                        ),
                        hintStyle:
                            typoSuperSmallTextBold.copyWith(color: colorText40),
                        hintText: LocaleKeys.phone_number_of_you.tr,
                        contentPadding: EdgeInsets.only(
                            top: 15.h, bottom: 2.h, left: 0, right: 0),
                      ),
                    )),
              ),
              Obx(() => AppButton(
                    title: LocaleKeys.continues.tr,
                    textStyle: typoButton.copyWith(
                        color: controller.isValid.value
                            ? colorText0
                            : colorText60),
                    borderRadius: 200,
                    onPress: () => controller.openOtp(),
                    width: MediaQuery.of(context).size.width,
                    backgroundColor: controller.isValid.value ? colorGreen50 :colorGrey10,
                  )),
            ],
          )),
      onTap: () => Utils.hideKeyboard(context),
    );
  }
}

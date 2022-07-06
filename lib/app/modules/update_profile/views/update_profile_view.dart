import 'package:c9p/app/components/app_button.dart';
import 'package:c9p/app/components/app_scalford.dart';
import 'package:c9p/app/config/globals.dart';
import 'package:c9p/app/utils/log_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';

import '../../../components/app_circle_image.dart';
import '../../../components/app_text.dart';
import '../../../components/app_text_field.dart';
import '../../../config/app_translation.dart';
import '../../../config/resource.dart';
import '../../../theme/app_styles.dart';
import '../../../theme/colors.dart';
import '../controllers/update_profile_controller.dart';

class UpdateProfileView extends GetView<UpdateProfileController> {
  const UpdateProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        isTabToHideKeyBoard: true,
        padding: EdgeInsets.all(contentPadding),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /*SizedBox(
              width: 20.w,
              child: IconButton(
                  splashRadius: 20,
                  padding: const EdgeInsets.all(0),
                  onPressed: () => Get.back(),
                  icon: SvgPicture.asset(R.assetsBackSvg)),
            ),*/
            const SizedBox(
              height: 20,
            ),
            AppText(
              LocaleKeys.register_now.tr,
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
                    text: LocaleKeys.name.tr,
                    style: typoSuperSmallTextBold,
                    children: [
                  TextSpan(
                      text: '*',
                      style: typoSuperSmallTextBold.copyWith(
                          color: colorSemanticRed100))
                ])),
            itemSpace(),
            Obx(() => AppTextField(
                  onChanged: (text) => controller.setDisableButton(text),
                  controller: controller.fullNameController,
                  errorText: controller.errorFullName.value,
                  textInputAction: TextInputAction.next,
                  textStyle:
                      typoSuperSmallTextBold.copyWith(),
                  decoration: decoration().copyWith(
                    hintText: LocaleKeys.full_name.tr,
                    hintStyle:
                        typoSuperSmallTextBold.copyWith(color: colorText60),
                  ),
                )),
            AppText(
              LocaleKeys.phone_number.tr,
              style: typoSuperSmallTextBold,
            ),
            itemSpace(),
            AppTextField(
              controller: controller.phoneController,
              readOnly: true,
              textInputAction: TextInputAction.next,
              textStyle: typoSuperSmallTextBold.copyWith(),
              decoration: decoration(),
            ),
            const Spacer(),
            Obx(() => AppButton(
                  disable: controller.isDisableButton.value,
                  onPress: () => controller.updateProfile(context),
                  title: LocaleKeys.continues.tr,
                  textStyle: typoButton.copyWith(
                      color: controller.isDisableButton.value
                          ? colorText60
                          : colorText0),
                  width: MediaQuery.of(context).size.width,
                  height: heightContinue,
                  borderRadius: 17,
                  backgroundColor: controller.isDisableButton.value
                      ? colorGrey10
                      : colorGreen50,
                )),
            const SizedBox(
              height: 30,
            )
          ],
        ));
  }

  InputDecoration decoration() => decorTextFieldOval.copyWith(
      contentPadding: EdgeInsets.only(bottom: 5.h),
      border: const UnderlineInputBorder(
          borderSide: BorderSide(color: colorUnderlineTextField)),
      disabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: colorUnderlineTextField)),
      focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: colorUnderlineTextField)),
      errorBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: colorUnderlineTextField)),
      enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: colorUnderlineTextField)));

  Widget itemSpace() =>  SizedBox(
        height: 5.h,
      );
}

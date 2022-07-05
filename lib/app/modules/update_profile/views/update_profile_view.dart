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
        fullStatusBar: true,
        isTabToHideKeyBoard: true,
        appbar: AppBar(
          leading: Obx(() => Visibility(
              visible: controller.isBackToHome.value,
              child: SizedBox(
                width: 20.w,
                child: IconButton(
                    splashRadius: 20,
                    padding: const EdgeInsets.all(0),
                    onPressed: () => Get.back(),
                    icon: SvgPicture.asset(
                      R.assetsBackSvg,
                      color: colorWhite,
                    )),
              ))),
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: AppText(
            LocaleKeys.account.tr,
            style: typoTitleHeader,
          ),
          flexibleSpace: Container(
            alignment: Alignment.bottomCenter,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(R.assetsBackgroundHeaderTabMainPng),
                    fit: BoxFit.fitWidth)),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(contentPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20,
              ),
              AppText(
                LocaleKeys.full_name.tr,
                style: typoSuperSmallTextBold,
              ),
              itemSpace(),
              Obx(() => AppTextField(
                    onChanged: (text) => controller.setDisableButton(text),
                    controller: controller.fullNameController,
                    errorText: controller.errorFullName.value,
                    textInputAction: TextInputAction.next,
                    textStyle:
                        typoSuperSmallTextBold.copyWith(color: colorText60),
                    decoration: decorTextFieldOval,
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
                textStyle: typoSuperSmallTextBold.copyWith(color: colorText60),
                decoration: decorTextFieldOval,
              ),
              const Spacer(),
              Obx(() => AppButton(
                    disable: controller.isDisableButton.value,
                    onPress: () => controller.updateProfile(context),
                    title: LocaleKeys.update.tr,
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
          ),
        ));
  }
  Widget itemSpace() => const SizedBox(
        height: 10,
      );
}

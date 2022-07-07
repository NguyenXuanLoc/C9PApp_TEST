import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';

import '../../../components/app_button.dart';
import '../../../components/app_scalford.dart';
import '../../../components/app_text.dart';
import '../../../components/app_text_field.dart';
import '../../../config/app_translation.dart';
import '../../../config/globals.dart';
import '../../../config/resource.dart';
import '../../../theme/app_styles.dart';
import '../../../theme/colors.dart';
import '../controllers/tab_account_controller.dart';

class TabAccountView extends GetView<TabAccountController> {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        fullStatusBar: true,
        isTabToHideKeyBoard: true,
        appbar: AppBar(
          actions: [
            Obx(() => Visibility(
                  visible: controller.isSave.value,
                  child: TextButton(
                      onPressed: () => controller.updateProfile(context),
                      child: AppText(
                        LocaleKeys.save.tr,
                        style: typoSmallTextBold.copyWith(color: colorText0),
                      )),
                ))
          ],
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
              const SizedBox(
                height: 20,
              ),
              AppText(
                LocaleKeys.full_name.tr,
                style: typoSuperSmallTextBold,
              ),
              itemSpace(),
              Obx(() => AppTextField(
                    onChanged: (text) => controller.onFullNameChange(text),
                    controller: controller.fullNameController,
                    errorText: controller.errorFullName.value,
                    textInputAction: TextInputAction.next,
                    hintText: LocaleKeys.full_name.tr,
                    hintStyle:
                        typoSuperSmallTextBold.copyWith(color: colorText60),
                    textStyle: typoSuperSmallTextBold.copyWith(),
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
                textStyle: typoSuperSmallTextBold.copyWith(),
                decoration: decorTextFieldOval,
              ),
              const Spacer(),
              AppButton(
                onPress: () => controller.logout(context),
                title: LocaleKeys.logout.tr,
                textStyle: typoButton.copyWith(color: colorText60),
                width: MediaQuery.of(context).size.width,
                height: heightContinue,
                shapeBorder: shapeBorderButton,
                backgroundColor: colorGrey10,
              ),
              const SizedBox(
                height: 30,
              )
            ],
          ),
        ));
  }

  Widget itemSpace() => SizedBox(
        height: 5.h,
      );
}

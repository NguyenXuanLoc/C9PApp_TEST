import 'dart:io';

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
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        fullStatusBar: true,
        isTabToHideKeyBoard: true,
        body: Column(
          children: [
            Stack(
              children: [
                SizedBox(
                  height: 160.h,
                ),
                SizedBox(
                  height: 120.h,
                  width: MediaQuery.of(context).size.width,
                  child: Image.asset(R.assetsBackgroundHeaderTabMainPng,
                      fit: BoxFit.fitWidth),
                ),
                Positioned.fill(
                  top: MediaQuery.of(context).padding.top + 10.h,
                  left: contentPadding,
                  right: contentPadding,
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Row(
                      children: [
                        IconButton(
                          splashRadius: 20,
                          padding: const EdgeInsets.all(0),
                          constraints: const BoxConstraints(minWidth: 20),
                          icon: SvgPicture.asset(
                            R.assetsBackSvg,
                            color: colorWhite,
                            fit: BoxFit.cover,
                          ),
                          onPressed: () => Get.back(),
                        ),
                        const Spacer(),
                        AppText(
                          LocaleKeys.account.tr,
                          style: typoMediumTextBold.copyWith(
                              color: colorText0, fontWeight: FontWeight.w600),
                        ),
                        const Spacer(),
                        SvgPicture.asset(
                          R.assetsBackSvg,
                          color: Colors.transparent,
                          fit: BoxFit.cover,
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Stack(
                      children: [
                       Obx(() =>  AppCircleImage(
                         size: 90.w,
                         url:  controller.urlImage.value,
                         uri: controller.filePath.value,
                       )),
                        Positioned.fill(
                            child: Container(
                          // padding: const EdgeInsets.only(bottom: 10, left: 10),
                          alignment: Alignment.bottomRight,
                          child: InkWell(
                            onTap: () => controller.pickImage(context),
                            child: SvgPicture.asset(R.assetsSvgPen),
                          ),
                        ))
                      ],
                    ),
                  ),
                )
              ],
            ),
            Expanded(
                child: Padding(
              padding: EdgeInsets.all(contentPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    LocaleKeys.full_name.tr,
                    style: typoSuperSmallTextBold,
                  ),
                  Obx(() => AppTextField(
                        onChanged: (text) {},
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
                    onPress: () => controller.updateProfile(context),
                    title: LocaleKeys.save.tr,
                    textStyle: typoButton.copyWith(color: colorText0),
                    width: MediaQuery.of(context).size.width,
                    height: heightContinue,
                    shapeBorder: shapeBorderButton,
                    backgroundColor: colorGreen55,
                  ),
                ],
              ),
            ))
          ],
        ));
  }

  Widget sexWidget(bool isMale, String title) => Row(
        children: [
          InkWell(
            child: Container(
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(color: colorGrey40)),
              child: Container(
                height: 12,
                width: 12,
                decoration: BoxDecoration(
                    color: isMale ? colorGreen60 : colorWhite,
                    borderRadius: BorderRadius.circular(100)),
              ),
            ),
            onTap: () {} /*controller.changeSex()*/,
          ),
          const SizedBox(
            width: 10,
          ),
          AppText(
            title,
            style: typoSuperSmallTextBold.copyWith(color: colorText60),
          ),
        ],
      );

  void dialogPickImage(BuildContext context) async {
    await showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        builder: (ctx) {
          return Container(
            padding: const EdgeInsets.all(30),
            decoration: const BoxDecoration(
                color: colorWhite,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15))),
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Row(
                  children: [
                    Expanded(
                        child: Column(
                      children: [
                        InkWell(
                          child: SvgPicture.asset(
                            R.assetsSvgCamera,
                            color: colorBlackGrey,
                            width: 40,
                            height: 40,
                          ),
                          onTap: () {} /*=> controller.picImage(true)*/,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        AppText(
                          LocaleKeys.camera.tr,
                          style: typoSuperSmallTextBold.copyWith(
                            color: colorBlackGrey,
                          ),
                        )
                      ],
                    )),
                    Expanded(
                        child: Column(
                      children: [
                        InkWell(
                          child: SvgPicture.asset(
                            R.assetsSvgGallery,
                            color: colorBlackGrey,
                            width: 40,
                            height: 40,
                          ),
                          onTap: () {} /*=> controller.picImage(false)*/,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        AppText(LocaleKeys.gallery.tr,
                            style: typoSuperSmallTextBold.copyWith(
                              color: colorBlackGrey,
                            ))
                      ],
                    ))
                  ],
                )
              ],
            ),
          );
        });
  }

  Widget itemSpace() => const SizedBox(
        height: 10,
      );
}

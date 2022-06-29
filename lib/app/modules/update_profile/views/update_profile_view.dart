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
                    textStyle: typoSmallTextBold.copyWith(
                        color: controller.isDisableButton.value
                            ? colorText60
                            : colorText0),
                    width: MediaQuery.of(context).size.width,
                    height: 37.h,
                    borderRadius: 17,
                    backgroundColor: controller.isDisableButton.value
                        ? colorGrey10
                        : colorGreen60,
                  )),
              const SizedBox(
                height: 30,
              )
            ],
          ),
        ));
  }

  Widget oldWidget(BuildContext context) => Column(
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
                      Container(
                        decoration: BoxDecoration(
                          color: colorWarning10,
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(color: colorYellow100, width: 1),
                        ),
                        child: Obx(() => AppCircleImage(
                            uri: controller.imageUri.value,
                            size: 90.w,
                            url:
                                'https://vcdn-dulich.vnecdn.net/2020/09/04/1-Meo-chup-anh-dep-khi-di-bien-9310-1599219010.jpg',
                            urlError: '')),
                      ),
                      Positioned.fill(
                          child: Container(
                        // padding: const EdgeInsets.only(bottom: 10, left: 10),
                        alignment: Alignment.bottomRight,
                        child: InkWell(
                          onTap: () => dialogPickImage(context),
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
                itemSpace(),
                AppTextField(
                  textInputAction: TextInputAction.next,
                  textStyle:
                      typoSuperSmallTextBold.copyWith(color: colorText60),
                  decoration: decorTextFieldOval,
                ),
                AppText(
                  LocaleKeys.phone_number.tr,
                  style: typoSuperSmallTextBold,
                ),
                itemSpace(),
                AppTextField(
                  textInputAction: TextInputAction.next,
                  textStyle:
                      typoSuperSmallTextBold.copyWith(color: colorText60),
                  decoration: decorTextFieldOval,
                ),
                AppText(
                  LocaleKeys.sex.tr,
                  style: typoSuperSmallTextBold,
                ),
                itemSpace(),
                Container(
                  padding: EdgeInsets.only(left: 12.w),
                  height: 34.h,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      border: Border.all(color: colorGreen60),
                      borderRadius: BorderRadius.circular(17)),
                  child: Row(
                    children: [
                      Obx(() => sexWidget(
                          controller.isMale.value, LocaleKeys.male.tr)),
                      const SizedBox(
                        width: 30,
                      ),
                      Obx(() => sexWidget(
                          !controller.isMale.value, LocaleKeys.female.tr)),
                    ],
                  ),
                ),
                const Spacer(),
                AppButton(
                  onPress: () {},
                  title: LocaleKeys.update.tr,
                  textStyle: typoSmallTextBold.copyWith(color: colorText60),
                  width: MediaQuery.of(context).size.width,
                  height: 37.h,
                  borderRadius: 17,
                  backgroundColor: colorGrey10,
                )
              ],
            ),
          ))
        ],
      );

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
            onTap: () => controller.changeSex(),
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
                          onTap: () => controller.picImage(true),
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
                          onTap: () => controller.picImage(false),
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

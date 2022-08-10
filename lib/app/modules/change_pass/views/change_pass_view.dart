import 'package:c9p/app/utils/app_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
import '../controllers/change_pass_controller.dart';

class ChangePassView extends GetView<ChangePassController> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(child: AppScaffold(
        padding: EdgeInsets.all(contentPadding),
        fullStatusBar: true,
        appbar: AppBar(
          leading: Padding(
            padding: EdgeInsets.only(left: contentPadding),
            child: InkWell(
              child: SvgPicture.asset(
                R.assetsBackSvg,
                color: colorWhite,
              ),
              onTap: () => Get.back(),
            ),
          ),
          leadingWidth: 28.w,
          automaticallyImplyLeading: true,
          centerTitle: true,
          title: AppText(
            LocaleKeys.change_pin.tr,
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
          child:
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            itemSpace(),
            itemContent(
                LocaleKeys.input_current_pin.tr, controller.oldPassController),
            itemSpace(),
            itemSpace(),
            itemContent(
                LocaleKeys.input_new_pin.tr, controller.newPassController),
            itemSpace(),
            AppTextField(
              isShowErrorText: false,
              controller: controller.confirmPassController,
              autofocus: true,
              keyboardType: TextInputType.number,
              inputFormatters: [
                LengthLimitingTextInputFormatter(4),
              ],
              textStyle: typoSuperSmallTextBold.copyWith(letterSpacing: 30),
              obscureText: true,
              obscuringCharacter: '*',
              decoration: decorTextFieldOval.copyWith(
                  alignLabelWithHint: false,
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  hintText: LocaleKeys.input_retype_new_pin.tr,
                  prefixIconColor: Colors.black,
                  hintStyle: typoSuperSmallText500.copyWith(color: colorText40),
                  prefixIcon: Row(
                    mainAxisSize: MainAxisSize.min, // <-- important
                    children: [
                      const SizedBox(width: 15),
                      SvgPicture.asset(
                        R.assetsSvChangePinBlack,
                        width: 20.w,
                      ),
                      const SizedBox(width: 7),
                      Container(
                        height: 25.h,
                        color: colorGrey80,
                        width: 0.3,
                      ),
                      const SizedBox(width: 15),
                    ],
                  )),
              hintText: LocaleKeys.phone_number_of_you.tr,
            ),
            const Spacer(),
            AppButton(
              onPress: () => controller.saveOnclick(context),
              title: LocaleKeys.save.tr,
              textStyle: typoButton.copyWith(color: colorText0),
              width: MediaQuery.of(context).size.width,
              height: heightContinue,
              shapeBorder: shapeBorderButton,
              backgroundColor: colorGreen55,
            ),
            const   SizedBox(
              height: 20,
            )
          ]),
        )),onTap: ()=>Utils.hideKeyboard(context),);
  }

  Widget itemContent(
      String title, TextEditingController textEditingController) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          title,
          style: typoSuperSmallText500.copyWith(
            fontSize: 13.sp,
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        AppTextField(
          controller: textEditingController,
          isShowErrorText: false,
          autofocus: true,
          keyboardType: TextInputType.number,
          inputFormatters: [
            LengthLimitingTextInputFormatter(4),
          ],
          textStyle: typoSuperSmallTextBold.copyWith(
            letterSpacing: 30,
          ),
          obscureText: true,
          obscuringCharacter: '*',
          textInputAction: TextInputAction.next,
          decoration: decorTextFieldOval.copyWith(
              alignLabelWithHint: false,
              floatingLabelBehavior: FloatingLabelBehavior.never,
              hintText: "****",
              prefixIconColor: Colors.black,
              hintStyle: typoSuperSmallTextBold.copyWith(
                  color: colorText40, letterSpacing: 30),
              prefixIcon: Row(
                mainAxisSize: MainAxisSize.min, // <-- important
                children: [
                  const SizedBox(width: 15),
                  SvgPicture.asset(
                    R.assetsSvChangePinBlack,
                    width: 20.w,
                  ),
                  const SizedBox(width: 7),
                  Container(
                    height: 25.h,
                    color: colorGrey80,
                    width: 0.3,
                  ),
                  const SizedBox(width: 15),
                ],
              )),
          hintText: LocaleKeys.phone_number_of_you.tr,
        ),
      ],
    );
  }

  final decorTextFieldOval = InputDecoration(
    suffixIconConstraints: BoxConstraints(minHeight: 24.h, minWidth: 24.w),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: colorGrey85.withOpacity(0.5), width: 1.0),
      borderRadius: const BorderRadius.all(Radius.circular(17)),
    ),
    focusColor: colorGrey85,
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: colorGrey85.withOpacity(0.5), width: 1.0),
      borderRadius: const BorderRadius.all(Radius.circular(17)),
    ),
    errorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: colorGrey85.withOpacity(0.5), width: 1.0),
      borderRadius: const BorderRadius.all(Radius.circular(17)),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: colorGrey85.withOpacity(0.5), width: 1.0),
      borderRadius: const BorderRadius.all(Radius.circular(17)),
    ),
    contentPadding:
        EdgeInsets.only(left: 15.w, top: 10.h, bottom: 10.h, right: 5.w),
    // contentPadding: const EdgeInsets.symmetric(vertical: 11/*, horizontal: 16*/),
    hintStyle: typoSuperSmallTextBold.copyWith(
        color: colorNeutralDark40.withOpacity(0.4)),

    errorStyle: typoSuperSmallTextBold.copyWith(color: colorSemanticRed100),
    counterText: '',

    fillColor: Colors.white,
    isDense: true,
    filled: true,
  );

  Widget itemSpace() => SizedBox(
        height: 15,
      );
}

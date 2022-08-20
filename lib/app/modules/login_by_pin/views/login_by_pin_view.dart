import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:otp_text_field/style.dart';

import '../../../components/app_button.dart';
import '../../../components/app_scalford.dart';
import '../../../components/app_text.dart';
import '../../../components/otp_text_field_widget.dart';
import '../../../components/otp_widget.dart';
import '../../../components/pin_code/builder/color_builder.dart';
import '../../../components/pin_code/cursor/pin_cursor.dart';
import '../../../components/pin_code/decoration/decoration_boxloose.dart';
import '../../../components/pin_code/widget/pin_widget.dart';
import '../../../config/app_translation.dart';
import '../../../config/globals.dart';
import '../../../config/resource.dart';
import '../../../theme/app_styles.dart';
import '../../../theme/colors.dart';
import '../controllers/login_by_pin_controller.dart';

class LoginByPinView extends GetView<LoginByPinController> {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(isTabToHideKeyBoard: true,
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
              LocaleKeys.input_pin.tr,
              style: typoLargeTextBold.copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(
              height: 10,
            ),
            AppText(
              LocaleKeys.please_input_pin_to_login.tr,
              style: typoSuperSmallTextRegular.copyWith(
                  color: colorText40, fontSize: 12.sp),
            ),
            const SizedBox(
              height: 40,
            ),
            SizedBox(
              height: 1.h,
            ),
            OtpTextFieldWidget(focusNode: controller.focusNode,
              onSubmit: (String text) => controller.setPin(text, context),
              onChanged: (String text) => controller.setPin(text, context),
              controller: controller.otpController,
            ),
            SizedBox(
              height: 100.h,
            ),
            Obx(() =>
                AppButton(
                  height: heightContinue,
                  title: LocaleKeys.login.tr,
                  textStyle: typoButton.copyWith(
                      color:  controller.pin.value.length == 4
                          ? colorText0
                          : colorText60),
                  shapeBorder: shapeBorderButton,
                  onPress: () =>controller.onClickLogin(context),
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  backgroundColor:  controller.pin.value.length == 4
                      ? colorGreen50
                      : colorGrey10,
                )),]
          ,
        )
    );
  }

  Widget _buildPinInputTextFieldExample(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.only(left: 30.w+contentPadding, right: 30.w+contentPadding),
      child: PinInputTextField(
        pinLength: 4,
        decoration: BoxLooseDecoration(strokeWidth: 1.2,
            gapSpace: 25.w,
            strokeColorBuilder: PinListenColorBuilder(
                Colors.black.withOpacity(0.08), Colors.black.withOpacity(0.08)),
            textStyle: typoLargeTextBold600.copyWith(color: colorGreen57)),
        textInputAction: TextInputAction.go,
        enabled: true,
        keyboardType: TextInputType.text,
        textCapitalization: TextCapitalization.characters,
        onSubmit: (pin) {
          debugPrint('submit pin:$pin');
        },
        onChanged: (pin) {
          debugPrint('onChanged execute. pin:$pin');
        },
        enableInteractiveSelection: false,
        cursor: Cursor(
          width: 2,
          color: colorGreen57,
          enabled: true,
        ),
      ),
    );
  }
}

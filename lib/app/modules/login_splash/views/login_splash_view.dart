import 'package:c9p/app/components/app_button.dart';
import 'package:c9p/app/components/app_scalford.dart';
import 'package:c9p/app/components/app_text.dart';
import 'package:c9p/app/config/app_translation.dart';
import 'package:c9p/app/routes/app_pages.dart';
import 'package:c9p/app/theme/app_styles.dart';
import 'package:c9p/app/theme/colors.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:c9p/app/config/globals.dart' as globals;
import 'package:get/get.dart';

import '../../../config/resource.dart';
import '../controllers/login_splash_controller.dart';

class LoginSplashView extends GetView<LoginSplashController> {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(right: 13.w),
            child: Stack(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                ),
                SvgPicture.asset(
                  R.assetsLocationLoginSvg,
                  width: MediaQuery.of(context).size.width -
                      MediaQuery.of(context).size.width / 18,
                ),
                Positioned.fill(
                    child: Align(
                  alignment: Alignment.bottomRight,
                  child: SvgPicture.asset(R.assetsCircleCarSvg, width: 185.w),
                ))
              ],
            ),
          ),
          const Spacer(),
          Padding(
            padding: EdgeInsets.all(13.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  LocaleKeys.com_9p_wellcome.tr,
                  style:
                      typoLargeTextBold.copyWith(fontWeight: FontWeight.w700),
                ),
                const SizedBox(
                  height: 10,
                ),
                AppText(
                  LocaleKeys.here_have_dish.tr,
                  style: typoSuperSmallTextBold.copyWith(
                      fontSize: 11.sp, fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 20,
                ),
                AppButton(
                  textStyle: typoButton.copyWith(
                      color: colorText0, fontWeight: FontWeight.w700),
                  title: LocaleKeys.login.tr,
                  onPress: () => Get.toNamed(Routes.LOGIN),
                  width: MediaQuery.of(context).size.width,
                  backgroundColor: colorGreen60,
                  height: 40.h,
                  shapeBorder: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100)),
                ),
                const SizedBox(
                  height: 25,
                ),
                RichText(
                  text: TextSpan(
                      text: LocaleKeys.accept_with.tr,
                      style: typoSuperSmallTextBold.copyWith(fontSize: 11.sp),
                      children: [
                        TextSpan(
                            text: " ${LocaleKeys.regulation.tr}",
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => controller.openWebView(
                                  LocaleKeys.regulation.tr,
                                  globals.tempOfUseUrl),
                            style: typoSmallTextRegular.copyWith(
                                color: colorGeenBlue60, fontSize: 11.sp)),
                        TextSpan(
                            text: " ${LocaleKeys.va.tr} ",
                            style:
                                typoSmallTextRegular.copyWith(fontSize: 11.sp)),
                        TextSpan(
                            text: LocaleKeys.rules.tr,
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => controller.openWebView(
                                  LocaleKeys.rules.tr, globals.privacyUrl),
                            style: typoSmallTextRegular.copyWith(
                                color: colorGeenBlue60, fontSize: 11.sp))
                      ]),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

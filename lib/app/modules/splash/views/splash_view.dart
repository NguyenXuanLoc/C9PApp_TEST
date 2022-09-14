import 'package:c9p/app/components/app_scalford.dart';
import 'package:c9p/app/config/app_translation.dart';
import 'package:c9p/app/config/globals.dart';
import 'package:c9p/app/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../components/app_button.dart';
import '../../../components/app_text.dart';
import '../../../config/resource.dart';
import '../../../theme/app_styles.dart';
import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(children: [AppScaffold(
        fullStatusBar: true,
        body: Container(
          color: colorGreen60,
          child: Column(
            children: [
              Image.asset(
                R.assetsPngItemSplash1,
                fit: BoxFit.fitWidth,
              ),
              const Spacer(),
              Image.asset(
                R.assetsPngItemSplash2,
                height: 110.h,
              ),
              SizedBox(
                height: 100.h,
              ),
              const Spacer(),
              Image.asset(
                R.assetsPngItemSplash3,
                fit: BoxFit.fitWidth,
              ),
            ],
          ),
        )),Obx(() => Visibility(visible: controller.isForceUpdate.value,child: forceUpdateWidget(context),))],);
  }
  Widget forceUpdateWidget(BuildContext context){
    return Container(color: colorBlack.withOpacity(0.8),
      alignment: Alignment.center,
      child: Container(
        color: colorWhite,
        padding: EdgeInsets.all(contentPadding),
        margin: EdgeInsets.all(contentPadding+contentPadding),
        child: Column(
          mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SizedBox(
            height: 10.h,
          ),
            Material(
                color: colorWhite,
                child: AppText(
                  LocaleKeys.message_force_update.tr,
                  style: typoSmallTextBold,
                  textAlign: TextAlign.center,
                )),
            SizedBox(
              height: 20.h,
          ),
          Container(margin: EdgeInsets.only(right: 11.w),
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.centerRight,
            child: AppButton(
                title: "Đồng ý",
                textStyle:
                typoSuperSmallTextBold.copyWith(color: colorWhite),
                onPress: () =>controller.openStore(),
                width: 90.w,
                height: 25.h,
                backgroundColor: colorGreen60,
                shapeBorder: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5.h)))),
          ),
        ],
      ),),
    );
  }
}

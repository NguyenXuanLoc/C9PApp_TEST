import 'package:c9p/app/config/globals.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../config/app_translation.dart';
import '../config/resource.dart';
import '../theme/app_styles.dart';
import '../theme/colors.dart';
import 'app_button.dart';
import 'app_scalford.dart';
import 'app_text.dart';

class AppDeveloping extends StatelessWidget {
  final VoidCallback onClickMain;
  final VoidCallback onClickOrder;
  final bool isShowBack;
  const AppDeveloping(
      {Key? key,
      required this.onClickMain,
      required this.onClickOrder,
      this.isShowBack = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      padding: EdgeInsets.all(15.w),
      appbar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        centerTitle: true,
        flexibleSpace: Container(
          alignment: Alignment.bottomCenter,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(R.assetsBackgroundHeaderTabMainPng),
                  fit: BoxFit.fitWidth)),
          child: Container(
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.centerLeft,
            height: 30.h,
            decoration: BoxDecoration(
                color: colorWhite,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(15.w),
                    topLeft: Radius.circular(15.w))),
            child: isShowBack? Padding(
                padding: EdgeInsets.only(left: contentPadding),
                    child: Container(
                      padding: EdgeInsets.all(2.w),
                      decoration: BoxDecoration(
                          color: colorGrey10,
                          borderRadius: BorderRadius.circular(100)),
                      child: IconButton(
                          splashRadius: 20,
                          constraints:
                              BoxConstraints(maxHeight: 30.w, maxWidth: 30.w),
                          padding: const EdgeInsets.all(0),
                          onPressed: () => Get.back(),
                          icon: SvgPicture.asset(R.assetsBackSvg)),
                    ))
                : const SizedBox(),
          ),
        ),
      ),
      body: Column(
        children: [
          const Spacer(),
          Padding(
            padding: EdgeInsets.all(15.w),
            child: Image.asset(R.assetsPngDeveloping),
          ),
          AppText(
            LocaleKeys.developing.tr,
            textAlign: TextAlign.center,
            style: typoSuperSmallText500.copyWith(color: colorText60),
          ),
          const SizedBox(
            height: 60,
          ),
          AppButton(
            height: heightContinue,
            onPress: () => onClickMain.call(),
            title: LocaleKeys.main.tr,
            backgroundColor: colorGrey15,
            shapeBorder: shapeBorderButton,
            textStyle: typoButton.copyWith(color: colorText60),
            width: MediaQuery.of(context).size.width,
          ),
          const SizedBox(
            height: 10,
          ),
          AppButton(
            height: heightContinue,
            onPress: () => onClickOrder.call(),
            title: LocaleKeys.reorder_rice.tr,
            backgroundColor: colorGreen55,
            shapeBorder: shapeBorderButton,
            textStyle: typoButton.copyWith(color: colorText0),
            width: MediaQuery.of(context).size.width,
          ),
          const Spacer(),
          const Spacer(),
        ],
      ),
    );
  }
}

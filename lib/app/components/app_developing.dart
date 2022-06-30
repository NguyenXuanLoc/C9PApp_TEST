import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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

  const AppDeveloping(
      {Key? key, required this.onClickMain, required this.onClickOrder})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      padding: EdgeInsets.all(15.w),
      appbar: AppBar(
        elevation: 0,
        centerTitle: true,
        flexibleSpace: Container(
          alignment: Alignment.bottomCenter,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(R.assetsBackgroundHeaderTabMainPng),
                  fit: BoxFit.fitWidth)),
          child: Container(
            height: 30.h,
            decoration: BoxDecoration(
                color: colorWhite,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(15.w),
                    topLeft: Radius.circular(15.w))),
          ),
        ),
      ),
      body: Column(
        children: [
          const Spacer(),
          Image.asset(R.assetsPngDeveloping),
          AppText(
            LocaleKeys.developing.tr,
            textAlign: TextAlign.center,
            style: typoSuperSmallTextBold.copyWith(
                color: colorText60, fontSize: 12.sp),
          ),
          const SizedBox(
            height: 60,
          ),
          AppButton(
            onPress: () => onClickMain.call(),
            title: LocaleKeys.main.tr,
            backgroundColor: colorGrey15,
            shapeBorder: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(13.w)),
            textStyle: typoSmallTextBold.copyWith(color: colorText60),
            width: MediaQuery.of(context).size.width,
          ),
          const SizedBox(
            height: 10,
          ),
          AppButton(
            onPress: () => onClickOrder.call(),
            title: LocaleKeys.reorder_rice.tr,
            backgroundColor: colorGreen55,
            shapeBorder: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(13.w)),
            textStyle: typoSmallTextBold.copyWith(color: colorText0),
            width: MediaQuery.of(context).size.width,
          ),
          const Spacer(),
          const Spacer(),
        ],
      ),
    );
  }
}

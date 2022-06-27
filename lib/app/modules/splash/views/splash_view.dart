import 'package:c9p/app/components/app_scalford.dart';
import 'package:c9p/app/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../config/resource.dart';
import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.openHome();
    return AppScaffold(
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
        ));
  }
}

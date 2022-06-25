import 'package:c9p/app/components/app_scalford.dart';
import 'package:c9p/app/theme/colors.dart';
import 'package:flutter/material.dart';
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
        body: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Image.asset(
              R.assetsBackgroundPng,
              fit: BoxFit.cover,
            )));
  }
}

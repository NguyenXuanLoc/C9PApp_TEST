import 'package:c9p/app/components/app_developing.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/developing_controller.dart';

class DevelopingView extends GetView<DevelopingController> {
  @override
  Widget build(BuildContext context) {
    return AppDeveloping(
        isShowBack: controller.isShowBack,
        onClickMain: () => controller.mainOnclick(),
        onClickOrder: () => controller.reOrderOnclick());
  }
}

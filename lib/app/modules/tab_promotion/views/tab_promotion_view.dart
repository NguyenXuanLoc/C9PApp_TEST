import 'package:c9p/app/components/app_developing.dart';
import 'package:c9p/app/data/event_bus/jump_to_tab_event.dart';
import 'package:c9p/app/routes/app_pages.dart';
import 'package:c9p/app/utils/app_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/tab_promotion_controller.dart';

class TabPromotionView extends GetView<TabPromotionController> {
  @override
  Widget build(BuildContext context) {
    return AppDeveloping(
        onClickMain: () => Utils.fireEvent(JumpToTabEvent(0)),
        onClickOrder: () => Get.toNamed(Routes.ORDER));
  }
}

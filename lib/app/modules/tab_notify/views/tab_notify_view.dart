import 'package:c9p/app/data/event_bus/jump_to_tab_event.dart';
import 'package:c9p/app/utils/app_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../components/app_developing.dart';
import '../../../routes/app_pages.dart';
import '../controllers/tab_notify_controller.dart';

class TabNotifyView extends GetView<TabNotifyController> {
  @override
  Widget build(BuildContext context) {
    return AppDeveloping(
        onClickMain: () => Utils.fireEvent(JumpToTabEvent(0)),
        onClickOrder: () => Get.toNamed(Routes.ORDER));
  }
}

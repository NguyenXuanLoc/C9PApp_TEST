import 'package:c9p/app/components/app_button.dart';
import 'package:c9p/app/components/app_loading_widget.dart';
import 'package:c9p/app/components/app_not_data_widget.dart';
import 'package:c9p/app/components/app_scalford.dart';
import 'package:c9p/app/components/app_text.dart';
import 'package:c9p/app/components/item_order.dart';
import 'package:c9p/app/theme/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../config/app_translation.dart';
import '../../../config/resource.dart';
import '../../../theme/colors.dart';
import '../controllers/your_order_controller.dart';

class YourOrderView extends GetView<YourOrderController> {
  const YourOrderView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        appbar: AppBar(
          automaticallyImplyLeading: false,
          toolbarHeight: 30.h,
          centerTitle: true,
          flexibleSpace: Container(
            alignment: Alignment.bottomCenter,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(R.assetsBackgroundHeaderTabMainPng),
                    fit: BoxFit.fitWidth)),
            child: Center(
              child: Row(
                children: [
                  IconButton(
                    splashRadius: 20,
                    icon: SvgPicture.asset(
                      R.assetsBackSvg,
                      color: colorWhite,
                    ),
                    onPressed: () => Get.back(),
                  ),
                  const Spacer(),
                  AppText(
                    LocaleKeys.your_order.tr,
                    style: typoTitleHeader.copyWith(
                        fontWeight: FontWeight.w700, color: colorText0),
                  ),
                  const Spacer(),
                  IconButton(
                    splashRadius: 20,
                    icon: SvgPicture.asset(
                      R.assetsBackSvg,
                      color: Colors.transparent,
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ),
          bottom: TabBar(
            controller: controller.tabController,
            onTap: (index) => controller.setIndex(index),
            indicatorColor: colorOrange60,
            indicatorSize: TabBarIndicatorSize.label,
            unselectedLabelColor: Colors.black,
            tabs: [
              Tab(
                  height: 25.h,
                  icon: AppText(
                    LocaleKeys.order_are_coming.tr,
                    style: typoSuperSmallTextBold.copyWith(color: colorText0),
                  )),
              Tab(
                  height: 25.h,
                  icon: AppText(
                    LocaleKeys.order_delivered.tr,
                    style: typoSuperSmallTextBold.copyWith(color: colorText0),
                  )),
            ],
          ),
        ),
        body: Stack(
          children: [
            TabBarView(
              controller: controller.tabController,
              children: <Widget>[
                pendingOrderWidget(context),
                doneOrderWidget(context)
              ],
            ),
            Obx(() => Visibility(
                  visible: controller.isShowRefreshButton.value,
                  child: Positioned.fill(
                      child: Align(
                    alignment: Alignment.topCenter,
                    child: Opacity(
                      opacity: 0.9,
                      child: AppButton(
                        onPress: () => controller.refreshAll(),
                        title: LocaleKeys.refresh_list.tr,
                        textStyle: typoSuperSmallTextBold.copyWith(
                            color: colorText0, fontSize: 11.sp),
                        backgroundColor: colorGreen60,
                        borderRadius: 100.w,
                        height: 28.h,
                      ),
                    ),
                  )),
                ))
          ],
        ));
  }

  Widget doneOrderWidget(BuildContext context) {
    return Obx(() => RefreshIndicator(
        color: colorGreen60,
        child: controller.isLoadingDoneOrder.value &&
                controller.lDoneOrder.isEmpty
            ? const AppCircleLoading()
            : controller.lDoneOrder.isEmpty
                ? Stack(
                    children: [
                      ListView(),
                      AppNotDataWidget(
                        message: LocaleKeys.not_order_pull_to_refresh.tr,
                      )
                    ],
                  )
                : ListView.separated(
                    controller: controller.doneOrderScrollController,
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: const EdgeInsets.all(0),
                    itemBuilder: (c, i) => (i == controller.lDoneOrder.length)
                        ? const AppCircleLoading()
                        : ItemOrder(
                            model: controller.lDoneOrder[i],
                            callBackReOrder: (model) =>
                                controller.openReOrder(model),
                            callBackOrderDetail: (model) =>
                                controller.openOrderDetail(model)),
                    separatorBuilder: (i, c) => Container(
                          color: colorSeparatorListView,
                          height: 10.h,
                          width: MediaQuery.of(context).size.width,
                        ),
                    itemCount: !controller.isReadEndDoneOrder.value &&
                            controller.lDoneOrder.isNotEmpty &&
                            controller.isLoadingDoneOrder.value
                        ? controller.lDoneOrder.length + 1
                        : controller.lDoneOrder.length),
        onRefresh: () async => controller.refreshDoneOrder()));
  }

  Widget pendingOrderWidget(BuildContext context) {
    return Obx(() => RefreshIndicator(
        color: colorGreen60,
        child: controller.isLoadingPendingOrder.value &&
                controller.lPendingOrder.isEmpty
            ? const AppCircleLoading()
            : controller.lPendingOrder.isEmpty
                ? Stack(
                    children: [
                      ListView(),
                      AppNotDataWidget(
                        message: LocaleKeys.not_order_pull_to_refresh.tr,
                      )
                    ],
                  )
                : ListView.separated(
                    controller: controller.pendingOrderScrollController,
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: const EdgeInsets.all(0),
                    itemBuilder: (c, i) =>
                        (i == controller.lPendingOrder.length)
                            ? const AppCircleLoading()
                            : ItemOrder(
                                model: controller.lPendingOrder[i],
                                callBackOrderDetail: (model) =>
                                    controller.openOrderDetail(model)),
                    separatorBuilder: (i, c) => Container(
                          color: colorSeparatorListView,
                          height: 10.h,
                          width: MediaQuery.of(context).size.width,
                        ),
                    itemCount: (!controller.isReadEndPendingOrder.value &&
                            controller.lPendingOrder.isNotEmpty &&
                            controller.isLoadingPendingOrder.value)
                        ? controller.lPendingOrder.length + 1
                        : controller.lPendingOrder.length),
        onRefresh: () async => controller.refreshPendingOrder()));
  }
}

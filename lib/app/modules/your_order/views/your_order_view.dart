import 'package:c9p/app/components/app_loading_widget.dart';
import 'package:c9p/app/components/app_not_data_widget.dart';
import 'package:c9p/app/components/app_scalford.dart';
import 'package:c9p/app/components/app_text.dart';
import 'package:c9p/app/theme/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../app_line.dart';
import '../../../components/app_button.dart';
import '../../../components/app_network_image.dart';
import '../../../config/app_translation.dart';
import '../../../config/globals.dart';
import '../../../config/resource.dart';
import '../../../data/model/order_model.dart';
import '../../../theme/colors.dart';
import '../../../utils/app_utils.dart';
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
                    style: typoMediumTextBold.copyWith(
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
        body: TabBarView(
          controller: controller.tabController,
          children: <Widget>[
            pendingOrderWidget(context),
            doneOrderWidget(context)
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
                        : itemDoneOrder(controller.lDoneOrder[i]),
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

  Widget itemDoneOrder(OrderModel model) {
    return Padding(
      padding: EdgeInsets.all(contentPadding),
      child: InkWell(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                model.imageUrl != null && model.imageUrl.isNotEmpty
                    ? AppNetworkImage(
                        source: model.imageUrl,
                        height: 50.h,
                      )
                    : Image.asset(
                        R.assetsPngComSuon9p,
                        height: 50.h,
                        fit: BoxFit.fitHeight,
                      ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                      AppText(
                        LocaleKeys.com_suong_9p.tr,
                        style: typoSmallTextBold.copyWith(
                            fontWeight: FontWeight.w800),
                      ),
                      SizedBox(
                        height: 30,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            AppText(
                                '${Utils.formatMoney(model.amount ?? 0)}đ',
                                style: typoSmallTextBold.copyWith(
                                    color: colorSemanticRed100,
                                    fontWeight: FontWeight.w800)),
                            const Spacer(),
                            AppText(
                                '${LocaleKeys.code.tr} #${model.id ?? 0} / ${model.itemQty ?? 0} ${LocaleKeys.bowl_of_rice.tr}',
                                textAlign: TextAlign.center,
                                style: typoSuperSmallTextBold.copyWith(
                                    fontSize: 12.sp, color: colorOrange40))
                          ],
                        ),
                      ),
                    ]))
              ],
            ),
            SizedBox(
              height: 10.h,
            ),
            const AppLineWidget(),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                AppText(
                  Utils.convertTimeToDDMMYYHHMMSS(
                      model.deliverTime ?? DateTime.now()),
                  style: typoSuperSmallTextBold.copyWith(fontSize: 11.5.sp),
                ),
                const Spacer(),
                AppText(
                model.status ?? '',
                  style: typoSuperSmallTextBold.copyWith(
                      fontSize: 11.5.sp, color: colorGreen55),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            const AppLineWidget(),
            const SizedBox(
              height: 10,
            ),
            AppText(
              "${LocaleKeys.address.tr}: ${model.toAddress ?? ''}",
              style: typoSuperSmallTextBold.copyWith(fontSize: 12.sp),
            ),
            SizedBox(
              height: 15.h,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: AppButton(
                borderRadius: 100,
                onPress: () => controller.onClickReOrder(model),
                title: LocaleKeys.re_deliver.tr,
                textStyle: typoSuperSmallTextBold.copyWith(color: colorText0),
                backgroundColor: colorGreen57,
                height: 28.h,
                padding: EdgeInsets.only(left: 20.w, right: 20.w),
              ),
            )
          ],
        ),
        onTap: () => controller.openOrderDetail(model),
      ),
    );
  }

  Widget itemPendingOrder(OrderModel model) {
    return Padding(
      padding: EdgeInsets.all(contentPadding),
      child: InkWell(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                model.imageUrl != null && model.imageUrl.isNotEmpty
                    ? AppNetworkImage(
                        source: model.imageUrl,
                        height: 50.h,
                      )
                    : Image.asset(
                        R.assetsPngComSuon9p,
                        height: 50.h,
                        fit: BoxFit.fitHeight,
                      ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                      AppText(
                        LocaleKeys.com_suong_9p.tr,
                        style: typoSmallTextBold.copyWith(
                            fontWeight: FontWeight.w800),
                      ),
                      SizedBox(
                        height: 30,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            AppText(
                                '${Utils.formatMoney(model.amount ?? 0)}đ',
                                style: typoSmallTextBold.copyWith(
                                    color: colorSemanticRed100,
                                    fontWeight: FontWeight.w800)),
                            const Spacer(),
                            AppText(
                                '${LocaleKeys.code.tr} #${model.id ?? 0} / ${model.itemQty ?? 0} ${LocaleKeys.bowl_of_rice.tr}',
                                textAlign: TextAlign.center,
                                style: typoSuperSmallTextBold.copyWith(
                                    fontSize: 12.sp, color: colorOrange40))
                          ],
                        ),
                      ),
                    ]))
              ],
            ),
            SizedBox(
              height: 10.h,
            ),
            const AppLineWidget(),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                AppText(
                  Utils.convertTimeToDDMMYYHHMMSS(
                      model.deliverTime ?? DateTime.now()),
                  style: typoSuperSmallTextBold.copyWith(fontSize: 11.5.sp),
                ),
                const Spacer(),
                AppText(
                  model.status ?? '',
                  style: typoSuperSmallTextBold.copyWith(
                      fontSize: 11.5.sp, color: colorGreen55),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            const AppLineWidget(),
            const SizedBox(
              height: 10,
            ),
            AppText(
              "${LocaleKeys.address.tr}: ${model.toAddress ?? ''}",
              style: typoSuperSmallTextBold.copyWith(fontSize: 12.sp),
            ),
          ],
        ),
        onTap: () => controller.openOrderDetail(model),
      ),
    );
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
                            : itemPendingOrder(controller.lPendingOrder[i]),
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

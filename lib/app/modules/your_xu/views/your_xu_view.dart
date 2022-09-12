import 'package:c9p/app/components/app_button.dart';
import 'package:c9p/app/components/app_loading_widget.dart';
import 'package:c9p/app/components/app_not_data_widget.dart';
import 'package:c9p/app/components/app_scalford.dart';
import 'package:c9p/app/components/app_text.dart';
import 'package:c9p/app/components/item_order.dart';
import 'package:c9p/app/config/globals.dart';
import 'package:c9p/app/theme/app_styles.dart';
import 'package:c9p/app/utils/tag_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../config/app_translation.dart';
import '../../../config/resource.dart';
import '../../../theme/colors.dart';
import '../../../utils/app_utils.dart';

class YourXuView extends StatelessWidget {
  var controller = TagUtils().findYourXuController();

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        appbar: appbar(context),
        body: Column(
          children: [
            Stack(
              children: [
                Container(
                  color: colorGrey2,
                  padding: EdgeInsets.only(bottom: 40.h),
                  width: MediaQuery.of(context).size.width,
                  child: SvgPicture.asset(
                    R.assetsBackgroundHeaderTabMainSvg,
                    fit: BoxFit.fitWidth,
                    height: 35.h,
                    width: MediaQuery.of(context).size.width,
                  ),
                ),
                Positioned.fill(
                    child: Align(
                  alignment: Alignment.topCenter,
                  child: infoWalletWidget(context),
                ))
              ],
            ),
            Stack(
              children: [
                TabBar(
                  labelPadding: EdgeInsets.all(0),
                  controller: controller!.tabController,
                  onTap: (index) => controller!.setIndex(index),
                  indicatorColor: colorGreen60,
                  indicatorSize: TabBarIndicatorSize.label,
                  unselectedLabelColor: Colors.black,
                  tabs: [
                    Tab(
                        height: 25.h,
                        icon: AppText(
                          LocaleKeys.history.tr,
                          style: typoSuperSmallText600.copyWith(
                              color: colorBlue30),
                        )),
                    Tab(
                        height: 25.h,
                        icon: AppText(
                          LocaleKeys.load_cents.tr,
                          style: typoSuperSmallTextBold.copyWith(
                              color: colorBlue30),
                        )),
                    Tab(
                        height: 25.h,
                        icon: AppText(
                          LocaleKeys.use_coins.tr,
                          style: typoSuperSmallTextBold.copyWith(
                              color: colorBlue30),
                        )),
                  ],
                ),
                Positioned.fill(
                    child: Align(
                  alignment: Alignment.bottomCenter,
                  child: lineWidget(context),
                ))
              ],
            ),
            Expanded(
                child: TabBarView(
              controller: controller!.tabController,
              children: <Widget>[
                historyWidget(context),
                loadCoinWidget(context),
                useCoinWidget(context)
              ],
            )),
          ],
        ));
  }

  Widget lineWidget(BuildContext context) => Container(
        color: colorLine.withOpacity(0.3),
        height: 0.2,
        width: MediaQuery.of(context).size.width,
      );

  Widget historyWidget(BuildContext context) {
    return Obx(() => RefreshIndicator(
        color: colorGreen60,
        child: controller!.isLoadingDoneOrder.value &&
                controller!.lDoneOrder.isEmpty
            ? const AppCircleLoading()
            : controller!.lDoneOrder.isEmpty
                ? Stack(
                    children: [
                      ListView(),
                      AppNotDataWidget(
                        message: LocaleKeys.not_order_pull_to_refresh.tr,
                      )
                    ],
                  )
                : ListView.separated(
                    controller: controller!.doneOrderScrollController,
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: const EdgeInsets.all(0),
                    itemBuilder: (c, i) => (i == controller!.lDoneOrder.length)
                        ? const AppCircleLoading()
                        : itemInfoWidget(context, false),
                    separatorBuilder: (i, c) => lineWidget(context),
                    itemCount: !controller!.isReadEndDoneOrder.value &&
                            controller!.lDoneOrder.isNotEmpty &&
                            controller!.isLoadingDoneOrder.value
                        ? controller!.lDoneOrder.length + 1
                        : controller!.lDoneOrder.length),
        onRefresh: () async => controller!.refreshDoneOrder()));
  }

  Widget loadCoinWidget(BuildContext context) {
    return Obx(() => RefreshIndicator(
        color: colorGreen60,
        child: controller!.isLoadingPendingOrder.value &&
                controller!.lPendingOrder.isEmpty
            ? const AppCircleLoading()
            : controller!.lPendingOrder.isEmpty
                ? Stack(
                    children: [
                      ListView(),
                      AppNotDataWidget(
                        message: LocaleKeys.not_order_pull_to_refresh.tr,
                      )
                    ],
                  )
                : ListView.separated(
                    controller: controller!.pendingOrderScrollController,
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: const EdgeInsets.all(0),
                    itemBuilder: (c, i) =>
                        (i == controller!.lPendingOrder.length)
                            ? const AppCircleLoading()
                            : itemInfoWidget(context, true),
                    separatorBuilder: (i, c) => Container(
                          color: colorLine.withOpacity(0.3),
                          height: 0.2,
                          width: MediaQuery.of(context).size.width,
                        ),
                    itemCount: (!controller!.isReadEndPendingOrder.value &&
                            controller!.lPendingOrder.isNotEmpty &&
                            controller!.isLoadingPendingOrder.value)
                        ? controller!.lPendingOrder.length + 1
                        : controller!.lPendingOrder.length),
        onRefresh: () async => controller!.refreshPendingOrder()));
  }

  Widget useCoinWidget(BuildContext context) {
    return Obx(() => RefreshIndicator(
        color: colorGreen60,
        child: controller!.isLoadingPendingOrder.value &&
                controller!.lPendingOrder.isEmpty
            ? const AppCircleLoading()
            : controller!.lPendingOrder.isEmpty
                ? Stack(
                    children: [
                      ListView(),
                      AppNotDataWidget(
                        message: LocaleKeys.not_order_pull_to_refresh.tr,
                      )
                    ],
                  )
                : ListView.separated(
                    controller: controller!.pendingOrderScrollController,
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: const EdgeInsets.all(0),
                    itemBuilder: (c, i) =>
                        (i == controller!.lPendingOrder.length)
                            ? const AppCircleLoading()
                            : itemInfoWidget(context, false),
                    separatorBuilder: (i, c) => lineWidget(context),
                    itemCount: (!controller!.isReadEndPendingOrder.value &&
                            controller!.lPendingOrder.isNotEmpty &&
                            controller!.isLoadingPendingOrder.value)
                        ? controller!.lPendingOrder.length + 1
                        : controller!.lPendingOrder.length),
        onRefresh: () async => controller!.refreshPendingOrder()));
  }

  Widget infoWalletWidget(BuildContext context) => Padding(
        padding: EdgeInsets.only(left: contentPadding, right: contentPadding),
        child: Container(
          padding: EdgeInsets.only(
              left: contentPadding,
              right: contentPadding - 2,
              top: contentPadding,
              bottom: contentPadding),
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 4,
              offset: const Offset(0, 0.5),
            )
          ], borderRadius: BorderRadius.circular(15), color: colorWhite),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  AppText(
                    LocaleKeys.xu_in_wallet.tr,
                    style: typoSuperSmallText600,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.asset(
                        R.assetsPngXu,
                        width: 14.w,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Obx(() => AppText(
                          '${Utils.formatXu(controller!.xuModel.value.balance ?? 0)} ${LocaleKeys.xu.tr}',
                          style:
                              typoSmallTextBold.copyWith(color: colorOrange70)))
                    ],
                  )
                ],
              ),
              const Spacer(),
              AppButton(
                backgroundColor: colorGreen40,
                onPress: () => controller!.buyXuOnclick(context),
                borderRadius: 15,
                height: 26.h,
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                title: LocaleKeys.load_cents.tr,
                textStyle: typoSuperSmallText600.copyWith(color: colorText0),
              )
            ],
          ),
        ),
      );

  Widget itemInfoWidget(BuildContext context, bool isLoadCoin) => Padding(
        padding: EdgeInsets.only(
            left: contentPadding,
            right: contentPadding,
            bottom: 10,
            top: contentPadding),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                flex: 7,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(
                      'Nạp 120.000đ cơm 9 phút',
                      style: typoSuperSmallText500,
                    ),
                    AppText(
                      '15:00 26/08/2022',
                      style: typoSuperSmallText500,
                    )
                  ],
                )),
            Expanded(
                flex: 3,
                child: AppText(
                  isLoadCoin ? "+120.000 xu" : '-120.000 xu',
                  style: typoSuperSmallText500.copyWith(
                      color: isLoadCoin ? colorGreen55 : colorSemanticRed100),
                  textAlign: TextAlign.end,
                  maxLine: 2,
                ))
          ],
        ),
      );

  PreferredSizeWidget appbar(BuildContext context) => AppBar(
        leadingWidth: 28.w,
        leading: Padding(
            padding: EdgeInsets.only(left: contentPadding),
            child: InkWell(
              child: SvgPicture.asset(
                R.assetsBackSvg,
                color: colorWhite,
              ),
              onTap: () => Get.back(),
            )),
        title: AppText(
          LocaleKeys.your_xu.tr,
          style: typoTitleHeader,
        ),
        automaticallyImplyLeading: false,
        centerTitle: true,
        flexibleSpace: SvgPicture.asset(
          R.assetsBackgroundHeaderTabMainSvg,
          fit: BoxFit.cover,
        ),
      );
}

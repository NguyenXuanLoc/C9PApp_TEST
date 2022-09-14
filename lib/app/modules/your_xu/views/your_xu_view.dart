import 'package:c9p/app/components/app_button.dart';
import 'package:c9p/app/components/app_loading_widget.dart';
import 'package:c9p/app/components/app_not_data_widget.dart';
import 'package:c9p/app/components/app_scalford.dart';
import 'package:c9p/app/components/app_text.dart';
import 'package:c9p/app/components/item_order.dart';
import 'package:c9p/app/config/constant.dart';
import 'package:c9p/app/config/globals.dart';
import 'package:c9p/app/theme/app_styles.dart';
import 'package:c9p/app/utils/tag_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../config/app_translation.dart';
import '../../../config/resource.dart';
import '../../../data/model/history_xu_model.dart';
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
                  padding: EdgeInsets.only(bottom: 32.h),
                  width: MediaQuery.of(context).size.width,
                  child: Image.asset(
                    R.assetsBackgroundHeaderTabMainPng,
                    fit: BoxFit.fitWidth,
                    height: 33.h,
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
                  padding: EdgeInsets.all(0),
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
                addXuWidget(context),
                useXuWidget(context)
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
        child: controller!.isLoadingHistory.value &&
                controller!.lHistory.isEmpty
            ? const AppCircleLoading()
            : controller!.lHistory.isEmpty
                ? Stack(
                    children: [
                      ListView(physics: const AlwaysScrollableScrollPhysics()),
                      AppNotDataWidget(
                        message: LocaleKeys.not_order_pull_to_refresh.tr,
                      )
                    ],
                  )
                : ListView.separated(
                    controller: controller!.historyScrollController,
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: const EdgeInsets.all(0),
                    itemBuilder: (c, i) => (i == controller!.lHistory.length)
                        ? const AppCircleLoading()
                        : itemInfoWidget(context, controller!.lHistory[i]),
                    separatorBuilder: (i, c) => lineWidget(context),
                    itemCount: !controller!.isReadEndHistory.value &&
                            controller!.lHistory.isNotEmpty &&
                            controller!.isLoadingHistory.value
                        ? controller!.lHistory.length + 1
                        : controller!.lHistory.length),
        onRefresh: () async => controller!.refreshHistory()));
  }

  Widget addXuWidget(BuildContext context) {
    return Obx(() => RefreshIndicator(
        color: colorGreen60,
        child: controller!.isLoadingAddXu.value && controller!.lAddXu.isEmpty
            ? const AppCircleLoading()
            : controller!.lAddXu.isEmpty
                ? Stack(
                    children: [
                      ListView(),
                      AppNotDataWidget(
                        message: LocaleKeys.not_order_pull_to_refresh.tr,
                      )
                    ],
                  )
                : ListView.separated(
                    controller: controller!.addXuScrollController,
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: const EdgeInsets.all(0),
                    itemBuilder: (c, i) => (i == controller!.lAddXu.length)
                        ? const AppCircleLoading()
                        : itemInfoWidget(context, controller!.lAddXu[i]),
                    separatorBuilder: (i, c) => Container(
                          color: colorLine.withOpacity(0.3),
                          height: 0.2,
                          width: MediaQuery.of(context).size.width,
                        ),
                    itemCount: (!controller!.isReadEndAddXu.value &&
                            controller!.lAddXu.isNotEmpty &&
                            controller!.isLoadingAddXu.value)
                        ? controller!.lAddXu.length + 1
                        : controller!.lAddXu.length),
        onRefresh: () async => controller!.refreshAddXu()));
  }

  Widget useXuWidget(BuildContext context) {
    return Obx(() => RefreshIndicator(
        color: colorGreen60,
        child: controller!.isLoadingUseXu.value && controller!.lUseXu.isEmpty
            ? const AppCircleLoading()
            : controller!.lUseXu.isEmpty
                ? Stack(
                    children: [
                      ListView(),
                      AppNotDataWidget(
                        message: LocaleKeys.not_order_pull_to_refresh.tr,
                      )
                    ],
                  )
                : ListView.separated(
                    controller: controller!.useXuScrollController,
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: const EdgeInsets.all(0),
                    itemBuilder: (c, i) => (i == controller!.lUseXu.length)
                        ? const AppCircleLoading()
                        : itemInfoWidget(context, controller!.lUseXu[i]),
                    separatorBuilder: (i, c) => lineWidget(context),
                    itemCount: (!controller!.isReadEndUseXu.value &&
                            controller!.lUseXu.isNotEmpty &&
                            controller!.isLoadingUseXu.value)
                        ? controller!.lUseXu.length + 1
                        : controller!.lUseXu.length),
        onRefresh: () async => controller!.refreshUseXu()));
  }

  Widget infoWalletWidget(BuildContext context) => Padding(
        padding: EdgeInsets.only(left: contentPadding, right: contentPadding),
        child: Container(
          padding: EdgeInsets.only(
              left: contentPadding,
              right: contentPadding - 2,
              top: contentPadding - 5,
              bottom: contentPadding - 5),
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 4,
              offset: const Offset(0, 0.5),
            )
          ], borderRadius: BorderRadius.circular(20), color: colorWhite),
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
                  const SizedBox(
                    height: 3,
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

  Widget itemInfoWidget(BuildContext context, HistoryXuModel model) => Padding(
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
                      model.description ?? '',
                      style: typoSuperSmallText500,
                    ),
                    AppText(
                      Utils.convertTimeToHHMMDDMMYY(
                          model.createdAt ?? DateTime.now()),
                      style: typoSuperSmallText500,
                    )
                  ],
                )),
            Expanded(
                flex: 3,
                child: AppText(
                  model.varied == ApiKey.plus
                      ? "+${Utils.formatMoney(model.amount ?? 0)} ${LocaleKeys.xu.tr}"
                      : "-${Utils.formatMoney(model.amount ?? 0)} ${LocaleKeys.xu.tr}",
                  style: typoSuperSmallText500.copyWith(
                      color: model.varied == ApiKey.plus
                          ? colorGreen55
                          : colorSemanticRed100),
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
        flexibleSpace: Image.asset(
          R.assetsBackgroundHeaderTabMainPng,
          fit: BoxFit.cover,
        ),
      );
}

import 'dart:ffi';

import 'package:badges/badges.dart';
import 'package:c9p/app/components/app_button.dart';
import 'package:c9p/app/components/app_circle_image.dart';
import 'package:c9p/app/components/app_loading_widget.dart';
import 'package:c9p/app/components/app_network_image.dart';
import 'package:c9p/app/components/app_not_data_widget.dart';
import 'package:c9p/app/components/app_scalford.dart';
import 'package:c9p/app/components/app_text.dart';
import 'package:c9p/app/components/app_text_field.dart';
import 'package:c9p/app/components/item_order.dart';
import 'package:c9p/app/config/constant.dart';
import 'package:c9p/app/config/resource.dart';
import 'package:c9p/app/data/model/order_model.dart';
import 'package:c9p/app/routes/app_pages.dart';
import 'package:c9p/app/theme/app_styles.dart';
import 'package:c9p/app/theme/colors.dart';
import 'package:c9p/app/utils/app_utils.dart';
import 'package:c9p/app/utils/log_utils.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:c9p/app/config/globals.dart' as globals;
import '../../../app_line.dart';
import '../../../config/app_translation.dart';
import '../../../config/globals.dart';
import '../controllers/tab_main_controller.dart';

class TabMainView extends GetView<TabMainController> {
  TabMainView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        fullStatusBar: true,
        isTabToHideKeyBoard: true,
        body: RefreshIndicator(
          color: colorGreen60,
          onRefresh: () async => controller.onRefresh(),
          child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  categoryWidget(context),
                  Stack(
                    children: [
                      Center(
                        child: Image.asset(
                          R.assetsPngHalfCircle,
                          height: 10.w,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 7.w, top: 3.h),
                        alignment: Alignment.bottomLeft,
                        child: SvgPicture.asset(
                          R.assetsSvgDecorate2,
                          height: 10.w,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.only(right: contentPadding),
                    alignment: Alignment.centerRight,
                    child: SvgPicture.asset(
                      R.assetsSvgDecorate3,
                      height: 5.5.w,
                    ),
                  ),
                  Opacity(
                    opacity: controller.isLoadNearOrder.value ? 1 : 1,
                    child: Padding(
                      padding: EdgeInsets.only(left: contentPadding),
                      child: AppText(
                        LocaleKeys.near_order.tr,
                        style: typoMediumTextBold.copyWith(
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                  nearOrderWidget(context),
                  itemSpace(),
                  SizedBox(
                    height: 162.h,
                    child: SvgPicture.asset(
                      R.assetsSvgHotline,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                  itemSpace(),
                  Opacity(
                      opacity: controller.isLoadPromotion.value ? 1 : 1,
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: contentPadding, top: 15.h, bottom: 10.h),
                        child: AppText(
                          LocaleKeys.promotion.tr,
                          style: typoMediumTextBold.copyWith(
                              fontWeight: FontWeight.w700),
                        ),
                      )),
                  promotionWidget(context),
                  const SizedBox(
                    height: 30,
                  )
                ],
              )),
        ));
  }

  Widget categoryWidget(BuildContext context) => Stack(
        children: [
          Positioned.fill(
              child: Container(
            padding: EdgeInsets.only(top: 30),
            alignment: Alignment.bottomCenter,
            child: SvgPicture.asset(R.assetsSvgDecorate4),
          )),
          Container(
            padding: EdgeInsets.only(
                bottom: 15.h, left: contentPadding, right: contentPadding),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(20.w),
                    bottomLeft: Radius.circular(20.w)),
                image: const DecorationImage(
                    image: AssetImage(R.assetsBackgroundHeaderTabMainPng),
                    fit: BoxFit.cover)),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).padding.top + 15.h),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                              child: Row(
                            children: [
                              Flexible(
                                  child: Obx(() => AppText(
                                      "Xin chào${controller.fullName.value.isNotEmpty ? " ${controller.fullName.value}" : ''}!",
                                      maxLine: 1,
                                      style: typoTitleHeader.copyWith()))),
                              const SizedBox(
                                width: 5,
                              ),
                              Image.asset(
                                R.assetsPngHand,
                                width: 18.w,
                              ),
                            ],
                          )),
                          const SizedBox(
                            width: 10,
                          ),
                          InkWell(
                            child: SvgPicture.asset(
                              R.assetsSvgCircleAvatar,
                              width: 28.w,
                            ),
                            onTap: () => controller.onClickProfile(context),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 17.h,
                      ),
                      AppTextField(
                        onTap: () => Get.toNamed(Routes.DEVELOPING),
                        readOnly: true,
                        isShowErrorText: false,
                        textStyle: typoSuperSmallTextBold.copyWith(
                            decoration: TextDecoration.none),
                        decoration: decorTextFieldCircle.copyWith(
                            contentPadding: EdgeInsets.all(9.h),
                            isDense: true,
                            hintText: LocaleKeys.find_order_at_here.tr,
                            hintStyle: typoSuperSmallTextBold.copyWith(
                                // fontSize: 12.sp,
                                color: colorText60),
                            prefixIconConstraints:
                                BoxConstraints(maxWidth: 45.w),
                            prefixIcon: Align(
                              alignment: Alignment.centerRight,
                              child: Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: SvgPicture.asset(R.assetsSvgSearch),
                              ),
                            )),
                      ),
                      SizedBox(
                        height: 17.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppText(
                                LocaleKeys.temp.tr,
                                style: typoSuperSmallText600.copyWith(
                                    color: colorWhite),
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Obx(() => AppText(
                                        controller.weatherModel.value.main?.temp
                                                ?.toString()
                                                .split('.')[0] ??
                                            '',
                                        style: typoSuperLargeTextBold.copyWith(
                                            fontSize: 30.sp,
                                            fontWeight: FontWeight.w700,
                                            color: colorYellow100),
                                      )),
                                  Obx(() => Visibility(
                                      visible: controller
                                          .weatherDescription.value.isNotEmpty,
                                      child: Padding(
                                        padding: EdgeInsets.only(top: 3.h),
                                        child: SvgPicture.asset(
                                          R.assetsSvgTemp,
                                          width: 6.w,
                                        ),
                                      ))),
                                  Obx(() => Visibility(
                                      visible: controller
                                          .weatherDescription.value.isNotEmpty,
                                      child: AppText(
                                        'C',
                                        style: typoSuperLargeTextBold.copyWith(
                                            fontSize: 30.sp,
                                            fontWeight: FontWeight.w700,
                                            color: colorYellow100),
                                      )))
                                ],
                              )
                            ],
                          ),
                          const Spacer(),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Transform.scale(
                                scale: 1.7,
                                child: Obx(() => AppNetworkImage(
                                      width: 30.w,
                                      fit: BoxFit.cover,
                                      source: controller
                                              .weatherDetail.value.icon ??
                                          AppConstant.URL_WEATHER_ICON_DEFAULT,
                                      errorSource:
                                          AppConstant.URL_WEATHER_ICON_DEFAULT,
                                    )),
                              ),
                              Obx(() => AppText(
                                    controller.weatherDescription.value,
                                    style: typoSuperSmallText600.copyWith(
                                        fontSize: 13.sp,
                                        fontWeight: FontWeight.w700,
                                        color: colorText0),
                                  ))
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          optionWidget(R.assetsSvgMenu, LocaleKeys.menu.tr,
                              TabMainAction.MENU, context),
                          Obx(() => controller.isBadge.value
                              ? Badge(
                                  position:
                                      BadgePosition.topEnd(end: -4, top: -15),
                                  badgeContent: Padding(
                                    padding: EdgeInsets.all(2.w),
                                    child: AppText(
                                      '!',
                                      style: typoSmallTextBold.copyWith(
                                          color: colorText0),
                                    ),
                                  ),
                                  child: optionWidget(
                                      R.assetsSvgOrder,
                                      LocaleKeys.order.tr,
                                      TabMainAction.ORDER,
                                      context),
                                )
                              : optionWidget(
                                  R.assetsSvgOrder,
                                  LocaleKeys.order.tr,
                                  TabMainAction.ORDER,
                                  context)),
                          optionWidget(
                              R.assetsSvgPromotionCircle,
                              LocaleKeys.promotion.tr,
                              TabMainAction.DISCTRICT,
                              context),
                          optionWidget(R.assetsSvgMore, LocaleKeys.more.tr,
                              TabMainAction.MORE, context)
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      );

  Widget itemSpace() => Container(
        height: 12,
        color: colorSeparatorListView,
      );

  Widget nearOrderWidget(BuildContext context) {
    return Obx(() => controller.isLoadNearOrder.value &&
            controller.lNearOrder.isNotEmpty
        ? const AppCircleLoading()
        : !controller.isLoadNearOrder.value && controller.lNearOrder.isEmpty
            ? AppNotDataWidget(message: LocaleKeys.not_order_pull_to_refresh.tr)
            : Container(
                margin: EdgeInsets.only(
                  // left: contentPadding,
                  top: contentPadding,
                ),
                height: 230.h,
                child: Stack(
                  children: [
                    Positioned.fill(
                        child: Align(
                      alignment: Alignment.bottomLeft,
                      child: SvgPicture.asset(
                        R.assetsSvgDots2,
                        height: 60.h,
                      ),
                    )),
                    Positioned.fill(
                        child: Container(
                      padding: EdgeInsets.only(left: 82.w),
                      alignment: Alignment.bottomCenter,
                      child: SvgPicture.asset(
                        R.assetsSvgDecorate1,
                        height: 14.h,
                      ),
                    )),
                    Obx(() => ListView.separated(
                        padding: EdgeInsets.only(
                          left: contentPadding,
                          bottom: contentPadding + 5,
                        ),
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (c, i) => itemNearOrder(
                            controller.lNearOrder[i], context, i,
                            onClickReOrder: (model) =>
                                controller.openReOrder(model, i),
                            onClickCallBack: (model) =>
                                controller.openOrderDetail(model, i)),
                        separatorBuilder: (i, c) => Container(
                              color: colorWhite,
                              width: 5.h,
                              // width: MediaQuery.of(context).size.width,
                            ),
                        itemCount: controller.lNearOrder.length))
                  ],
                ),
              ));
  }

  Widget itemNearOrder(OrderModel model, BuildContext context, int index,
      {required Function(OrderModel model) onClickReOrder,
      required Function(OrderModel model) onClickCallBack}) {
    logE("TAG model.isSelect: index: $index ${model.isSelect}");
    return InkWell(
      child: Container(
        width: MediaQuery.of(context).size.width / 1.85,
        margin: EdgeInsets.all(5.w),
        padding: EdgeInsets.only(top: 8.h, bottom: 8.h, left: 6.h, right: 6.h),
        decoration: BoxDecoration(
            color: colorWhite,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 2,
                blurRadius: 4,
                offset: const Offset(0, 0),
              ),
            ],
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
                color: model.isSelect! ? colorGreen55 : Colors.transparent)),
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.center,
              child: model.imageUrl != null && model.imageUrl.isNotEmpty
                  ? AppNetworkImage(
                      source: model.imageUrl,
                      height: 70.h,
                    )
                  : Image.asset(
                      R.assetsPngComSuon9p,
                      height: 70.h,
                      fit: BoxFit.fitHeight,
                    ),
            ),
            // Spacer(),
            SizedBox(
              height: 6.h,
            ),
            AppText(
              LocaleKeys.com_suong_9p.tr,
              style: typoSuperSmallText700,
            ),
            SizedBox(
              height: 5.h,
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                AppText('${Utils.formatMoney(model.amount ?? 0)}đ',
                    style: typoSuperSmallText700.copyWith(
                        color: colorSemanticRed100)),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                    child: AppText(
                        '${LocaleKeys.code.tr} #${model.id ?? 0}/${model.itemQty ?? 0} ${LocaleKeys.bowl_of_rice.tr}',
                        textAlign: TextAlign.start,
                        textOverflow: TextOverflow.ellipsis,
                        style: typoSuperSmallTextRegular.copyWith(
                            fontSize: 11.sp, color: colorText40))),
              ],
            ),
            SizedBox(
              height: 5.h,
            ),
            AppText(
              Utils.convertTimeToDDMMYYHHMMSS(
                  model.deliverTime ?? DateTime.now()),
              style: typoSuperSmallText500.copyWith(
                  color: colorText80, fontSize: 11.5.sp),
            ),
            const Spacer(),
            AppButton(
              borderRadius: 14.w,
              onPress: () => onClickReOrder(model),
              title: LocaleKeys.re_deliver.tr,
              textStyle: typoSuperSmallTextBold.copyWith(
                  fontSize: 13.sp, color: colorText0),
              backgroundColor: colorGreen55,
              height: 28.h,
              width: MediaQuery.of(context).size.width,
            )
          ],
        ),
      ),
      onTap: () => onClickCallBack(model),
    );
  }

  Widget promotionWidget(BuildContext context) {
    return Obx(() => controller.isLoadPromotion.value
        ? const AppCircleLoading()
        : controller.lPromotion.isEmpty
            ? const AppNotDataWidget(
                paddingTop: 0,
              )
            : CarouselSlider(
                options: CarouselOptions(
                    height: MediaQuery.of(context).size.width / 3.2,
                    viewportFraction: 0.85,
                    autoPlayInterval: const Duration(seconds: 2),
                    enlargeCenterPage: true,
                    enableInfiniteScroll: false,
                    enlargeStrategy: CenterPageEnlargeStrategy.height,
                    autoPlay: true),
                items: controller.lPromotion.map((model) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 5, right: 5),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: AppNetworkImage(
                              fit: BoxFit.cover,
                              source: model.imageUrl,
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }).toList(),
              ));
  }

  Widget optionWidget(String resource, String title, TabMainAction action,
          BuildContext context) =>
      InkWell(
        child: Column(
          children: [
            Container(
              width: 38.h,
              height: 40.h,
              padding: EdgeInsets.all(10.w),
              decoration: BoxDecoration(
                  color: colorWhite, borderRadius: BorderRadius.circular(10)),
              child: SvgPicture.asset(
                resource,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            AppText(
              title,
              style: typoSuperSmallTextBold.copyWith(
                  fontSize: 11.sp, color: colorText0),
            )
          ],
        ),
        onTap: () => controller.onClickAction(action, context),
      );
}

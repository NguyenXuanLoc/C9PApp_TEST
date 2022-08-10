import 'package:c9p/app/components/app_not_data_widget.dart';
import 'package:c9p/app/components/app_refresh_widget.dart';
import 'package:c9p/app/data/model/combo_best_seller_model.dart';
import 'package:c9p/app/theme/colors.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../components/app_network_image.dart';
import '../../../components/app_scalford.dart';
import '../../../components/app_text.dart';
import '../../../components/item_loading.dart';
import '../../../config/app_translation.dart';
import '../../../config/globals.dart';
import '../../../config/resource.dart';
import '../../../theme/app_styles.dart';
import '../controllers/tab_promotion_controller.dart';

class TabPromotionView extends GetView<TabPromotionController> {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        fullStatusBar: true,
        isTabToHideKeyBoard: true,
        appbar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: AppText(
            LocaleKeys.promotion.tr,
            style: typoTitleHeader,
          ),
          flexibleSpace: Container(
            alignment: Alignment.bottomCenter,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(R.assetsBackgroundHeaderTabMainPng),
                    fit: BoxFit.fitWidth)),
          ),
        ),
        body: AppRefreshWidget(
          body: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  color: colorWhite,
                  child: Column(
                    children: [
                      itemSpace(),
                      InkWell(
                          child: Container(margin: EdgeInsets.only(
                              left: contentPadding, right: contentPadding),
                            height: 35.h,
                            decoration: BoxDecoration(
                              border: Border.all(color: colorLine, width: 0.2),
                              borderRadius: BorderRadius.circular(17),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const SizedBox(
                                  width: 3,
                                ),
                                Stack(
                                  children: [
                                    Container(
                                      width: 40.w,
                                    ),
                                    Positioned.fill(
                                        child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: SvgPicture.asset(R.assetsSvgDots),
                                    )),
                                    Positioned.fill(
                                        child: Align(
                                      alignment: Alignment.centerRight,
                                      child: Image.asset(
                                        R.assetsPngGift,
                                        width: 25.w,
                                      ),
                                    ))
                                  ],
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 5),
                                  child: AppText(
                                    LocaleKeys.my_promotion.tr,
                                    style: typoSuperSmallTextBold,
                                  ),
                                ),
                                const Spacer(),
                                SvgPicture.asset(
                                  R.assetsSvgNextCircle,
                                  width: 12.w,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                              ],
                            ),
                          ),
                          onTap: () => controller.openMyCombo()),
                      itemSpace(),
                      Container(padding: EdgeInsets.only(left: contentPadding),
                        height: 130.h,
                        child: myCombWidget(),
                      ),
                      itemSpace(),
                      Obx(
                        () => Center(
                            child: AnimatedSmoothIndicator(
                                effect: ScrollingDotsEffect(
                                    spacing: 6.w,
                                    radius: 100,
                                    dotWidth: 6.w,
                                    dotHeight: 6.w,
                                    dotColor: colorBackgroundGrey5,
                                    activeDotColor: colorGreen60),
                                activeIndex:
                                    controller.currentIndexMyCombo.value,
                                count: controller.lMyCombo.length)),
                      ),
                      itemSpace(),
                    ],
                  ),
                ),
                Container(
                  height: 15,
                  color: colorSeparatorListView,
                ),
                itemSpace(),
                Padding(
                  padding: EdgeInsets.only(
                    left: contentPadding,
                    right: contentPadding,
                  ),
                  child: Row(
                    children: [
                      AppText(
                        LocaleKeys.combo_selling.tr,
                        style: typoSmallText700,
                      ),
                      const Spacer(),
                      InkWell(
                        child: AppText(
                          LocaleKeys.see_more.tr,
                          style: typoSuperSmallTextBold.copyWith(
                              fontSize: 11.sp, color: colorGreen55),
                        ),
                        onTap: () => controller.onClickSeeMore(),
                      ),
                      const Icon(
                        Icons.arrow_forward_ios_outlined,
                        size: 10,
                        color: colorGreen55,
                      )
                    ],
                  ),
                ),
                itemSpace(),
                SizedBox(
                  height: 230.h,
                  child: bestSellerWidget(),
                )
              ],
            ),
          ),
          onRefresh: () => controller.onRefresh(),
        ));
  }

  Widget myCombWidget() => Obx(() => controller.isLoadingMyCombo.value
      ? const Center(child: ItemLoading())
      : controller.lMyCombo.isEmpty
          ? const AppNotDataWidget()
          : CarouselSlider(
              options: CarouselOptions(
                  height: 130.h,
                  viewportFraction: 0.95,
                  // enlargeCenterPage: true,
                  enableInfiniteScroll: false,
                  disableCenter: true,
                  padEnds: false,
                  onPageChanged: (index, reason) =>
                      controller.setIndexMyCombo(index),
                  enlargeStrategy: CenterPageEnlargeStrategy.height),
              items: controller.lMyCombo.map((model) {
                return Builder(
                  builder: (BuildContext context) {
                    return Padding(
                      padding: EdgeInsets.only(right: 10.w),
                      child: InkWell(onTap: ()=>controller.openOrder(model),
                          child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: AppNetworkImage(
                            fit: BoxFit.cover,
                            width: MediaQuery.of(context).size.width,
                            source: model.sale?.img,
                            errorSource: errorBanner,
                          ),
                        ),
                      )),
                    );
                  },
                );
              }).toList(),
            ));

  Widget bestSellerWidget() => Obx(() => controller.isLoadingBestSeller.value
      ? const Center(child: ItemLoading())
      : controller.lComboSellingModel.isEmpty
          ? const AppNotDataWidget()
          : Padding(
              padding: EdgeInsets.only(left: contentPadding),
              child: CarouselSlider(
                options: CarouselOptions(
                    viewportFraction: 0.6,
                    enlargeCenterPage: true,
                    enableInfiniteScroll: false,
                    disableCenter: true,
                    padEnds: false,
                    enlargeStrategy: CenterPageEnlargeStrategy.height),
                items: controller.lComboSellingModel
                    .map((model) => Builder(
                          builder: (BuildContext context) =>
                              itemBestSeller(model, context),
                        ))
                    .toList(),
              ),
            ));

  Widget itemBestSeller(ComboSellingModel model, BuildContext context) =>
      InkWell(
        child: SizedBox(
          width: MediaQuery.of(context).size.width / 1.7,
          child: Container(
            margin: EdgeInsets.only(right: 10.w, bottom: 10.w, left: 2, top: 2),
            decoration: BoxDecoration(
              color: colorWhite,
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20)),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 1,
                    blurRadius: 1)
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  AppNetworkImage(
                    fit: BoxFit.cover,
                    source: model.img,
                    height: 150.h,
                    errorSource: errorBanner,
                    width: MediaQuery.of(context).size.width,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Spacer(),
                  Padding(
                    padding: EdgeInsets.only(left: 8.w, right: 8.w),
                    child: AppText(
                      model.name ?? '',
                      style: typoSmallTextBold,
                    ),
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(left: 8.w, right: 8.w, bottom: 8.w),
                    child: AppText(
                      model.description ?? '',
                      style: typoSuperSmallText500.copyWith(fontSize: 11.sp),
                      maxLine: 2,
                      textOverflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        onTap: () => controller.openSaleCombo(model),
      );

  Widget itemSpace() => const SizedBox(
        height: 20,
      );
}

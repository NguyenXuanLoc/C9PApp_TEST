import 'package:c9p/app/data/model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';

import '../../../components/app_button.dart';
import '../../../components/app_loading_widget.dart';
import '../../../components/app_network_image.dart';
import '../../../components/app_not_data_widget.dart';
import '../../../components/app_refresh_widget.dart';
import '../../../components/app_scalford.dart';
import '../../../components/app_text.dart';
import '../../../components/item_loading.dart';
import '../../../config/app_translation.dart';
import '../../../config/globals.dart';
import '../../../config/resource.dart';
import '../../../data/model/my_combo_model.dart';
import '../../../theme/app_styles.dart';
import '../../../theme/colors.dart';
import '../../../utils/app_utils.dart';
import '../controllers/menu_controller.dart';

class MenuView extends GetView<MenuController> {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        fullStatusBar: true,
        isTabToHideKeyBoard: true,
        appbar: appbar(),
        body: AppRefreshWidget(
          body: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Obx(() =>
                controller.isLoadingMyCombo.value && controller.lMenu.isEmpty
                    ? const AppCircleLoading()
                    : (controller.lMenu.isEmpty
                        ? Stack(
                            children: [
                              ListView(
                                physics: const AlwaysScrollableScrollPhysics(),
                              ),
                              const AppNotDataWidget()
                            ],
                          )
                        : listComboWidget())),
          ),
          onRefresh: () => controller.onRefresh(),
        ));
  }

  Widget listComboWidget() => ListView.separated(
      physics: AlwaysScrollableScrollPhysics(),
      controller: controller.scrollController,
      itemBuilder: (context, index) => index == controller.lMenu.length
          ? const ItemLoading()
          : itemMenu(controller.lMenu[index], context),
      separatorBuilder: (c, i) => Container(
            height: 10,
            color: colorSeparatorListView,
          ),
      itemCount: controller.isLoadingMyCombo.value &&
              controller.lMenu.isNotEmpty &&
              !controller.isReadEnd.value
          ? controller.lMenu.length + 1
          : controller.lMenu.length);

  Widget itemMenu(ProductModel model, BuildContext context) => Padding(
        padding: EdgeInsets.all(contentPadding),
        child: InkWell(
          child: Stack(
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 40.h),
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)),
                  child: SizedBox(
                    height: 137.h,
                    width: MediaQuery.of(context).size.width,
                    child: AppNetworkImage(
                      fit: BoxFit.cover,
                      source: model.img,
                      errorSource: errorBanner,
                      width: MediaQuery.of(context).size.width,
                    ),
                  ),
                ),
              ),
              Positioned.fill(
                  child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  padding: EdgeInsets.only(
                      left: contentPadding,
                      right: contentPadding - 2,
                      top: contentPadding - 5,
                      bottom: contentPadding - 5),
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          spreadRadius: 2,
                          blurRadius: 4,
                          offset: const Offset(0, 0.5),
                        )
                      ],
                      borderRadius: BorderRadius.circular(15),
                      color: colorWhite),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          AppText(
                            model.name ?? '',
                            style: typoSuperSmallText600,
                          ),
                          const SizedBox(
                            height: 3,
                          ),
                          AppText(
                            '${Utils.formatMoney(model.price ?? 0)}đ',
                            style: typoSmallText700.copyWith(
                                color: colorSemanticRed100),
                          ),
                        ],
                      ),
                      const Spacer(),
                      AppButton(
                        backgroundColor: colorGreen40,
                        onPress: () =>controller.openProductDetail(model),
                        borderRadius: 15,
                        height: 26.h,
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.w, vertical: 4.h),
                        title: LocaleKeys.orders.tr,
                        textStyle:
                            typoSuperSmallText600.copyWith(color: colorText0),
                      )
                    ],
                  ),
                ),
              ))
            ],
          ),
          // onTap: () => controller.openComboDetail(model),
        ),
      );

  Widget itemSpace() => const SizedBox(
        height: 8,
      );

  PreferredSizeWidget appbar() => AppBar(
        leading: Padding(
          padding: EdgeInsets.only(left: contentPadding),
          child: InkWell(
            child: SvgPicture.asset(
              R.assetsBackSvg,
              color: colorWhite,
            ),
            onTap: () => Get.back(),
          ),
        ),
        leadingWidth: 28.w,
        automaticallyImplyLeading: true,
        centerTitle: true,
        title: AppText(
          LocaleKeys.menu.tr,
          style: typoTitleHeader,
        ),
        flexibleSpace: Container(
          alignment: Alignment.bottomCenter,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(R.assetsBackgroundHeaderTabMainPng),
                  fit: BoxFit.fitWidth)),
        ),
      );
}

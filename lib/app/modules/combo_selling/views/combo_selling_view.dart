import 'package:c9p/app/components/app_button.dart';
import 'package:c9p/app/components/app_loading_widget.dart';
import 'package:c9p/app/components/app_network_image.dart';
import 'package:c9p/app/components/app_not_data_widget.dart';
import 'package:c9p/app/components/item_loading.dart';
import 'package:c9p/app/data/model/combo_best_seller_model.dart';
import 'package:c9p/app/data/model/my_combo_model.dart';
import 'package:c9p/app/utils/log_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:get_cli/common/utils/json_serialize/json_ast/json_ast.dart';

import '../../../components/app_refresh_widget.dart';
import '../../../components/app_scalford.dart';
import '../../../components/app_text.dart';
import '../../../config/app_translation.dart';
import '../../../config/globals.dart';
import '../../../config/resource.dart';
import '../../../theme/app_styles.dart';
import '../../../theme/colors.dart';
import '../../../utils/app_utils.dart';

import '../controllers/combo_selling_controller.dart';

class ComboSellingView extends GetView<ComboSellingController> {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        fullStatusBar: true,
        isTabToHideKeyBoard: true,
        appbar: AppBar(
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
            LocaleKeys.combo_selling.tr,
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
          body: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Obx(() =>
                controller.isLoadingMyCombo.value && controller.lMyCombo.isEmpty
                    ? const AppCircleLoading()
                    : (controller.lMyCombo.isEmpty
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
      physics: const AlwaysScrollableScrollPhysics(),
      controller: controller.scrollController,
      itemBuilder: (context, index) => index == controller.lMyCombo.length
          ? const ItemLoading()
          : itemComboWidget(controller.lMyCombo[index], context),
      separatorBuilder: (c, i) => Container(
            height: 10,
            color: colorSeparatorListView,
          ),
      itemCount: controller.lMyCombo
          .length /*controller.isLoadingMyCombo.value &&
              controller.lMyCombo.isNotEmpty &&
              !controller.isReadEnd.value
          ? controller.lMyCombo.length + 1
          : controller.lMyCombo.length*/
      );

  Widget itemComboWidget(ComboSellingModel model, BuildContext context) =>
      Container(
        height: 130.h,
        padding: EdgeInsets.all(contentPadding),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(17),
              child: AppNetworkImage(
                source: model.img,
                fit: BoxFit.cover,
                height: 110.h,
                errorSource: errorBanner,
                width: 110.h,
              ),
            ),
            SizedBox(
              width: 15.w,
            ),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppText(
                  model.name ?? "",
                  style: typoSmallTextBold.copyWith(
                      fontSize: 14.sp, color: colorGreen55),
                ),
                Row(
                  children: [
                    AppText(
                      "${Utils.formatMoney(int.parse(model.price ?? '0'))}đ",
                      style: typoSuperSmallText700.copyWith(
                          color: colorSemanticRed100),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: AppText(
                      "${LocaleKeys.economy.tr} ${Utils.formatMoney((model.discount ?? 1) * ricePrice + (model.getFree ?? 1) * ricePrice - int.parse(model.price!))}đ",
                      style: typoSuperSmallTextRegular.copyWith(
                          fontSize: 12.sp, color: colorGrey50),
                      textOverflow: TextOverflow.ellipsis,
                    ))
                  ],
                ),
                AppText(
                  model.description ?? '',
                  style: typoSuperSmallTextRegular.copyWith(
                      fontSize: 11.sp, color: colorText85),
                  maxLine: 2,
                  textOverflow: TextOverflow.ellipsis,
                ),
                InkWell(
                  onTap: () => controller.onClickByNew(model),
                  child: Container(
                    height: 22.h,
                    alignment: Alignment.center,
                    width: 80.w,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: colorGreen40),
                    child: AppText(
                      LocaleKeys.buy_now.tr,
                      style: typoSuperSmallText600.copyWith(
                          color: colorWhite, fontSize: 12.sp),
                    ),
                  ),
                )
              ],
            ))
          ],
        ),
      );

  Widget itemSpace() => const SizedBox(
        height: 7,
      );
}

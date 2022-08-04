import 'package:c9p/app/components/app_button.dart';
import 'package:c9p/app/components/app_loading_widget.dart';
import 'package:c9p/app/components/app_network_image.dart';
import 'package:c9p/app/components/app_not_data_widget.dart';
import 'package:c9p/app/components/item_loading.dart';
import 'package:c9p/app/data/model/combo_best_seller_model.dart';
import 'package:c9p/app/data/model/my_combo_model.dart';
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
import '../controllers/my_combo_controller.dart';

class MyComboView extends GetView<MyComboController> {
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
            LocaleKeys.my_promotion.tr,
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
      physics: AlwaysScrollableScrollPhysics(),
      controller: controller.scrollController,
      itemBuilder: (context, index) => index == controller.lMyCombo.length
          ? const ItemLoading()
          : itemComboWidget(controller.lMyCombo[index], context),
      separatorBuilder: (c, i) => Container(
            height: 10,
            color: colorSeparatorListView,
          ),
      itemCount: controller.isLoadingMyCombo.value &&
              controller.lMyCombo.isNotEmpty &&
              !controller.isReadEnd.value
          ? controller.lMyCombo.length + 1
          : controller.lMyCombo.length);

  Widget itemComboWidget(MyComboModel model, BuildContext context) => Padding(
        padding: EdgeInsets.all(contentPadding),
        child: InkWell(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(
                model.sale?.name ?? '',
                style: typoMediumText700,
              ),
              itemSpace(),
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: SizedBox(
                  height: 123.h,
                  width: MediaQuery.of(context).size.width,
                  child: AppNetworkImage(
                      fit: BoxFit.cover, source: model.sale?.img),
                ),
              ),
              itemSpace(),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                      "${Utils.formatMoney(int.parse(model.sale?.price ?? "0"))}đ",
                      style: typoNormalText700.copyWith(
                          color: colorSemanticRed100)),
                  const Spacer(),
                  Container(
                    padding: EdgeInsets.only(
                        left: 5.w, right: 5.w, top: 3, bottom: 3),
                    decoration: BoxDecoration(
                        color: colorOrange40.withOpacity(0.25),
                        borderRadius: BorderRadius.circular(5)),
                    child: AppText(
                      LocaleKeys.payment_by_momo_money_vnpay.tr,
                      style: typoSuperSmallText500.copyWith(
                          fontSize: 10.sp, color: colorOrange40),
                    ),
                  ),
                  const Spacer()
                ],
              ),
              itemSpace(),
              Container(
                height: 0.1,
                color: colorBlack,
              ),
              itemSpace(),
              Row(
                children: [
                  AppText(
                    Utils.convertTimeToDDMMYYHHMMSS(
                        model.sale?.endDate ?? DateTime.now()),
                    style: typoSuperSmallText500,
                  ),
                  const Spacer(),
                  AppText(
                    "${LocaleKeys.still.tr} ${model.remainsCombo ?? 0} ${LocaleKeys.slot.tr}",
                    style:
                        typoSuperSmallTextRegular.copyWith(color: colorGreen50),
                  )
                ],
              ),
              itemSpace(),
              Container(
                height: 0.1,
                color: colorBlack,
              ),
              itemSpace(),
              Row(
                children: [
                  Image.asset(
                    R.assetsPngPig,
                    width: 20.w,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  AppText(
                    "${LocaleKeys.economy.tr} ${Utils.formatMoney((int.parse(model.sale?.price ?? "0") / (100 - (model.sale?.discount ?? 0)) * (model.sale?.discount ?? 0)).toInt())}đ",
                    style:
                        typoSuperSmallTextRegular.copyWith(color: colorGreen55),
                  ),
                  const Spacer(),
                  AppButton(
                    onPress: () => controller.onClickOrderRice(model),
                    title: LocaleKeys.order_rice.tr,
                    textStyle: typoSmallTextBold.copyWith(color: colorWhite),
                    backgroundColor: colorGreen40,
                    padding: EdgeInsets.only(left: 20.w, right: 20.w),
                    height: 27.h,
                    shapeBorder: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                  )
                ],
              )
            ],
          ),
          onTap: () => controller.openComboDetail(model),
        ),
      );

  Widget itemSpace() => const SizedBox(
        height: 8,
      );
}

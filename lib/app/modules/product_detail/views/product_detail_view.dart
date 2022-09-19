import 'package:c9p/app/components/app_button.dart';
import 'package:c9p/app/components/app_line_space.dart';
import 'package:c9p/app/components/app_network_image.dart';
import 'package:c9p/app/components/app_scalford.dart';
import 'package:c9p/app/components/app_text.dart';
import 'package:c9p/app/config/app_translation.dart';
import 'package:c9p/app/theme/app_styles.dart';
import 'package:c9p/app/utils/log_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';

import '../../../config/globals.dart';
import '../../../config/resource.dart';
import '../../../theme/colors.dart';
import '../../../utils/app_utils.dart';
import '../controllers/product_detail_controller.dart';

class ProductDetailView extends GetView<ProductDetailController> {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        fullStatusBar: true,
        body: Stack(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        const AspectRatio(
                          aspectRatio: 1 / 0.8,
                          child: AppNetworkImage(
                            source:
                                'https://cdnimg.vietnamplus.vn/t620/uploaded/ngtnnn/2022_07_27/2707banhxeo.jpg' /*controller.model.img*/,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned.fill(
                            child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            height: contentPadding,
                            decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(20),
                                    topLeft: Radius.circular(20)),
                                color: colorWhite),
                          ),
                        )),
                        Padding(
                          padding: EdgeInsets.only(
                              left: contentPadding,
                              top: 10.h + MediaQuery.of(context).padding.top),
                          child: Container(
                            padding: EdgeInsets.all(2.w),
                            decoration: BoxDecoration(
                                color: colorGrey10,
                                borderRadius: BorderRadius.circular(100)),
                            child: IconButton(
                                splashRadius: 20,
                                constraints: BoxConstraints(
                                    maxHeight: 30.w, maxWidth: 30.w),
                                padding: const EdgeInsets.all(0),
                                onPressed: () => Get.back(),
                                icon: SvgPicture.asset(R.assetsBackSvg)),
                          ),
                        )
                      ],
                    ),
                    paddingWidget(AppText(
                      controller.model.name ?? '',
                      style: typoMediumText700.copyWith(color: colorGreen55),
                    )),
                    SizedBox(
                      height: 5.h,
                    ),
                    paddingWidget(AppText(
                      '${Utils.formatMoney(controller.model.price ?? 0)}đ',
                      style:
                          typoSmallText700.copyWith(color: colorSemanticRed100),
                    )),
                    itemSpace(),
                    paddingWidget(AppText(
                      controller.model.description ?? '0',
                      style: typoSuperSmallTextRegular,
                    )),
                    itemSpace(),
                    paddingWidget(counterWidget(context)),
                    itemSpace(),
                    const AppLineSpace(),
                    itemSpace(),
                    paddingWidget(AppText(
                      LocaleKeys.other_dish.tr,
                      style: typoSmallTextBold,
                    )),
                    itemSpace(),
                    otherDishWidget(context)
                  ],
                ),
              ),
            ),
            Positioned.fill(
                child: Align(
              alignment: Alignment.bottomCenter,
              child: cartWidget(context),
            ))
          ],
        ));
  }

  Widget cartWidget(BuildContext context) => Padding(
        padding: EdgeInsets.only(
            left: contentPadding, right: contentPadding, top: 7, bottom: 7),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7),
                  border: Border.all(color: colorGreen55)),
              padding: EdgeInsets.all(7.w),
              child: Row(
                children: [
                  const SizedBox(width: 3),
                  SvgPicture.asset(
                    R.assetsSvgCart,
                    width: 15.w,
                  ),
                  const SizedBox(width: 10),
                  AppText(
                    '4',
                    style: typoSuperSmallText500.copyWith(color: colorGreen55),
                  ),
                  const SizedBox(width: 3),
                ],
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
                child: AppButton(
              height: 33.h,
              shapeBorder: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              width: MediaQuery.of(context).size.width,
              onPress: () {},
              backgroundColor: colorGreen55,
              title: 'Thêm vào giỏ hàng: 180.000đ',
              textStyle: typoSuperSmallText600.copyWith(color: colorText0),
            ))
          ],
        ),
      );

  Widget counterWidget(BuildContext context) => Container(
        height: 27.h,
        width: MediaQuery.of(context).size.width / 5,
        decoration: BoxDecoration(
          color: colorWhite,
          boxShadow: [
            BoxShadow(
              color: colorBlack.withOpacity(0.2),
              spreadRadius: 0,
              blurRadius: 2,
              offset: const Offset(0, 0),
            ),
          ],
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const SizedBox(),
            InkWell(
                onTap: () => controller.increasing(),
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: Icon(
                    Icons.add,
                    size: 12.w,
                  ),
                )),
            const SizedBox(
              width: 2,
            ),
            Obx(() => AppText(
                  controller.counter.value.toString(),
                  style: typoSuperSmallText600,
                )),
            const SizedBox(
              width: 2,
            ),
            InkWell(
                onTap: () => controller.decreasing(),
                child: Padding(
                  padding: EdgeInsets.all(9.w),
                  child: Container(
                    color: colorBlack,
                    width: 5.w,
                    height: 1,
                  ),
                )),
            const SizedBox()
          ],
        ),
      );

  Widget itemSpace() => SizedBox(
        height: 11.h,
      );

  Widget paddingWidget(Widget widget) => Padding(
        padding: EdgeInsets.only(left: contentPadding, right: contentPadding),
        child: widget,
      );

  Widget otherDishWidget(BuildContext context) => ListView.separated(
      padding: EdgeInsets.only(left: contentPadding, right: contentPadding),
      itemBuilder: (c, i) => itemProduct(context),
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      primary: false,
      separatorBuilder: (c, i) => Padding(
            padding:
                EdgeInsets.only(top: contentPadding, bottom: contentPadding),
            child: Container(
              height: 0.5,
              width: MediaQuery.of(context).size.width,
              color: colorGrey85.withOpacity(0.33),
            ),
          ),
      itemCount: 2);

  Widget itemProduct(BuildContext context) => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: AppNetworkImage(
              source:
                  'https://cdnimg.vietnamplus.vn/t620/uploaded/ngtnnn/2022_07_27/2707banhxeo.jpg',
              height: 80.w,
              width: 80.w,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(
                'Cơm gà ngon',
                maxLine: 2,
                style: typoSuperSmallText600.copyWith(
                    fontSize: 13.5.sp, color: colorGreen55),
              ),
              SizedBox(
                height: 8,
              ),
              AppText(
                Utils.formatMoney(45000) + 'đ',
                style:
                    typoSuperSmallText700.copyWith(color: colorSemanticRed100),
              )
            ],
          ))
        ],
      );
}

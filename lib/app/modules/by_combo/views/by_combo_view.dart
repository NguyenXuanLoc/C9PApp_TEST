import 'package:c9p/app/components/app_button.dart';
import 'package:c9p/app/components/app_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';

import '../../../components/app_scalford.dart';
import '../../../components/app_text.dart';
import '../../../components/app_text_field.dart';
import '../../../config/app_translation.dart';
import '../../../config/globals.dart';
import '../../../config/resource.dart';
import '../../../theme/app_styles.dart';
import '../../../theme/colors.dart';
import '../controllers/by_combo_controller.dart';

class ByComboView extends GetView<ByComboController> {
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
            LocaleKeys.by_sale_combo.tr,
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
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(contentPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  controller.model.name ?? '',
                  style: typoMediumText700,
                ),
                itemSpace(),
                ClipRRect(
                  borderRadius: BorderRadius.circular(17),
                  child: AppNetworkImage(
                    source:controller. model.img,
                    errorSource: errorBanner,
                    height: 120.h,
                    width: MediaQuery.of(context).size.width, fit: BoxFit.cover,
                  ),
                ),
                itemSpace(),
                itemSpace(),
                itemSpace(),
                Obx(() => itemContent(LocaleKeys.full_name.tr, '',
                    controller.errorName.value, controller.fullNameController,
                    keyboardType: TextInputType.name)),
                Obx(() => itemContent(LocaleKeys.phone_number.tr, '',
                    controller.errorPhone.value, controller.phoneController,
                    keyboardType: TextInputType.phone)),
                Obx(() => itemContent(
                      LocaleKeys.qty_package.tr,
                      '',
                      controller.errorQty.value,
                      controller.qtyController,
                      contentWidget: qtyWidget(),
                    )),
                Obx(
                  () => AppText(
                    controller.errorQty.value,
                    style: typoNormalTextRegular.copyWith(
                        color: colorSemanticRed100, fontSize: 11.sp),
                  ),
                ),
                itemSpace(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SvgPicture.asset(
                      R.assetsSvgOpenGift,
                      width: 10.w,
                    ),
                    const SizedBox(
                      width: 7,
                    ),
                    Expanded(
                        child: RichText(
                      text: TextSpan(
                          text:
                              "${LocaleKeys.you_order_success.tr} ${controller.model.discount} ",
                          style: typoSuperSmallText500.copyWith(
                              fontSize: 10.sp, color: colorOrange50,fontStyle: FontStyle.italic),
                          children: [
                            TextSpan(
                              text:
                                  "${LocaleKeys.rice_portion_and_free.tr} ${controller.model.getFree} ${LocaleKeys.bowl_of_rice.tr}",
                            )
                          ]),
                    ))
                  ],
                ),
                itemSpace(),
                itemSpace(),
                AppButton(
                  onPress: () => controller.onClickContinues(),
                  title: LocaleKeys.continues.tr,
                  textStyle: typoSmallTextBold.copyWith(color: colorWhite),
                  height: 37.h,
                  backgroundColor: colorGreen55,
                  width: MediaQuery.of(context).size.width,
                  shapeBorder: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(17)),
                )
              ],
            ),
          ),
        ));
  }

  Widget itemContent(String title, String hint, String errorMessage,
          TextEditingController textEditingController,
          {TextInputType? keyboardType,
          bool? readOnly,
          Widget? suffixIcon,
          Widget? contentWidget,
          FocusNode? focusNode,VoidCallback? onSubmitted}) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(
            title,
            style: typoSuperSmallText600,
          ),
          SizedBox(
            height: 5.h,
          ),
          contentWidget ??
              AppTextField(onSubmitted: (text){},
                focusNode: focusNode,
                errorText: errorMessage,
                controller: textEditingController,
                readOnly: readOnly,
                textInputAction: TextInputAction.next,
                keyboardType: keyboardType,
                textStyle: typoSuperSmallTextBold.copyWith(),
                decoration: decorTextFieldOval.copyWith(
                  suffixIcon: suffixIcon,
                  hintText: hint,
                  hintStyle:
                      typoSuperSmallTextBold.copyWith(color: colorText60),
                ),
              )
        ],
      );

  Widget qtyWidget() => TypeAheadField(
        hideSuggestionsOnKeyboardHide: true,
        direction: AxisDirection.up,
        suggestionsBoxDecoration:
            const SuggestionsBoxDecoration(color: colorWhite, elevation: 0.2),
        textFieldConfiguration: TextFieldConfiguration(
            controller: controller.qtyController,
            keyboardType: TextInputType.number,
            maxLines: 1,
            // onTap: () => controller.scrollToBottom(),
            autofocus: false,
            style: typoSuperSmallTextBold.copyWith(),
            decoration: decorTextFieldOval.copyWith(
              hintText: LocaleKeys.input_qty.tr,
              hintStyle: typoSuperSmallTextBold.copyWith(color: colorText60),
              suffixIcon: Padding(
                padding: EdgeInsets.only(right: 7.w),
                child: const Icon(Icons.keyboard_arrow_down_rounded,
                    color: colorBlack),
              ),
            )),
        itemBuilder: (context, String suggestion) {
          return Padding(
            padding: EdgeInsets.all(10.w),
            child: Text(
              suggestion,
              style: typoSuperSmallTextBold.copyWith(),
            ),
          );
        },
        noItemsFoundBuilder: (c) => AppText(
          '',
          style: typoSmallTextRegular,
        ),
        onSuggestionSelected: (String suggest) => controller.setQty(suggest),
        suggestionsCallback: (pattern) {
          return controller.suggestCount();
        },
      );

  Widget itemSpace() => const SizedBox(
        height: 10,
      );
}

import 'package:c9p/app/components/app_button.dart';
import 'package:c9p/app/components/app_loading_widget.dart';
import 'package:c9p/app/components/app_scalford.dart';
import 'package:c9p/app/components/app_text.dart';
import 'package:c9p/app/components/app_text_field.dart';
import 'package:c9p/app/config/app_translation.dart';
import 'package:c9p/app/config/globals.dart';
import 'package:c9p/app/theme/app_styles.dart';
import 'package:c9p/app/theme/colors.dart';
import 'package:c9p/app/utils/tag_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

import 'package:get/get.dart';
import 'package:c9p/app/config/resource.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../data/model/address_model.dart';

class OrderView extends StatelessWidget {
  var controller = TagUtils().findCreateOderController();
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        isTabToHideKeyBoard: true,
        appbar: AppBar(
          leading: IconButton(
            splashRadius: 20,
            constraints: BoxConstraints(maxWidth: 20.w),
            icon: SvgPicture.asset(
              R.assetsBackSvg,
              color: colorWhite,
            ),
            onPressed: () => Get.back(),
          ),
          title: AppText(
            LocaleKeys.add_order.tr,
            style: typoTitleHeader.copyWith(color: colorText0),
          ),
          centerTitle: true,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(R.assetsBackgroundHeaderTabMainPng),
                    fit: BoxFit.fitWidth)),
          ),
        ),
        fullStatusBar: true,
        body: SingleChildScrollView(
          controller: controller!.scrollController,
          padding: EdgeInsets.all(contentPadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 170.h,
                child: PageView(
                  controller: controller!.pageController,
                  children: controller!.lDescriptionImage
                      .map((e) => Image.asset(e, fit: BoxFit.fitHeight))
                      .toList(),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Center(
                child: Obx(() => AnimatedSmoothIndicator(
                      activeIndex: controller!.currentIndex.value,
                      count: controller!.lDescriptionImage.length,
                      effect: ScrollingDotsEffect(
                          spacing: 6.w,
                          radius: 100,
                          dotWidth: 6.w,
                          dotHeight: 6.w,
                          dotColor: colorBackgroundGrey5,
                          activeDotColor: colorGreen60),
                    )),
              ),
              itemSpace(),
              AppText(
                LocaleKeys.full_name.tr,
                style: typoSuperSmallTextBold,
              ),
              itemSpace(),
              Obx(
                () => AppTextField(
                  errorText: controller!.errorFullName.value,
                  controller: controller!.fullNameController,
                  textInputAction: TextInputAction.next,
                  textStyle: typoSuperSmallTextBold.copyWith(),
                  decoration: decorTextFieldOval.copyWith(
                    hintText: LocaleKeys.input_full_name.tr,
                    hintStyle:
                        typoSuperSmallTextBold.copyWith(color: colorText60),
                  ),
                ),
              ),
              AppText(
                LocaleKeys.phone_number.tr,
                style: typoSuperSmallTextBold,
              ),
              itemSpace(),
              Obx(
                () => AppTextField(
                  errorText: controller!.errorPhoneNumber.value,
                  controller: controller!.phoneController,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.phone,
                  textStyle: typoSuperSmallTextBold.copyWith(),
                  decoration: decorTextFieldOval.copyWith(
                    hintText: LocaleKeys.input_phone_number_at_here.tr,
                    hintStyle:
                        typoSuperSmallTextBold.copyWith(color: colorText60),
                  ),
                ),
              ),
              AppText(
                LocaleKeys.address_order.tr,
                style: typoSuperSmallTextBold,
              ),
              itemSpace(),
              TypeAheadField(
                hideSuggestionsOnKeyboardHide: true,
                debounceDuration: const Duration(seconds: 1),
                loadingBuilder: (c) => const AppCircleLoading(),
                suggestionsBoxDecoration: const SuggestionsBoxDecoration(
                    color: colorWhite, elevation: 0.2),
                textFieldConfiguration: TextFieldConfiguration(
                    controller: controller!.addressController,
                    maxLines: 1,
                    onTap: () => controller!.scrollToBottom(),
                    autofocus: false,
                    style: typoSuperSmallTextBold.copyWith(),
                    decoration: decorTextFieldOval.copyWith(
                      hintText: LocaleKeys.input_address_at_here.tr,
                      hintStyle:
                          typoSuperSmallTextBold.copyWith(color: colorText60),
                      suffixIcon: Padding(
                        padding: EdgeInsets.only(right: 7.w),
                        child: const Icon(Icons.keyboard_arrow_down_rounded,
                            color: colorBlack),
                      ),
                    )),
                itemBuilder: (context, Prediction suggestion) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          R.assetsSvgLocationCircle,
                          color: colorGreen60,
                          width: 30.w,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppText(
                              suggestion.structuredFormatting?.mainText ?? '',
                              maxLine: 1,
                              style: typoSuperSmallTextBold.copyWith(),
                            ),
                            AppText(
                              suggestion.structuredFormatting?.secondaryText ??
                                  '',
                              maxLine: 1,
                              textOverflow: TextOverflow.ellipsis,
                              style: typoSuperSmallTextRegular.copyWith(
                                  color: colorText70, fontSize: 12.sp),
                            )
                          ],
                        ))
                      ],
                    ),
                  );
                },
                noItemsFoundBuilder: (c) => AppText(
                  LocaleKeys.not_find_address_please_try_again.tr,
                  style: typoSuperSmallTextRegular.copyWith(
                      color: colorText70, fontSize: 12.sp),
                ),
                onSuggestionSelected: (Prediction address) =>
                    controller!.setAddress(address),
                suggestionsCallback: (pattern) {
                  return controller!.filterAddress(pattern);
                },
              ),
              const SizedBox(
                height: 1,
              ),
              Obx(
                () => Padding(
                  padding: const EdgeInsets.only(bottom: 0),
                  child: AppText(
                    controller!.errorAddress.value,
                    style: typoNormalTextRegular.copyWith(
                        color: colorSemanticRed100, fontSize: 11.sp),
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText(
                        LocaleKeys.delivery_date.tr,
                        style: typoSuperSmallTextBold,
                      ),
                      itemSpace(),
                      Obx(() => AppTextField(
                          isShowErrorText: false,
                          readOnly: true,
                          onTap: () => controller!.pickDate(context),
                          controller: controller!.dateController,
                          errorText: controller!.errorDate.value,
                          textInputAction: TextInputAction.next,
                          textStyle: typoSuperSmallTextBold.copyWith(),
                          decoration: decorTextFieldOval.copyWith(
                            hintText: 'mm/dd/yyy',
                            suffixIconConstraints: BoxConstraints(
                              maxHeight: 20.h,
                            ),
                            suffixIcon: Padding(
                              padding: EdgeInsets.only(right: 10.w),
                              child: SvgPicture.asset(
                                R.assetsSvgCalendar,
                              ),
                            ),
                          )))
                    ],
                  )),
                  const SizedBox(
                    width: 15,
                  ),
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText(
                        LocaleKeys.delivery_time.tr,
                        style: typoSuperSmallTextBold,
                      ),
                      itemSpace(),
                      Obx(() => AppTextField(
                          isShowErrorText: false,
                          readOnly: true,
                          onTap: () => controller!.pickTime(context),
                          errorText: controller!.errorDate.value,
                          controller: controller!.hourController,
                          textInputAction: TextInputAction.next,
                          textStyle: typoSuperSmallTextBold.copyWith(),
                          decoration: decorTextFieldOval.copyWith(
                            hintText: 'hh:mm AM',
                            suffixIconConstraints: BoxConstraints(
                              maxHeight: 20.h,
                            ),
                            suffixIcon: Padding(
                              padding: EdgeInsets.only(right: 10.w),
                              child: SvgPicture.asset(
                                R.assetsSvgWatch,
                              ),
                            ),
                          )))
                    ],
                  ))
                ],
              ),
              SizedBox(
                height: 8.h,
              ),
              itemSpace(),
              AppText(
                LocaleKeys.choose_number.tr,
                style: typoSuperSmallTextBold,
              ),
              itemSpace(),
              qtyWidget(),
              const SizedBox(
                height: 1,
              ),
              Obx(
                () => AppText(
                  controller!.errorCount.value,
                  style: typoNormalTextRegular.copyWith(
                      color: colorSemanticRed100, fontSize: 11.sp),
                ),
              ),
        Visibility(visible: controller!.myComboModel!=null,child:       Row(
          children: [
            SvgPicture.asset(R.assetsSvgOpenGift),
            const SizedBox(
              width: 7,
            ),
            Expanded(
                child: RichText(
                  text: TextSpan(
                      text: "${LocaleKeys.remaining_rice.tr} ",
                      style: typoSuperSmallText500.copyWith(
                          fontSize: 10.sp,
                          color: colorOrange50,
                          fontStyle: FontStyle.italic),
                          children: [
                            TextSpan(
                                text:
                                    "${controller!.myComboModel?.remainsCombo ?? 0} ${LocaleKeys.slot.tr}")
                          ]),
                    ))
          ],
        ),),
              itemSpace(),
              itemSpace(),
              AppButton(
                onPress: () => controller!.continueOnclick(context),
                title: LocaleKeys.continues.tr,
                backgroundColor: colorGreen55,
                height: heightContinue,
                shapeBorder: shapeBorderButton,
                width: MediaQuery.of(context).size.width,
                textStyle: typoButton.copyWith(color: colorWhite),
              )
            ],
          ),
        ));
  }

  Widget qtyWidget() => TypeAheadField(
        hideSuggestionsOnKeyboardHide: true,
        direction: AxisDirection.up,
        suggestionsBoxDecoration:
            const SuggestionsBoxDecoration(color: colorWhite, elevation: 0.2),
        textFieldConfiguration: TextFieldConfiguration(
            controller: controller!.countController,
            keyboardType: TextInputType.number,
            maxLines: 1,
            // onTap: () => controller!.scrollToBottom(),
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
        onSuggestionSelected: (String suggest) => controller!.setCount(suggest),
        suggestionsCallback: (pattern) {
          return controller!.suggestCount();
        },
      );

  Widget itemSpace() => SizedBox(
        height: 5.h,
      );
}

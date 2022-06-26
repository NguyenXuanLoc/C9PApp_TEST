import 'package:c9p/app/components/app_button.dart';
import 'package:c9p/app/components/app_loading_widget.dart';
import 'package:c9p/app/components/app_scalford.dart';
import 'package:c9p/app/components/app_text.dart';
import 'package:c9p/app/components/app_text_field.dart';
import 'package:c9p/app/config/app_translation.dart';
import 'package:c9p/app/config/globals.dart';
import 'package:c9p/app/theme/app_styles.dart';
import 'package:c9p/app/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

import 'package:get/get.dart';
import 'package:c9p/app/config/resource.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../data/model/address_model.dart';
import '../controllers/order_controller.dart';

class OrderView extends GetView<OrderController> {
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
            LocaleKeys.order.tr,
            style: typoMediumTextBold.copyWith(
                fontWeight: FontWeight.w700, color: colorText0),
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
          controller: controller.scrollController,
          padding: EdgeInsets.all(contentPadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 200.h,
                child: PageView(
                  controller: controller.pageController,
                  children: controller.lDescriptionImage
                      .map((e) => Image.asset(
                            e,
                            fit: BoxFit.cover,
                          ))
                      .toList(),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Center(
                child: Obx(() => AnimatedSmoothIndicator(
                      activeIndex: controller.currentIndex.value,
                      count: 4,
                      effect: ScrollingDotsEffect(
                          spacing: 6.w,
                          radius: 100,
                          dotWidth: 7.w,
                          dotHeight: 7.w,
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
                  errorText: controller.errorFullName.value,
                  controller: controller.fullNameController,
                  textInputAction: TextInputAction.next,
                  textStyle:
                      typoSuperSmallTextBold.copyWith(color: colorText60),
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
                  errorText: controller.errorPhoneNumber.value,
                  controller: controller.phoneController,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.phone,
                  textStyle: typoSuperSmallTextBold.copyWith(
                    color: colorText60,
                  ),
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
                    controller: controller.addressController,
                    maxLines: 1,
                    onTap: () => controller.scrollToBottom(),
                    autofocus: false,
                    style: typoSuperSmallTextBold.copyWith(color: colorText60),
                    decoration: decorTextFieldOval.copyWith(
                      hintText: LocaleKeys.input_address_at_here.tr,
                      hintStyle:
                          typoSuperSmallTextBold.copyWith(color: colorText60),
                      suffixIcon: const Icon(Icons.keyboard_arrow_down_rounded,
                          color: colorBlack),
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
                    controller.setAddress(address),
                suggestionsCallback: (pattern) {
                  return controller.filterAddress(pattern);
                },
              ),
              const SizedBox(
                height: 10,
              ),
              Obx(
                () => Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: AppText(
                    controller.errorAddress.value,
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
                      const SizedBox(
                        height: 10,
                      ),
                      Obx(() => AppTextField(
                          readOnly: true,
                          onTap: () => controller.pickDate(context),
                          controller: controller.dateController,
                          errorText: controller.errorDate.value,
                          textInputAction: TextInputAction.next,
                          textStyle: typoSuperSmallTextBold.copyWith(
                              color: colorText60),
                          decoration: decorTextFieldOval.copyWith(
                            hintText: 'mm/dd/yyy',
                            suffixIcon: const Icon(
                                Icons.keyboard_arrow_down_rounded,
                                color: colorBlack),
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
                      const SizedBox(
                        height: 10,
                      ),
                      Obx(() => AppTextField(
                          readOnly: true,
                          onTap: () => controller.pickTime(context),
                          errorText: controller.errorDate.value,
                          controller: controller.hourController,
                          textInputAction: TextInputAction.next,
                          textStyle: typoSuperSmallTextBold.copyWith(
                              color: colorText60),
                          decoration: decorTextFieldOval.copyWith(
                            hintText: 'hh:mm AM',
                            suffixIcon: const Icon(
                                Icons.keyboard_arrow_down_rounded,
                                color: colorBlack),
                          )))
                    ],
                  ))
                ],
              ),
              itemSpace(),
              AppText(
                LocaleKeys.choose_number.tr,
                style: typoSuperSmallTextBold,
              ),
              itemSpace(),
              Obx(() => AppTextField(
                  keyboardType: TextInputType.number,
                  controller: controller.countController,
                  errorText: controller.errorCount.value,
                  textInputAction: TextInputAction.done,
                  textStyle:
                      typoSuperSmallTextBold.copyWith(color: colorText60),
                  decoration: decorTextFieldOval.copyWith(
                    hintText: LocaleKeys.input_qty.tr,
                    hintStyle:
                        typoSuperSmallTextBold.copyWith(color: colorText60),
                    suffixIcon: const Icon(Icons.keyboard_arrow_down_rounded,
                        color: colorBlack),
                  ))),
              itemSpace(),
              AppButton(
                onPress: () => controller.continueOnclick(context),
                title: LocaleKeys.continues.tr,
                backgroundColor: colorGreen55,
                height: 40.h,
                shapeBorder: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                width: MediaQuery.of(context).size.width,
                textStyle: typoSuperSmallTextBold.copyWith(color: colorWhite),
              )
            ],
          ),
        ));
  }

  Widget countWidget() => TypeAheadField(
        hideSuggestionsOnKeyboardHide: false,
        textFieldConfiguration: TextFieldConfiguration(
            controller: controller.countController,
            autofocus: false,
            style: typoSuperSmallTextBold.copyWith(color: colorText60),
            decoration: decorTextFieldOval.copyWith(
                suffixIcon: const Icon(Icons.keyboard_arrow_down_rounded,
                    color: colorBlack))),
        itemBuilder: (context, String suggestion) {
          return ListTile(
            leading: const Icon(Icons.countertops_sharp),
            title: Text(
              suggestion,
              style: typoSuperSmallTextBold.copyWith(color: colorText60),
            ),
          );
        },
        noItemsFoundBuilder: (c) => AppText(
          'Không có dữ liệu',
          style: typoSmallTextRegular,
        ),
        onSuggestionSelected: (String suggest) => controller.setCount(suggest),
        suggestionsCallback: (pattern) {
          return controller.suggestCount();
        },
      );

  Widget itemSpace() => const SizedBox(
        height: 10,
      );
}

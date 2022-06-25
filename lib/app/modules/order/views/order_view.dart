import 'package:c9p/app/components/app_button.dart';
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
                  decoration: decorTextFieldOval,
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
                  textStyle:
                      typoSuperSmallTextBold.copyWith(color: colorText60),
                  decoration: decorTextFieldOval,
                ),
              ),
              AppText(
                LocaleKeys.address_order.tr,
                style: typoSuperSmallTextBold,
              ),
              itemSpace(),
              Obx(() => AppTextField(
                  errorText: controller.errorAddress.value,
                  controller: controller.addressController,
                  textInputAction: TextInputAction.next,
                  textStyle:
                      typoSuperSmallTextBold.copyWith(color: colorText60),
                  decoration: decorTextFieldOval.copyWith(
                    suffixIcon: const Icon(Icons.keyboard_arrow_down_rounded,
                        color: colorBlack),
                  ))),
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
                        LocaleKeys.delivery_date.tr,
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
                    suffixIcon: const Icon(Icons.keyboard_arrow_down_rounded,
                        color: colorBlack),
                  ))),
              /*    countWidget(),*/
              itemSpace(),
              AppButton(
                onPress: () => controller.continueOnclick(),
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

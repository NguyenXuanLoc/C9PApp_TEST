import 'package:c9p/app/components/app_scalford.dart';
import 'package:c9p/app/components/app_text.dart';
import 'package:c9p/app/theme/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../../../app_line.dart';
import '../../../components/app_button.dart';
import '../../../config/app_translation.dart';
import '../../../config/globals.dart';
import '../../../config/resource.dart';
import '../../../theme/colors.dart';
import '../controllers/your_order_controller.dart';

class YourOrderView extends GetView<YourOrderController> {
  const YourOrderView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: AppScaffold(
            appbar: AppBar(
              automaticallyImplyLeading: false,
              toolbarHeight: 25.h,
              centerTitle: true,
              flexibleSpace: Container(
                alignment: Alignment.bottomCenter,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(R.assetsBackgroundHeaderTabMainPng),
                        fit: BoxFit.fitWidth)),
                child: Center(
                  child: AppText(
                    LocaleKeys.your_order.tr,
                    style: typoMediumTextBold.copyWith(
                        fontWeight: FontWeight.w700, color: colorText0),
                  ),
                ),
              ),
              bottom: TabBar(
                indicatorColor: colorOrange60,
                indicatorSize: TabBarIndicatorSize.label,
                unselectedLabelColor: Colors.black,
                tabs: [
                  Tab(
                      height: 25.h,
                      icon: AppText(
                        LocaleKeys.order_are_coming.tr,
                        style:
                            typoSuperSmallTextBold.copyWith(color: colorText0),
                      )),
                  Tab(
                      height: 25.h,
                      icon: AppText(
                        LocaleKeys.order_delivered.tr,
                        style:
                            typoSuperSmallTextBold.copyWith(color: colorText0),
                      )),
                ],
              ),
            ),
            body: TabBarView(
              children: <Widget>[
                orderComingWidget(context),
                orderDeliveredWidget(context)
              ],
            )));
  }

  Widget orderDeliveredWidget(BuildContext context) {
    return ListView.separated(
        padding: const EdgeInsets.all(0),
        itemBuilder: (c, i) => Padding(
              padding: EdgeInsets.all(contentPadding),
              child: InkWell(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Image.asset(
                          R.assetsPngComSuon9p,
                          height: 50.h,
                          fit: BoxFit.fitHeight,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                              AppText(
                                'Cơm sườn ngon 9 phút',
                                style: typoSmallTextBold.copyWith(
                                    fontWeight: FontWeight.w800),
                              ),
                              SizedBox(
                                height: 30,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    AppText('45.000d',
                                        style: typoSmallTextBold.copyWith(
                                            color: colorSemanticRed100,
                                            fontWeight: FontWeight.w800)),
                                    Spacer(),
                                    AppText(
                                        '${LocaleKeys.code.tr} #1235 / 1 suất cơm',
                                        textAlign: TextAlign.center,
                                        style: typoSuperSmallTextBold.copyWith(
                                            fontSize: 12.sp,
                                            color: colorOrange40))
                                  ],
                                ),
                              ),
                            ]))
                      ],
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    const AppLineWidget(),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        AppText(
                          '16/06/2022 12:30:15',
                          style: typoSuperSmallTextBold.copyWith(
                              fontSize: 11.5.sp),
                        ),
                        Spacer(),
                        AppText(
                          LocaleKeys.delivered.tr,
                          style: typoSuperSmallTextBold.copyWith(
                              fontSize: 11.5.sp, color: colorGreen55),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const AppLineWidget(),
                    const SizedBox(
                      height: 10,
                    ),
                    AppText(
                      'Địa chỉ:  18 hoàng diệu, phường minh khai, quận hồng bàng, minh khai, hồng bàng, hải phòng ',
                      style: typoSuperSmallTextBold.copyWith(fontSize: 12.sp),
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                  ],
                ),
                onTap: () {},
              ),
            ),
        separatorBuilder: (i, c) => Container(
              color: colorSeparatorListView,
              height: 10.h,
              width: MediaQuery.of(context).size.width,
            ),
        itemCount: 10);
  }

  Widget orderComingWidget(BuildContext context) {
    return ListView.separated(
        padding: const EdgeInsets.all(0),
        itemBuilder: (c, i) => Padding(
              padding: EdgeInsets.all(contentPadding),
              child: InkWell(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Image.asset(
                          R.assetsPngComSuon9p,
                          height: 50.h,
                          fit: BoxFit.fitHeight,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                              AppText(
                                'Cơm sườn ngon 9 phút',
                                style: typoSmallTextBold.copyWith(
                                    fontWeight: FontWeight.w800),
                              ),
                              SizedBox(
                                height: 30,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    AppText('45.000d',
                                        style: typoSmallTextBold.copyWith(
                                            color: colorSemanticRed100,
                                            fontWeight: FontWeight.w800)),
                                    Spacer(),
                                    AppText(
                                        '${LocaleKeys.code.tr} #1235 / 1 suất cơm',
                                        textAlign: TextAlign.center,
                                        style: typoSuperSmallTextBold.copyWith(
                                            fontSize: 12.sp,
                                            color: colorOrange40))
                                  ],
                                ),
                              ),
                            ]))
                      ],
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    const AppLineWidget(),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        AppText(
                          '16/06/2022 12:30:15',
                          style: typoSuperSmallTextBold.copyWith(
                              fontSize: 11.5.sp),
                        ),
                        Spacer(),
                        AppText(
                          LocaleKeys.delivered.tr,
                          style: typoSuperSmallTextBold.copyWith(
                              fontSize: 11.5.sp, color: colorGreen55),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const AppLineWidget(),
                    const SizedBox(
                      height: 10,
                    ),
                    AppText(
                      'Địa chỉ:  18 hoàng diệu, phường minh khai, quận hồng bàng, minh khai, hồng bàng, hải phòng ',
                      style: typoSuperSmallTextBold.copyWith(fontSize: 12.sp),
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: AppButton(
                        borderRadius: 100,
                        onPress: () => controller.onClickReOrder(),
                        title: LocaleKeys.re_deliver.tr,
                        textStyle:
                            typoSuperSmallTextBold.copyWith(color: colorText0),
                        backgroundColor: colorGreen57,
                        height: 28.h,
                        padding: EdgeInsets.only(left: 20.w, right: 20.w),
                      ),
                    )
                  ],
                ),
                onTap: () => {},
              ),
            ),
        separatorBuilder: (i, c) => Container(
              color: colorSeparatorListView,
              height: 10.h,
              width: MediaQuery.of(context).size.width,
            ),
        itemCount: 10);
  }
}

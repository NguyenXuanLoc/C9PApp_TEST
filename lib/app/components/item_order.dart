import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../app_line.dart';
import '../config/app_translation.dart';
import '../config/globals.dart';
import '../config/resource.dart';
import '../data/model/order_model.dart';
import '../theme/app_styles.dart';
import '../theme/colors.dart';
import '../utils/app_utils.dart';
import 'app_button.dart';
import 'app_network_image.dart';
import 'app_text.dart';

class ItemOrder extends StatelessWidget {
  final Function(OrderModel model) callBackOrderDetail;
  final Function(OrderModel model)? callBackReOrder;
  final OrderModel model;

  const ItemOrder(
      {Key? key,
      required this.model,
      required this.callBackOrderDetail,
      this.callBackReOrder})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: contentPadding, right: contentPadding, top: 10.h, bottom: 10.h),
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
                model.imageUrl != null && model.imageUrl.isNotEmpty
                    ? AppNetworkImage(
                        source: model.imageUrl,
                        height: 50.h,
                      )
                    : Image.asset(
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
                        LocaleKeys.com_suong_9p.tr,
                        style: typoSmallTextBold.copyWith(
                            fontWeight: FontWeight.w800),
                      ),
                      SizedBox(
                        height: 30,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            AppText('${Utils.formatMoney(model.amount ?? 0)}đ',
                                style: typoSmallTextBold.copyWith(
                                    color: colorSemanticRed100,
                                    fontWeight: FontWeight.w800)),
                            const Spacer(),
                            AppText(
                                '${LocaleKeys.code.tr} #${model.id ?? 0} / ${model.itemQty ?? 0} ${LocaleKeys.bowl_of_rice.tr}',
                                textAlign: TextAlign.center,
                                style: typoSuperSmallTextBold.copyWith(
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
                  Utils.convertTimeToDDMMYYHHMMSS(
                      model.deliverTime ?? DateTime.now()),
                  style: typoSuperSmallTextBold.copyWith(),
                ),
                const Spacer(),
                AppText(
                Utils.getOrderStatus(  model.status ?? ''),
                  style: typoSuperSmallTextBold.copyWith(color: colorGreen55),
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
              "${LocaleKeys.address.tr}: ${model.toAddress ?? ''}",
              style: typoSuperSmallTextBold.copyWith(),
            ),
            callBackReOrder != null
                ? Padding(
                    padding: EdgeInsets.only(top: 3.h),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: AppButton(
                        borderRadius: 100,
                        onPress: () => callBackReOrder!(model),
                        title: LocaleKeys.re_deliver.tr,
                        textStyle: typoSuperSmallTextBold.copyWith(
                            fontSize: 13.sp, color: colorText0),
                        backgroundColor: colorGreen57,
                        height: 28.h,
                        padding: EdgeInsets.only(left: 20.w, right: 20.w),
                      ),
                    ),
                  )
                : const SizedBox()
          ],
        ),
        onTap: () => callBackOrderDetail(model),
      ),
    );
  }
}

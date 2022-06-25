
import 'package:c9p/app/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class Dialogs {
  static final GlobalKey<State> _keyLoader = GlobalKey<State>();

  static Future<void>? showLoadingDialog(BuildContext? context) {
    if (context == null) {
      return null;
    }
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return WillPopScope(
            onWillPop: () async => false,
            child: SimpleDialog(
              key: _keyLoader,
              backgroundColor: Colors.transparent,
              children: const <Widget>[
                Center(
                  child: CircularProgressIndicator(
                    backgroundColor: colorNeutralDark20,
                    valueColor:
                        AlwaysStoppedAnimation<Color>(colorPrimaryBrand100),
                  ),
                )
              ],
            ),
          );
        });
  }


  /*static Future<void> showDeleteCommentDialog(
      BuildContext context, VoidCallback onRemoveComment) {
    return showDialog<void>(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return WillPopScope(
            onWillPop: () async => true,
            child: SimpleDialog(
              key: _keyLoader,
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: IconButton(
                      onPressed: () => hideLoadingDialog(),
                      icon: SvgPicture.asset(R.assetsSvgClearCircleSvg)),
                  alignment: Alignment.centerRight,
                ),
                SizedBox(
                  height: 10.h,
                ),
                AppText(
                  LocaleKeys.title_delete_dialog.tr,
                  style: typoMediumTextBold,
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 10.h,
                ),
                AppText(
                  LocaleKeys.message_delete_dialog.tr,
                  style: typoMediumTextRegular.copyWith(fontSize: 12.sp),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 20.h,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AppButton(
                        textStyle:
                            typoSmallTextBold.copyWith(color: colorBlue80),
                        shapeBorder: RoundedRectangleBorder(
                            side: const BorderSide(
                              color: colorBlue5,
                            ),
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.h))),
                        title: LocaleKeys.no.tr,
                        onPress: () => hideLoadingDialog(),
                        width: 90.w,
                        height: 30.h,
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      AppButton(
                          title: LocaleKeys.yes.tr,
                          textStyle:
                              typoSmallTextBold.copyWith(color: colorWhite),
                          onPress: () async {
                            await hideLoadingDialog();
                            onRemoveComment.call();
                          },
                          width: 90.w,
                          height: 30.h,
                          backgroundColor: colorBlue80,
                          shapeBorder: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.h)))),
                    ],
                  ),
                  alignment: Alignment.center,
                ),
                SizedBox(
                  height: 10.h,
                )
              ],
            ),
          );
        });
  }*/

  static Future<void> hideLoadingDialog() async {
    await Future.delayed(
        const Duration(milliseconds: 200),
        () => Navigator.of(_keyLoader.currentContext!, rootNavigator: true)
            .pop());
  }
}

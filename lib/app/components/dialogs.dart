import 'package:c9p/app/components/app_button.dart';
import 'package:c9p/app/components/app_network_image.dart';
import 'package:c9p/app/config/globals.dart';
import 'package:c9p/app/theme/app_styles.dart';
import 'package:c9p/app/theme/colors.dart';
import 'package:c9p/app/utils/log_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../config/app_translation.dart';
import '../config/resource.dart';
import 'app_text.dart';

class Dialogs {
  static final GlobalKey<State> _keyLoader = GlobalKey<State>();
  static final GlobalKey<State> _keyPromotion = GlobalKey<State>();
  static final _keyCloseApp = GlobalKey<State>();

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
                    valueColor: AlwaysStoppedAnimation<Color>(colorGreen60),
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
  static Future<void> showCloseAppDialog(
    BuildContext context, {
    required VoidCallback closeCallBack,
    required VoidCallback popCallBack,
    required VoidCallback cancelCallBack,
  }) {
    return showDialog<void>(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return WillPopScope(
            onWillPop: () async {
              popCallBack.call();
              return true;
            },
            child: SimpleDialog(
              key: _keyLoader,
              children: <Widget>[
                SizedBox(
                  height: 10.h,
                ),
                AppText(
                  "Bạn có thực sự muốn thoát app?",
                  style: typoSmallTextBold,
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 20.h,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AppButton(
                        textStyle: typoSuperSmallTextBold.copyWith(
                            color: colorGreen60),
                        shapeBorder: RoundedRectangleBorder(
                            side: const BorderSide(
                              color: colorGreen60,
                            ),
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.h))),
                        title: "Hủy",
                        onPress: () async {
                          await hideLoadingDialog();
                          cancelCallBack.call();
                        },
                        width: 90.w,
                        height: 25.h,
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      AppButton(
                          title: "Đồng ý",
                          textStyle: typoSuperSmallTextBold.copyWith(
                              color: colorWhite),
                          onPress: () async {
                            await hideLoadingDialog();
                            closeCallBack.call();
                          },
                          width: 90.w,
                          height: 25.h,
                          backgroundColor: colorGreen60,
                          shapeBorder: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.h)))),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }

  static Future<void> showLogoutDialog(BuildContext context,
      {required VoidCallback deleteCallBack}) {
    return showDialog<void>(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return WillPopScope(
            onWillPop: () async => true,
            child: SimpleDialog(
              key: _keyLoader,
              children: <Widget>[
                SizedBox(
                  height: 10.h,
                ),
                AppText(
                  "Bạn có chắc muốn đăng xuất?",
                  style: typoSmallTextBold,
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 20.h,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AppButton(
                        textStyle: typoSuperSmallTextBold.copyWith(
                            color: colorGreen60),
                        shapeBorder: RoundedRectangleBorder(
                            side: const BorderSide(
                              color: colorGreen60,
                            ),
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.h))),
                        title: "Hủy",
                        onPress: () => hideLoadingDialog(),
                        width: 90.w,
                        height: 25.h,
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      AppButton(
                          title: "Đồng ý",
                          textStyle: typoSuperSmallTextBold.copyWith(
                              color: colorWhite),
                          onPress: () async {
                            await hideLoadingDialog();
                            deleteCallBack.call();
                          },
                          width: 90.w,
                          height: 25.h,
                          backgroundColor: colorGreen60,
                          shapeBorder: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.h)))),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }

  static Future<void> showLoginDialog(BuildContext context,
      {required VoidCallback loginCallBack}) {
    return showDialog<void>(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return WillPopScope(
            onWillPop: () async => true,
            child: SimpleDialog(
              key: _keyLoader,
              children: <Widget>[
                SizedBox(
                  height: 10.h,
                ),
                AppText(
                  "Vui lòng đăng nhập để sử dụng tính năng này.",
                  style: typoSmallTextBold,
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 20.h,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AppButton(
                        textStyle: typoSuperSmallTextBold.copyWith(
                            color: colorGreen60),
                        shapeBorder: RoundedRectangleBorder(
                            side: const BorderSide(
                              color: colorGreen60,
                            ),
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.h))),
                        title: "Hủy",
                        onPress: () => hideLoadingDialog(),
                        width: 90.w,
                        height: 25.h,
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      AppButton(
                          title: "Đồng ý",
                          textStyle: typoSuperSmallTextBold.copyWith(
                              color: colorWhite),
                          onPress: () async {
                            await hideLoadingDialog();
                            loginCallBack.call();
                          },
                          width: 90.w,
                          height: 25.h,
                          backgroundColor: colorGreen60,
                          shapeBorder: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.h)))),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }

  static Future<bool?> showMethodPickImage(BuildContext context,
      {required VoidCallback cameraCallBack,required VoidCallback galleryCallBack}) async {
    return await showGeneralDialog(
        barrierDismissible: true,
        context: context,
        barrierLabel:
            MaterialLocalizations.of(context).modalBarrierDismissLabel,
        barrierColor: Colors.black45,
        transitionDuration: const Duration(milliseconds: 200),
        pageBuilder: (BuildContext buildContext, Animation animation,
            Animation secondaryAnimation) {
          return WillPopScope(
              onWillPop: () async => true,
              child: SimpleDialog(
                key: _keyPromotion,
                backgroundColor: Colors.transparent,
                contentPadding: EdgeInsets.all(5.w),
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(left: contentPadding,top: 5,bottom: 5),
                    alignment: Alignment.centerLeft,
                    width: MediaQuery.of(context).size.width,
                    height: 80.h,
                    color: colorGrey70,
                    child: Column(mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        InkWell(
                          onTap: () {
                            Get.back();
                            cameraCallBack.call();
                          },
                          child: AppText(LocaleKeys.take_photo.tr,
                              style: typoNormalTextBold.copyWith(
                                  color: colorWhite)),
                        ),
                        InkWell(
                          onTap: () {
                            Get.back();
                            galleryCallBack.call();
                          },
                          child: AppText(LocaleKeys.pick_photo_from_gallery.tr,
                              style: typoNormalTextBold.copyWith(
                                  color: colorWhite)),
                        ),
                      ],
                    ),
                  )
                ],
              ));
        });
  }

  static Future<bool?> showPopupPromotion(BuildContext context,
      {required VoidCallback bannerCallBack}) async {
    return await showGeneralDialog(
        barrierDismissible: false,
        context: context,
        barrierLabel:
            MaterialLocalizations.of(context).modalBarrierDismissLabel,
        barrierColor: Colors.black45,
        transitionDuration: const Duration(milliseconds: 200),
        pageBuilder: (BuildContext buildContext, Animation animation,
            Animation secondaryAnimation) {
          return WillPopScope(
              onWillPop: () async => true,
              child: SimpleDialog(
                key: _keyPromotion,
                backgroundColor: Colors.transparent,
                contentPadding: EdgeInsets.all(5.w),
                children: <Widget>[
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(right: 2),
                        alignment: Alignment.bottomRight,
                        child: InkWell(
                          child: Image.asset(
                            R.assetsPngClearCircle,
                            height: 20.w,
                            fit: BoxFit.fitHeight,
                          ),
                          onTap: () => hidePromotion(),
                        ),
                      ),
                      InkWell(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.asset(
                            R.assetsPngPromotionPopup, fit: BoxFit.fitWidth,
                            // height: 260.h,
                            width: MediaQuery.of(context).size.width * 2 / 3.4,
                          ),
                        ),
                        onTap: () {
                          Get.back();
                          bannerCallBack.call();
                        },
                      )
                    ],
                  )
                ],
              ));
        });
  }

  static Future<void> hidePromotion() async {
    await Future.delayed(
        const Duration(milliseconds: 200),
        () => Navigator.of(_keyPromotion.currentContext!, rootNavigator: true)
            .pop());
  }

  static Future<void> hideLoadingDialog() async {
    await Future.delayed(
        const Duration(milliseconds: 200),
        () => Navigator.of(_keyLoader.currentContext!, rootNavigator: true)
            .pop());
  }
}

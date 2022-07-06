import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors.dart';

final styleButtonWhite = ButtonStyle(
  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
    RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
      side: const BorderSide(color: Colors.transparent),
    ),
  ),
  backgroundColor: MaterialStateProperty.all<Color>(colorWhite),
  foregroundColor: MaterialStateProperty.resolveWith((states) {
    return states.contains(MaterialState.disabled)
        ? colorNeutralDark40
        : colorPrimaryBrand100;
  }),
  // shadowColor: MaterialStateProperty.all<Color>(colorNeutralDark20),
  overlayColor: MaterialStateProperty.resolveWith((states) {
    return states.contains(MaterialState.pressed) ? colorNeutralDark5 : null;
  }),
  padding:
      MaterialStateProperty.all<EdgeInsetsGeometry>(const EdgeInsets.all(12)),
  textStyle: MaterialStateProperty.all<TextStyle>(typoNormalTextBold),
);

final styleButtonPrimary = ButtonStyle(
  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
    RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
      side: const BorderSide(color: Colors.transparent),
    ),
  ),
  backgroundColor:
      MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
    if (states.contains(MaterialState.disabled)) {
      return colorNeutralDark10;
    }
    return colorPrimaryBrand100;
  }),
  padding:
      MaterialStateProperty.all<EdgeInsetsGeometry>(const EdgeInsets.all(12)),
  textStyle: MaterialStateProperty.all<TextStyle>(typoNormalTextBold),
);

final styleButtonOrange = ButtonStyle(
  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
    RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(24.0),
      side: const BorderSide(color: Colors.transparent),
    ),
  ),
  backgroundColor: MaterialStateProperty.all<Color>(colorPrimaryOrange100),
  foregroundColor: MaterialStateProperty.resolveWith((states) {
    return states.contains(MaterialState.disabled)
        ? colorNeutralDark40
        : colorPrimaryOrange100;
  }),
  // shadowColor: MaterialStateProperty.all<Color>(colorNeutralDark20),
  overlayColor: MaterialStateProperty.resolveWith((states) {
    return states.contains(MaterialState.pressed)
        ? colorPrimaryOrange100
        : null;
  }),
  padding:
      MaterialStateProperty.all<EdgeInsetsGeometry>(const EdgeInsets.all(12)),
  textStyle: MaterialStateProperty.all<TextStyle>(typoNormalTextBold),
);

final styleButtonWhiteBorder = ButtonStyle(
  shape: MaterialStateProperty.resolveWith((states) {
    return states.contains(MaterialState.disabled)
        ? RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
            side: const BorderSide(color: colorNeutralDark10, width: 2),
          )
        : RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
            side: const BorderSide(color: colorPrimaryBrand100, width: 2),
          );
  }),
  backgroundColor: MaterialStateProperty.all<Color>(colorWhite),
  foregroundColor: MaterialStateProperty.resolveWith((states) {
    return states.contains(MaterialState.disabled)
        ? colorNeutralDark40
        : colorPrimaryBrand100;
  }),
  // shadowColor: MaterialStateProperty.all<Color>(colorNeutralDark20),
  overlayColor: MaterialStateProperty.resolveWith((states) {
    return states.contains(MaterialState.pressed) ? colorNeutralDark5 : null;
  }),
  padding:
      MaterialStateProperty.all<EdgeInsetsGeometry>(const EdgeInsets.all(12)),
  textStyle: MaterialStateProperty.all<TextStyle>(typoNormalTextBold),
);

final styleButtonChip = ButtonStyle(
  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
    RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8.0),
      side: const BorderSide(color: Colors.transparent),
    ),
  ),
  backgroundColor:
      MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
    if (states.contains(MaterialState.disabled)) {
      return colorNeutralDark10;
    }
    return colorPrimaryBrand5;
  }),
  foregroundColor: MaterialStateProperty.all<Color>(colorNeutralDark100),
  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
      const EdgeInsets.symmetric(horizontal: 12, vertical: 0)),
  textStyle: MaterialStateProperty.all<TextStyle>(typoNormalTextBold),
);

final styleButtonChipActive = ButtonStyle(
  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
    RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8.0),
      side: const BorderSide(color: colorPrimaryGreen100, width: 1.0),
    ),
  ),
  backgroundColor:
      MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
    if (states.contains(MaterialState.disabled)) {
      return colorNeutralDark10;
    }
    return colorPrimaryBrand5;
  }),
  foregroundColor: MaterialStateProperty.all<Color>(colorPrimaryBrand100),
  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
      const EdgeInsets.symmetric(horizontal: 12, vertical: 0)),
  textStyle: MaterialStateProperty.all<TextStyle>(typoNormalTextBold),
);

final styleTextField =
    typoMediumTextRegular.copyWith(color: colorNeutralDark100);

final styleTextFieldBold =
    typoNormalTextBold.copyWith(color: colorNeutralDark100);

final decorTextField = InputDecoration(
  enabledBorder: const OutlineInputBorder(
    borderSide: BorderSide(color: colorGreyBorder, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(7)),
  ),
  focusedBorder: const OutlineInputBorder(
    borderSide: BorderSide(color: colorGreyBorder, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(7)),
  ),
  errorBorder: const OutlineInputBorder(
    borderSide: BorderSide(color: colorGreyBorder, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(7)),
  ),
  focusedErrorBorder: const OutlineInputBorder(
    borderSide: BorderSide(color: colorGreyBorder, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(7)),
  ),
  contentPadding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16),
  hintStyle: typoNormalTextRegular.copyWith(
      color: colorNeutralDark40.withOpacity(0.4)),
  errorStyle: typoSmallTextRegular.copyWith(color: colorSemanticRed100),
  counterText: '',
  fillColor: Colors.white,
  filled: true,
);

final decorTextFieldCircle = InputDecoration(
  enabledBorder: const OutlineInputBorder(
    borderSide: BorderSide(color: colorWhite, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(100)),
  ),
  focusedBorder: const OutlineInputBorder(
    borderSide: BorderSide(color: colorWhite, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(100)),
  ),
  errorBorder: const OutlineInputBorder(
    borderSide: BorderSide(color: colorWhite, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(100)),
  ),
  focusedErrorBorder: const OutlineInputBorder(
    borderSide: BorderSide(color: colorWhite, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(100)),
  ),
  contentPadding:
      EdgeInsets.only(left: 15.w, top: 10.h, bottom: 10.h, right: 5.w),
  hintStyle: typoNormalTextRegular.copyWith(
      color: colorNeutralDark40.withOpacity(0.4)),
  errorStyle: typoSmallTextRegular.copyWith(color: colorSemanticRed100),
  counterText: '',
  fillColor: Colors.white,
  filled: true,
);

final decorTextFieldOval = InputDecoration(
  suffixIconConstraints: BoxConstraints(minHeight: 24.h, minWidth: 24.w),
  enabledBorder: const OutlineInputBorder(
    borderSide: BorderSide(color: colorGreen60, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(17)),
  ),
  focusedBorder: const OutlineInputBorder(
    borderSide: BorderSide(color: colorGreen60, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(17)),
  ),
  errorBorder: const OutlineInputBorder(
    borderSide: BorderSide(color: colorGreen60, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(17)),
  ),
  focusedErrorBorder: const OutlineInputBorder(
    borderSide: BorderSide(color: colorGreen60, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(17)),
  ),
  contentPadding:
      EdgeInsets.only(left: 15.w, top: 10.h, bottom: 10.h, right: 5.w),
  // contentPadding: const EdgeInsets.symmetric(vertical: 11/*, horizontal: 16*/),
  hintStyle: typoSuperSmallTextBold.copyWith(
      color: colorNeutralDark40.withOpacity(0.4)),

  errorStyle: typoSuperSmallTextBold.copyWith(color: colorSemanticRed100),
  counterText: '',

  fillColor: Colors.white,
  isDense: true,
  filled: true,
);

final decorScreenContainerSelect = BoxDecoration(
  borderRadius: const BorderRadius.all(Radius.circular(20)),
  boxShadow: boxShadowSelectBox,
  color: colorWhite,
);

final decorScreenContainer = BoxDecoration(
  borderRadius: const BorderRadius.only(
    topRight: Radius.circular(20),
    topLeft: Radius.circular(20),
  ),
  boxShadow: boxShadow,
  color: colorWhite,
);

const decorScreenContainerNoShadow = BoxDecoration(
  borderRadius: BorderRadius.only(
    topRight: Radius.circular(20),
    topLeft: Radius.circular(20),
  ),
  color: colorWhite,
);

final decorContainerBox = BoxDecoration(
  borderRadius: const BorderRadius.all(Radius.circular(10)),
  boxShadow: boxShadow,
  color: colorWhite,
);

final boxShadow = [
  BoxShadow(
    color: colorBlack.withOpacity(0.05),
    spreadRadius: 0,
    blurRadius: 10,
    offset: const Offset(0, 0),
  ),
];

final boxShadowFocus = [
  BoxShadow(
    color: colorBlack.withOpacity(0.15),
    spreadRadius: 0,
    blurRadius: 40,
    offset: const Offset(0, 10),
  ),
];

final boxShadowSelectBox = [
  BoxShadow(
    color: colorBlack.withOpacity(0.2),
    spreadRadius: 0,
    blurRadius: 5,
    offset: const Offset(0, 4),
  ),
];

final typoHeading2 = GoogleFonts.nunito(
  fontStyle: FontStyle.normal,
  fontWeight: FontWeight.w800,
  fontSize: 48.sp,
  letterSpacing: 0.2,
  color: colorBlack,
);

final typoHeading4 = GoogleFonts.nunito(
  fontStyle: FontStyle.normal,
  fontWeight: FontWeight.w500,
  fontSize: 32.sp,
  letterSpacing: 0.2,
  color: colorBlack,
);

final typoHeading5 = GoogleFonts.nunito(
  fontStyle: FontStyle.normal,
  fontWeight: FontWeight.w500,
  fontSize: 24.sp,
  letterSpacing: 0.2,
  color: colorBlack,
);

final typoHeading6 = GoogleFonts.nunito(
  fontStyle: FontStyle.normal,
  fontWeight: FontWeight.w500,
  fontSize: 20.sp,
  letterSpacing: 0.2,
  color: colorBlack,
);

final typoSuperLargeTextBold = GoogleFonts.nunito(
  fontStyle: FontStyle.normal,
  fontWeight: FontWeight.w500,
  fontSize: 24.sp,
  letterSpacing: 0.2,
  color: colorBlack,
);

final typoLargeTextBold = GoogleFonts.nunito(
  fontStyle: FontStyle.normal,
  fontWeight: FontWeight.w500,
  fontSize: 20.sp,
  letterSpacing: 0.2,
  color: colorBlack,
);

final typoLargeTextRegular = GoogleFonts.nunito(
  fontStyle: FontStyle.normal,
  fontWeight: FontWeight.w400,
  fontSize: 20.sp,
  letterSpacing: 0.2,
  color: colorBlack,
);

final typoMediumTextBold = GoogleFonts.nunito(
  fontStyle: FontStyle.normal,
  fontWeight: FontWeight.w500,
  fontSize: 18.sp,
  letterSpacing: 0.2,
  color: colorBlack,
);

final typoTitleHeader = GoogleFonts.nunito(
  fontStyle: FontStyle.normal,
  fontWeight: FontWeight.w700,
  fontSize: 16.sp,
  letterSpacing: 0.2,
  color: colorText0,
);

final typoButton = GoogleFonts.nunito(
  fontStyle: FontStyle.normal,
  fontWeight: FontWeight.w600,
  fontSize: 14.sp,
  letterSpacing: 0.2,
  color: colorText0,
);

final typoMediumTextRegular = GoogleFonts.nunito(
  fontStyle: FontStyle.normal,
  fontWeight: FontWeight.w400,
  fontSize: 18.sp,
  letterSpacing: 0.2,
  color: colorBlack,
);

final typoNormalTextBold = GoogleFonts.nunito(
  fontStyle: FontStyle.normal,
  fontWeight: FontWeight.w500,
  fontSize: 16.sp,
  letterSpacing: 0.2,
  color: colorBlack,
);

final typoNormalTextBEBold = GoogleFonts.nunito(
  fontStyle: FontStyle.normal,
  fontWeight: FontWeight.w500,
  fontSize: 16.sp,
  letterSpacing: 0.2,
  color: colorBlack,
);

final typoNormalTextRegular = GoogleFonts.nunito(
  fontStyle: FontStyle.normal,
  fontWeight: FontWeight.w400,
  fontSize: 16.sp,
  letterSpacing: 0.2,
  color: colorBlack,
);

final typoNormalTextRegularNoSpacing = GoogleFonts.nunito(
  fontStyle: FontStyle.normal,
  fontWeight: FontWeight.w400,
  fontSize: 16.sp,
  color: colorBlack,
);

final typoNormalBETextRegularNoSpacing = GoogleFonts.nunito(
  fontStyle: FontStyle.normal,
  fontWeight: FontWeight.w100,
  fontSize: 16.sp,
  color: colorBlack,
);

final typoNormalTextThinRegular = GoogleFonts.nunito(
  fontStyle: FontStyle.normal,
  fontWeight: FontWeight.w200,
  fontSize: 16.sp,
  color: colorBlack,
);

final typoSmallTextBold = GoogleFonts.nunito(
  fontStyle: FontStyle.normal,
  fontWeight: FontWeight.w600,
  fontSize: 15.sp,
  letterSpacing: 0.2,
  color: colorBlack,
);

final typoSmallTextRegular = GoogleFonts.nunito(
  fontStyle: FontStyle.normal,
  fontWeight: FontWeight.w400,
  fontSize: 15.sp,
  letterSpacing: 0.2,
  color: colorBlack,
);

final typoSmallTextRegularNoSpacing = GoogleFonts.nunito(
  fontStyle: FontStyle.normal,
  fontWeight: FontWeight.w400,
  fontSize: 14.sp,
  color: colorBlack,
);

final typoExtraSmallTextBold = GoogleFonts.nunito(
  fontStyle: FontStyle.normal,
  fontWeight: FontWeight.w500,
  fontSize: 12.sp,
  letterSpacing: 0.2,
  color: colorBlack,
);

final typoExtraSmallTextRegular = GoogleFonts.nunito(
  fontStyle: FontStyle.normal,
  fontWeight: FontWeight.w400,
  fontSize: 12.sp,
  letterSpacing: 0.2,
  color: colorBlack,
);

var typoSuperSmallTextBold = GoogleFonts.nunito(
  fontStyle: FontStyle.normal,
  fontWeight: FontWeight.w600,
  fontSize: 12.5.sp,
  letterSpacing: 0.2,
  color: colorBlack,
);

final typoSuperSmallText500 = GoogleFonts.nunito(
  fontStyle: FontStyle.normal,
  fontWeight: FontWeight.w500,
  fontSize: 12.5.sp,
  letterSpacing: 0.2,
  color: colorBlack,
);

final typoSuperSmallTextRegular = GoogleFonts.nunito(
  fontStyle: FontStyle.normal,
  fontWeight: FontWeight.w400,
  fontSize: 12.5.sp,
  letterSpacing: 0.2,
  color: colorBlack,
);
final typoregular14infor = GoogleFonts.nunito(
  color: colorInfo100,
  fontStyle: FontStyle.normal,
  fontSize: 14.sp,
  letterSpacing: 0.2,
);
final typoregular14orange = GoogleFonts.nunito(
    fontStyle: FontStyle.normal,
    fontSize: 14.sp,
    letterSpacing: 0.2,
    color: colorPrimaryOrange100);

final typoSuperSmallTextRegularNoSpacing = GoogleFonts.nunito(
  fontStyle: FontStyle.normal,
  fontWeight: FontWeight.w400,
  fontSize: 10.sp,
  color: colorBlack,
);

final typoVietNamProH1 = GoogleFonts.nunito(
  fontStyle: FontStyle.normal,
  fontWeight: FontWeight.w600,
  fontSize: 20.sp,
  color: colorBlack,
);

final typoVietNamProRegular14 = GoogleFonts.nunito(
  fontStyle: FontStyle.normal,
  fontWeight: FontWeight.w300,
  fontSize: 14.sp,
  color: colorBlack,
);
final typoVietNamProRegular14four = GoogleFonts.nunito(
  fontStyle: FontStyle.normal,
  fontWeight: FontWeight.w400,
  fontSize: 14.sp,
  color: colorBlack,
);
final typoVNregular14Green = GoogleFonts.nunito(
  fontStyle: FontStyle.normal,
  fontWeight: FontWeight.w300,
  color: colorSuccess100,
);

final typoVietNamProRegular16 = GoogleFonts.nunito(
  fontStyle: FontStyle.normal,
  fontWeight: FontWeight.w300,
  fontSize: 16.sp,
  color: colorBlack,
);
final typoVietNamProRegular16Orange = GoogleFonts.nunito(
  fontStyle: FontStyle.normal,
  fontWeight: FontWeight.w300,
  fontSize: 16.sp,
  color: colorPrimaryOrange100,
  letterSpacing: 0.2,
);

final typoVietNamProRegular18 = GoogleFonts.nunito(
  fontStyle: FontStyle.normal,
  fontWeight: FontWeight.w300,
  fontSize: 18.sp,
  color: colorBlack,
);

final typoVietNamProRegular20 = GoogleFonts.nunito(
  fontStyle: FontStyle.normal,
  fontWeight: FontWeight.w300,
  fontSize: 20.sp,
  color: colorBlack,
);

final typoVietNamProBold12 = GoogleFonts.nunito(
  fontStyle: FontStyle.normal,
  fontWeight: FontWeight.bold,
  fontSize: 12.sp,
  color: colorBlack,
);

final typoVietNamProBold11 = GoogleFonts.nunito(
  fontStyle: FontStyle.normal,
  fontWeight: FontWeight.bold,
  fontSize: 11.sp,
  color: colorBlack,
);

final typoVietNamProBold18 = GoogleFonts.nunito(
  fontStyle: FontStyle.normal,
  fontWeight: FontWeight.w600,
  fontSize: 18.sp,
  color: colorBlack,
);
final typoVietNamProBold18orange = GoogleFonts.nunito(
  fontStyle: FontStyle.normal,
  fontWeight: FontWeight.w600,
  fontSize: 18.sp,
  color: colorPrimaryOrange100,
);
final typoVietNamProBold20 = GoogleFonts.nunito(
  fontStyle: FontStyle.normal,
  fontWeight: FontWeight.w600,
  fontSize: 20.sp,
  color: colorBlack,
);

final typoVietNamProBold24 = GoogleFonts.nunito(
  fontStyle: FontStyle.normal,
  fontWeight: FontWeight.w600,
  fontSize: 24.sp,
  color: colorBlack,
);

final typoVietNamProBold36 = GoogleFonts.nunito(
  fontStyle: FontStyle.normal,
  fontWeight: FontWeight.w600,
  fontSize: 36.sp,
  color: colorBlack,
);

final typoVietNamProBold30 = GoogleFonts.nunito(
  fontStyle: FontStyle.normal,
  fontWeight: FontWeight.w600,
  fontSize: 30.sp,
  color: colorBlack,
);

final typoVietNamProBold16 = GoogleFonts.nunito(
  fontStyle: FontStyle.normal,
  fontWeight: FontWeight.w600,
  fontSize: 16.sp,
  color: colorBlack,
);
final typoVietNamProBold16Orange = GoogleFonts.nunito(
  fontStyle: FontStyle.normal,
  fontWeight: FontWeight.w600,
  fontSize: 16.sp,
  color: colorPrimaryOrange100,
);

final typoVietNamProBold15 = GoogleFonts.nunito(
  fontStyle: FontStyle.normal,
  fontWeight: FontWeight.w600,
  fontSize: 15.sp,
  color: colorBlack,
);

final typoVietNamProBold14 = GoogleFonts.nunito(
  fontStyle: FontStyle.normal,
  fontWeight: FontWeight.w600,
  fontSize: 14.sp,
  color: colorBlack,
);

final typoVietNamProBold13 = GoogleFonts.nunito(
  fontStyle: FontStyle.normal,
  fontWeight: FontWeight.w600,
  fontSize: 13.sp,
  color: colorBlack,
);

final typoVietNamProRegular13 = GoogleFonts.nunito(
  fontStyle: FontStyle.normal,
  fontWeight: FontWeight.w300,
  fontSize: 13.sp,
  color: colorBlack,
);

final typoVietNamProRegular12 = GoogleFonts.nunito(
  fontStyle: FontStyle.normal,
  fontWeight: FontWeight.w300,
  fontSize: 12.sp,
  color: colorBlack,
);

final typoVietNamProRegular11 = GoogleFonts.nunito(
  fontStyle: FontStyle.normal,
  fontWeight: FontWeight.w300,
  fontSize: 11.sp,
  color: colorBlack,
);

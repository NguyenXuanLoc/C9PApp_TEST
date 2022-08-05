library app.globals;

import 'package:flutter_screenutil/flutter_screenutil.dart';

String accessToken = '';
String errorBanner='https://com9phut.vn/home-banner.png';
String avatar =
    'https://platform-static-files.s3.amazonaws.com/premierleague/photos/players/250x250/Photo-Missing.png';
String userName = '';
String phoneNumber = '';

bool isLogin = false;
bool isNeedUpdateProfile = true;
bool isActive = false;
bool isOpenYourOrder = false;
bool isOrderDetail = false;
int timePackageRemaining = 0;
int timeOut = 30;

String privacyUrl = 'https://api-mobile.com9phut.vn/privacy.html';
String tempOfUseUrl = 'https://api-mobile.com9phut.vn/terms-of-use.html';
double heightContinue = 37.7.h;
double contentPadding = 13.w;

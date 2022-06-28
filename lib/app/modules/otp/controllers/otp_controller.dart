import 'dart:async';
import 'dart:convert';

import 'package:c9p/app/components/dialogs.dart';
import 'package:c9p/app/components/otp_widget.dart';
import 'package:c9p/app/config/constant.dart';
import 'package:c9p/app/data/model/user_model.dart';
import 'package:c9p/app/data/provider/user_provider.dart';
import 'package:c9p/app/routes/app_pages.dart';
import 'package:c9p/app/utils/storage_utils.dart';
import 'package:c9p/app/utils/toast_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../config/app_translation.dart';
import '../../../config/resource.dart';
import '../../../utils/app_utils.dart';

class OtpController extends GetxController {
  final phoneNumber = ''.obs;
  final userProvider = UserProvider();
  final otpController = OtpFieldController();
  late Timer _timer;
  var startCountDown = 30.obs;
  var verificationId = '';
  var pin = '';
  var errorOtp = ''.obs;
  var auth = FirebaseAuth.instance;

  void verifyPhone() async {
    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
          phoneNumber: Utils.standardizePhoneNumber(phoneNumber.value),
          verificationCompleted: (PhoneAuthCredential credential) async {},
          verificationFailed: (FirebaseAuthException e) {},
          codeSent: (String verificationId, int? resendToken) {
            this.verificationId = verificationId;
          },
          codeAutoRetrievalTimeout: (String verification) {
            verificationId = verification;
          },
          timeout: const Duration(seconds: 120));
    } catch (ex) {}
  }

  void setPin(String pin) => this.pin = pin;

  bool isValid() {
    if (pin.length != 6) {
      errorOtp.value = LocaleKeys.otp_invalid.tr;
      return false;
    }
    errorOtp.value = '';
    return true;
  }

  void confirm(BuildContext context) async {
    if (!isValid()) return;
    Dialogs.showLoadingDialog(context);
    await FirebaseAuth.instance
        .signInWithCredential(PhoneAuthProvider.credential(
            verificationId: verificationId, smsCode: pin))
        .then((value) async {
          _handleLogin(value);
        })
        .whenComplete(() {})
        .onError((error, stackTrace) {
          if (error.toString().contains(MessageKey.otp_invalid) ||
              error.toString().contains(MessageKey.verification_id_invalid)) {
            toast(LocaleKeys.wrong_otp.tr);
          } else if (error.toString().contains(MessageKey.otp_expired)) {
            toast(LocaleKeys.otp_het_han.tr);
          }
          Dialogs.hideLoadingDialog();
        });
  }

  Future<void> _handleLogin(UserCredential model) async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    var deviceToken = await messaging.getToken();
    var response = await userProvider.login(model.user!.uid, deviceToken ?? '');
    await Dialogs.hideLoadingDialog();
    if (response.error == null && response.data != null) {
      try {
        var model = UserModel.fromJson(response.data);
        await StorageUtils.saveUser(model);
        if (model.needUpdate ?? true) {
          Get.offAllNamed(Routes.UPDATE_PROFILE, arguments: phoneNumber.value);
        } else {
          Get.offAllNamed(Routes.HOME,
              arguments: await StorageUtils.isFirstOrder());
        }
      } catch (ex) {
        toast(LocaleKeys.network_error.tr);
      }
    } else {
      toast(LocaleKeys.network_error.tr);
    }
  }

  Future<UserModel> fakeUser() async => UserModel.fromJson(
      json.decode(await rootBundle.loadString(R.assetsJsonUser)));

  void startTimer({bool isVerify = false}) {
    if (isVerify) {
      verifyPhone();
    }
    startCountDown.value = 30;
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (Timer timer) {
        if (startCountDown.value == 0) {
          timer.cancel();
        } else {
          startCountDown.value--;
        }
      },
    );
  }

  @override
  void onInit() {
    startTimer();
    phoneNumber.value = Get.arguments;
    verifyPhone();
    super.onInit();
  }
}

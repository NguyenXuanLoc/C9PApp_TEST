import 'dart:async';
import 'dart:convert';

import 'package:c9p/app/components/dialogs.dart';
import 'package:c9p/app/components/otp_widget.dart';
import 'package:c9p/app/data/model/user_model.dart';
import 'package:c9p/app/data/provider/user_provider.dart';
import 'package:c9p/app/routes/app_pages.dart';
import 'package:c9p/app/utils/log_utils.dart';
import 'package:c9p/app/utils/storage_utils.dart';
import 'package:c9p/app/utils/toast_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../config/app_translation.dart';
import '../../../config/resource.dart';
import '../../../utils/app_utils.dart';

class OtpController extends GetxController {
  final END_TIME =90;
  final phoneNumber = ''.obs;
  final userProvider = UserProvider();
  final otpController = OtpFieldController();
  final otpController1 = TextEditingController();
  late Timer _timer;
  var startCountDown = 90.obs;
  var timeDisplay ='01:30'.obs;
  var verificationId = '';
  final pin = ''.obs;
  var errorOtp = ''.obs;
  var auth = FirebaseAuth.instance;

  void verifyPhone() async {
    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
          phoneNumber: Utils.standardizePhoneNumber(phoneNumber.value),
          verificationCompleted: (PhoneAuthCredential credential) async {},
          verificationFailed: (FirebaseAuthException e) {
            toast(LocaleKeys.network_error.tr);
          },
          codeSent: (String verificationId, int? resendToken) {
            this.verificationId = verificationId;
          },
          codeAutoRetrievalTimeout: (String verification) {
            verificationId = verification;
          },
          timeout: Duration(seconds: END_TIME - 2));
    } catch (ex) {
      toast(LocaleKeys.network_error.tr);
    }
  }

  void getTimeDisplay() => timeDisplay.value = startCountDown.value >= 60
      ? '01:${(startCountDown.value-60).toString().length == 1 ? '0${startCountDown.value-60}' : startCountDown.value-60}'
      : '00:${startCountDown.value.toString().length == 1 ? '0${startCountDown.value}' : startCountDown.value}';

  void setPin(String pin) => this.pin.value = pin;

  bool isValid() {
    if (pin.value.length != 6) {
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
            verificationId: verificationId, smsCode: pin.value))
        .then((value) async {
          _handleLogin(value);
        })
        .whenComplete(() {})
        .onError((error, stackTrace) {
          /*      if (error.toString().contains(MessageKey.otp_invalid) ||
              error.toString().contains(MessageKey.verification_id_invalid)) {
            toast(LocaleKeys.wrong_otp.tr);
          } else if (error.toString().contains(MessageKey.otp_expired)) {
            toast(LocaleKeys.otp_het_han.tr);
          }*/
          toast(LocaleKeys.wrong_otp.tr);
          Dialogs.hideLoadingDialog();
        });
  }

  Future<void> _handleLogin(UserCredential model) async {
    var deviceToken = await Utils.getFirebaseToken();
    var response = await userProvider.login(model.user!.uid, deviceToken ?? '');
    await Dialogs.hideLoadingDialog();
    if (response.error == null && response.data != null) {
      try {
        var model = UserModel.fromJson(response.data);
        await StorageUtils.saveUser(model);
        var registerDeviceResponse =
            await userProvider.registerDevice(deviceToken ?? '');
        if (registerDeviceResponse.error == null) {
          await StorageUtils.setRegisterDevice(true);
        }
        if (model.needUpdate?? true) {
          Get.offAllNamed(Routes.UPDATE_PROFILE, arguments: phoneNumber.value);
        } else if(model.missingPinCode ?? true){
          Get.offAllNamed(Routes.REGISTER_PIN, arguments: phoneNumber.value);
        }
        else {
          Get.offAllNamed(Routes.HOME, arguments: true);
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
    startCountDown.value = END_TIME;
    timeDisplay.value = '01:30';
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (Timer timer) {
        if (startCountDown.value == 0) {
          timer.cancel();
        } else {
          startCountDown.value--;
          getTimeDisplay();
        }
      },
    );
  }

  @override
  void onInit() {
    startTimer();
    phoneNumber.value = Get.arguments;
    verifyPhone();
    WidgetsBinding.instance
        .addPostFrameCallback((timeStamp) => otpController.setFocus(0));
    super.onInit();
  }
}

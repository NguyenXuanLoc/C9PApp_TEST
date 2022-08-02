import 'package:get/get.dart';

class RegisterPinController extends GetxController {
  //TODO: Implement RegisterPinController
  final pin = ''.obs;
  final count = 0.obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  void setPin(String pin) => this.pin.value = pin;

  @override
  void onClose() {}

  void increment() => count.value++;
}

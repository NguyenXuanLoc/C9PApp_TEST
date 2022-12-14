import 'dart:async';

import 'package:c9p/app/components/dialogs.dart';
import 'package:c9p/app/config/app_translation.dart';
import 'package:c9p/app/config/constant.dart';
import 'package:c9p/app/data/model/LocationModel.dart';
import 'package:c9p/app/data/model/order_model.dart';
import 'package:c9p/app/data/provider/api_result.dart';
import 'package:c9p/app/data/provider/user_provider.dart';
import 'package:c9p/app/routes/app_pages.dart';
import 'package:c9p/app/utils/app_utils.dart';
import 'package:c9p/app/utils/storage_utils.dart';
import 'package:c9p/app/utils/tag_utils.dart';
import 'package:c9p/app/utils/toast_utils.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:c9p/app/config/globals.dart' as globals;
import '../../../config/resource.dart';
import '../../../data/model/address_model.dart';
import '../../../data/model/my_combo_model.dart';
import '../../../utils/log_utils.dart';
class RiceOrderParam{
 final String name;
 final String phone;
 final String address;
 final DateTime deliverDate;
 final String deliverHour;
  final String qty;
  final double lat;
  final double long;
  final String productId;
  final MyComboModel? myComboModel;
  RiceOrderParam(this.name, this.phone, this.address, this.deliverDate, this.deliverHour, this.qty, this.lat, this.long, this.productId, this.myComboModel);
}
class OrderController extends GetxController {
  String tag;
  OrderController(): tag = Utils.getRandomTag();
  final lDescriptionImage = [
    R.assetsPngComSuon9p,
    R.assetsPngComSuon9p,
    R.assetsPngComSuon9p,
  ];

  List<String> suggestCount() => [
        '1',
        '2',
        '3',
        '4',
        '5',
      ];

  final userProvider = UserProvider();
  final scrollController = ScrollController();
  final pageController = PageController();
  final fullNameController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();
  final dateController = TextEditingController();
  final hourController = TextEditingController();
  final countController = TextEditingController();
  DateTime? deliverDate;
  String? deliverHours;
  final currentIndex = 0.obs;
  final errorFullName = ''.obs;
  final errorPhoneNumber = ''.obs;
  final errorAddress = ''.obs;
  final errorDate = ''.obs;
  final errorHours = ''.obs;
  final errorCount = ''.obs;
  var currentLat = 0.0;
  var currentLng = 0.0;
  String? currentAddress;
  var isSelectAddress = true;
  OrderModel? orderModel;
  MyComboModel? myComboModel;
  @override
  void onInit() {
    myComboModel = (Get.arguments is MyComboModel) ? Get.arguments : null;
    getCurrentAddress();
    getInfoReOrder();
    switchPageListener();
    super.onInit();
  }

  @override
  void onReady() {
    StorageUtils.setIsFirstOrder(false);
    super.onReady();
  }

  void getInfoReOrder() {
    if (Get.arguments != null && Get.arguments is OrderModel) {
      orderModel = Get.arguments;
      fullNameController.text = orderModel?.buyerName ?? '';
      phoneController.text = orderModel?.buyerPhone ?? '';
      addressController.text = orderModel?.toAddress ?? '';
      addressController.text = orderModel?.toAddress ?? '';
      currentAddress = addressController.text;
      countController.text =
          orderModel?.itemQty != null ? orderModel!.itemQty.toString() : '1';

      if (orderModel!.deliverTime!.isAfter(DateTime.now())) {
        deliverDate = orderModel?.deliverTime;
        dateController.text =
            Utils.convertTimeToDDMMYY(deliverDate ?? DateTime.now());
      } else {
        deliverDate = DateTime.now();
        dateController.text = Utils.convertTimeToDDMMYY(DateTime.now());
      }
      hourController.text =
          Utils.convertTimeToHHMM(deliverDate ?? DateTime.now());
      hourController.text =
          DateFormat("h:mma").format(orderModel?.deliverTime ?? DateTime.now());
    } else {
      fullNameController.text = globals.userName;
      phoneController.text = globals.phoneNumber.replaceAll('+84', '0');
      deliverDate = DateTime.now();
      dateController.text = Utils.convertTimeToDDMMYY(DateTime.now());
    }
    var currentTime = DateTime.fromMillisecondsSinceEpoch(
        DateTime.now().millisecondsSinceEpoch + AppConstant.FIFTEN_MINIUTES+60000);
    deliverHours = Utils.convertTimeToHHMMA(currentTime);
    hourController.text = Utils.time24to12Format(currentTime);
  }

  void scrollToBottom() => Timer(
      const Duration(milliseconds: 500),
      () => scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 500),
          curve: Curves.fastOutSlowIn));

  void switchPageListener() {
    pageController.addListener(() {
      final newPage = pageController.page!.round();
      if (newPage != currentIndex) {
        currentIndex.value = newPage;
      }
    });
  }

  void continueOnclick(BuildContext context) async {
    if (isValid()) {
      if (myComboModel != null &&
          (myComboModel!.remainsCombo ?? 0) <
              int.parse(countController.text)) {
        toast(LocaleKeys.notify_slot_order_bigger_remain_in_combo.tr);
        return;
      }
      var name = fullNameController.text;
      var address = addressController.text;
      var phone = phoneController.text;
      var qty = countController.text;
       var productId = '2';
      var orderParam = RiceOrderParam(name, phone, address, deliverDate!,
          deliverHours!, qty, currentLat, currentLng, productId, myComboModel);
      Get.toNamed(Routes.CONFIRM_RICE_ORDER, arguments: orderParam);
      /* Dialogs.showLoadingDialog(context);
      var response = await addOrder();
      await Dialogs.hideLoadingDialog();
      if (response.statusCode == 201) {
        Get.toNamed(Routes.ORDER_SUCCESS,
            arguments: OrderModel.fromJson(response.data));
      } else {
        try {
          toast(response.data['msg'].toString());
        } catch (ex) {
          toast(LocaleKeys.network_error.tr);
        }
      }*/
    }
  }

  bool isValid() {
    var fullName = fullNameController.text;
    var phone = phoneController.text;
    var address = addressController.text;
    var date = dateController.text;
    var hours = hourController.text;
    var count = countController.text;
    var isValid = true;
    if (fullName.isEmpty) {
      errorFullName.value = LocaleKeys.please_input_full_name.tr;
      isValid = false;
    } else {
      errorFullName.value = '';
    }
    if (phone.isEmpty) {
      errorPhoneNumber.value = LocaleKeys.please_input_phone_number.tr;
      isValid = false;
    } else if (!Utils.validateMobile(phone)) {
      errorPhoneNumber.value = LocaleKeys.phone_number_khong_hop_le.tr;
      isValid = false;
    } else {
      errorPhoneNumber.value = '';
    }
    if (address.isEmpty || currentAddress != addressController.text) {
      errorAddress.value = LocaleKeys.please_input_delivery_add.tr;
      isValid = false;
    } else {
      errorAddress.value = '';
    }
    if (date.isEmpty) {
      errorDate.value = LocaleKeys.please_input_delivery_date.tr;
      isValid = false;
    } else {
      errorDate.value = '';
    }
    if (hours.isEmpty) {
      errorHours.value = LocaleKeys.please_input_delivery_hours.tr;
      isValid = false;
    } else {
      errorHours.value = '';
    }
    if (count.isEmpty || count == '0') {
      errorCount.value = LocaleKeys.please_input_count.tr;
      isValid = false;
    } else {
      errorCount.value = '';
    }
    return isValid;
  }

  void setAddress(Prediction address) {
    addressController.text = address.description ?? '';
    currentAddress = addressController.text;
    isSelectAddress = true;
    getLocationDetail(address.placeId ?? '');
  }

  void getLocationDetail(String placeId) async {
    var response = await userProvider.getLocationDetail(placeId);
    if (response.error == null && response.data != null) {
      var locationModel = LocationModel.fromJson(response.data);
      currentLng = locationModel.result?.geometry?.location?.lng ?? 0.0;
      currentLat = locationModel.result?.geometry?.location?.lat ?? 0.0;
    } else {
      currentLng = 0.0;
      currentLat = 0.0;
    }
  }

  Future<List<Prediction>> filterAddress(String query) async {
    isSelectAddress = currentAddress == query ? true : false;
    var response = await userProvider.getAddress(query);
    if (response.error == null && response.data != null) {
      var addressModel = addressModelFromJson(response.data);
      if (addressModel.status != null && addressModel.status == MessageKey.OK) {
        return addressModel.predictions ?? [];
      }
    }
    return [];
  }


  void pickTime(BuildContext context) async {
    var selectedTime24Hour = await Utils.pickTime(context);
    if (selectedTime24Hour != null) {
      deliverHours = Utils.convertTime12To24(selectedTime24Hour.hour, selectedTime24Hour.minute);
      hourController.text = Utils.time24to12Format(DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
        selectedTime24Hour.hour,
        selectedTime24Hour.minute,
      ));
    }
  }

  void getCurrentAddress() async {
    if (Get.arguments != null && Get.arguments is OrderModel) return;
    await Utils.requestPermissionLocation();
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    permission = await Geolocator.checkPermission();
    if (serviceEnabled && permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse) {
      var location = await Geolocator.getCurrentPosition();
      currentLat = location.latitude;
      currentLng = location.longitude;
      List<Placemark> placeMark =
      await placemarkFromCoordinates(location.latitude, location.longitude);
      Placemark place = placeMark[0];
      isSelectAddress = true;
      addressController.text =
      "${place.street}, ${place.subAdministrativeArea}, ${place.administrativeArea}";
      currentAddress = addressController.text;
    }
  }
  void pickDate(BuildContext context) => Utils.pickDate(context, (date) {
        deliverDate = date;
        dateController.text = Utils.convertTimeToDDMMYY(date);
      });

  void setCount(String count) => countController.text = count;
  @override
  void onClose() {
    TagUtils().tagsCreateOrder.removeAt(0);
    super.onClose();
  }
}

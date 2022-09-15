import 'dart:convert';

import 'package:c9p/app/config/constant.dart';
import 'package:c9p/app/data/provider/base_provider.dart';
import 'package:c9p/app/utils/log_utils.dart';
import 'package:get/get.dart';

import 'api_result.dart';

class UserProvider extends BaseProvider {
  static final UserProvider instance = UserProvider._internal();

  factory UserProvider() => instance;

  UserProvider._internal() {
    initProvider();
  }

  Future<ApiResult> getAddress(String query) async {
    return await GET(
        'AutoComplete?api_key=${ApiKey.api_key_google_map}&location=20.8467333,106.6637271&input=$query',
        baseUrl: 'https://rsapi.goong.io/Place/');
  }

  Future<ApiResult> getLocationDetail(String placeId) async {
    return await GET(
        'Detail?place_id=$placeId&api_key=${ApiKey.api_key_google_map}',
        baseUrl: 'https://rsapi.goong.io/Place/');
  }

  Future<ApiResult> nearOrder() async {
    return await GET('user/top5orders');
  }

  Future<ApiResult> addOrder(
          {required String name,
          required String address,
          required String phone,
          required String qty,
          required String lat,
          required String lng,
      required String deliverTime,
      required String description,
      required String productId,
      int? comboId,
      int useCombo = 0}) async {
    var body = {
      ApiKey.name: name,
      ApiKey.address: address,
      ApiKey.phone: phone,
      ApiKey.qty: qty,
      ApiKey.lat: lat,
      ApiKey.lng: lng,
      ApiKey.description: description,
      ApiKey.deliverTime: /*'2023-6-15 08:32:21'*/ deliverTime,
      ApiKey.product_id: productId
    };
    logE("TAG BOODY: ${json.encode(body)}");
    if (comboId != null) {
      body[ApiKey.combo_id] = comboId.toString();
      body[ApiKey.useCombo] = useCombo.toString();
    }
    return await POST('user/order', body, isFormData: true);
  }

  Future<ApiResult> paymentRiceOrderByVnPay(
      {required String name,
        required String address,
        required String phone,
        required String qty,
        required String lat,
        required String lng,
        required String deliverTime,
        required String productId,
        required String description,
        int? comboId,
        int useCombo = 0}) async {
    var body = {
      ApiKey.name: name,
      ApiKey.address: address,
      ApiKey.phone: phone,
      ApiKey.qty: qty,
      ApiKey.lat: lat,
      ApiKey.lng: lng,
      ApiKey.deliverTime: /*'2023-6-15 08:32:21'*/ deliverTime,
      ApiKey.product_id: productId,
      ApiKey.description: description
    };
    logE("TAG BODY: ${body.toString()}");
    if (comboId != null) {
      body[ApiKey.combo_id] = comboId.toString();
      body[ApiKey.useCombo] = useCombo.toString();
    }
    return await POST('user/order/payment/vnpay', body, isFormData: true);
  }

  Future<ApiResult> getWeather(
    double lat,
    double lon,
  ) async {
    return await GET(
        'weather?lat=$lat&lon=$lon&exclude=current&appid=${ApiKey.api_key_weather}&lang=vi&units=metric',
        baseUrl: 'https://api.openweathermap.org/data/2.5/',
        isNewFormat: true);
  }

  Future<ApiResult> login(String uid, String deviceToken) async => await POST(
      'user/firebase', {ApiKey.uid: uid, ApiKey.device_token: deviceToken});

  Future<ApiResult> updateProfile(String fullName) async =>
      await POST('user/info', {ApiKey.name: fullName});

  Future<ApiResult> getProfile() async => await GET('user/info');

  Future<ApiResult> gePromotion() async => await GET('banner');

  Future<ApiResult> getPendingOrder({String paging = ''}) async =>
      await GET('user/orders/pending$paging');

  Future<ApiResult> getDoneOrder({String paging = ''}) async =>
      await GET('user/orders/done$paging');

  Future<ApiResult> registerDevice(String deviceToken) async =>
      await POST('user/register_device', {ApiKey.device_token: deviceToken});

  Future<ApiResult> unregisterDevice(String deviceToken) async =>
      await DELETE_WITH_BODY(
          'user/register_device', {ApiKey.device_token: deviceToken});

  Future<ApiResult> logout(String deviceToken) async =>
      await POST('user/logout', {ApiKey.device_token: deviceToken});

  Future<ApiResult> getOrderById(String id) async =>
      await GET('user/order/$id');

  Future<ApiResult> getComboSelling({int nextPage = 1}) async =>
      await GET('sales/combo/active?page=$nextPage');

  Future<ApiResult> loginByAccount(
          {required String phone, required String pass}) async =>
      await POST('user/login', {ApiKey.phone: phone, ApiKey.password: pass});

  Future<ApiResult> getMyCombo({int nextPage = 1}) async =>
      await GET('user/combo/?page=$nextPage');

  Future<ApiResult> createNewPass({required String pass}) async => await POST(
      'user/password/new',
      {ApiKey.password: pass, ApiKey.password_confirmation: pass});

  Future<ApiResult> checkPasswordExits(String phoneNumber) async =>
      await GET('user/password?phone=$phoneNumber');
  // payment/check_payment
  Future<ApiResult> buyCombo(int saleId,String qty) async =>
      await POST('user/combo', {ApiKey.saleId: saleId,ApiKey.qty: qty});

  Future<ApiResult> checkPayment(String orderId) async =>
      await GET('payment/check_payment?orderId=$orderId');

  Future<ApiResult> changePass(
          String oldPass, String newPass, String confirmPass) async =>
      await POST('user/password', {
        ApiKey.password: newPass,
        ApiKey.password_confirmation: confirmPass,
        ApiKey.current_password: oldPass
      });

  Future<ApiResult> uploadAvatar(String path) async => await POST(
      'user/info/avatar',
      {"image": MultipartFile(path, filename: path.split("/").last)},
      isFormData: true);

  Future<ApiResult> deleteAccount() async =>
      await DELETE('user/delete-account');

  Future<ApiResult> getInfoWallet() async => await GET('user/wallet');

  Future<ApiResult> getActiveCoinPack({int nextPage = 1}) async =>
      await GET('sales/xu/active?page=$nextPage');

  Future<ApiResult> buyXuPackage(String packageId, String qty) async =>
      await POST(
          'user/buy-xu-pack', {ApiKey.packId: packageId, ApiKey.qty: qty});

  Future<ApiResult> getHistoryBuyXu({String? varied,required String nextPage}) async =>
      varied != null
          ? await GET('user/wallet/history?page=$nextPage&varied=$varied')
          : await GET('user/wallet/history?page=$nextPage');

  Future<ApiResult> addRiceOrderByXu(
          {required String name,
          required String address,
          required String phone,
          required String qty,
          required String lat,
          required String lng,
          required String deliverTime,
          required String productId,
          required String description,
          int? comboId,
          int useCombo = 0}) async =>
      await POST('user/order/payment/xu', {
        ApiKey.name: name,
        ApiKey.address: address,
        ApiKey.phone: phone,
        ApiKey.qty: qty,
        ApiKey.lat: lat,
        ApiKey.lng: lng,
        ApiKey.description: description,
        ApiKey.deliverTime: deliverTime,
        ApiKey.product_id: productId,
        ApiKey.used_xu: 1,
        ApiKey.useCombo: 0,
      });
  Future<ApiResult> buyComboByXu(int saleId,String qty) async =>
      await POST('user/combo-by-xu', {ApiKey.saleId: saleId,ApiKey.qty: qty});
}

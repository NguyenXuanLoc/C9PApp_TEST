import 'package:c9p/app/config/constant.dart';
import 'package:c9p/app/data/provider/base_provider.dart';

import 'api_result.dart';

class UserProvider extends BaseProvider {
  static final UserProvider instance = UserProvider._internal();

  factory UserProvider() => instance;

  UserProvider._internal() {
    initProvider();
  }

  Future<ApiResult> getAddress(String query) async {
    return await GET(
        'json?input=$query&key=${ApiKey.api_key_google_map}&language=vi&radius=20000',
        baseUrl: 'https://maps.googleapis.com/maps/api/place/autocomplete/');
  }

  Future<ApiResult> getLocationDetail(String placeId) async {
    return await GET('json?place_id=$placeId&key=${ApiKey.api_key_google_map}',
        baseUrl: 'https://maps.googleapis.com/maps/api/place/details/');
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
          required String productId}) async =>
      await POST(
          'order',
          {
            ApiKey.name: name,
            ApiKey.address: address,
            ApiKey.phone: phone,
            ApiKey.qty: qty,
            ApiKey.lat: lat,
            ApiKey.lng: lng,
            ApiKey.deliverTime: /*'2023-6-15 08:32:21'*/ deliverTime,
            ApiKey.product_id: productId
          },
          isFormData: true);

  Future<ApiResult> getWeather(
    double lat,
    double lon,
  ) async {
    return await GET(
        'weather?lat=$lat&lon=$lon&exclude=current&appid=${ApiKey.api_key_weather}&lang=vi&units=metric',
        baseUrl: 'https://api.openweathermap.org/data/2.5/',
        isNewFormat: true);
  }

  Future<ApiResult> login(String uid) async =>
      await POST('user/firebase', {ApiKey.uid: uid});

  Future<ApiResult> updateProfile(String fullName) async =>
      await POST('user/info', {ApiKey.name: fullName});

  Future<ApiResult> getProfile() async => await GET('user/info');
}

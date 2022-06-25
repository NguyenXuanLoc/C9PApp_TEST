import 'package:c9p/app/config/constant.dart';
import 'package:c9p/app/data/provider/base_provider.dart';

import 'api_result.dart';

class UserProvider extends BaseProvider {
  static final UserProvider instance = UserProvider._internal();

  factory UserProvider() => instance;

  UserProvider._internal() {
    initProvider();
  }

/*Future<ApiKey> getAddress(String query){

}*/
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
}

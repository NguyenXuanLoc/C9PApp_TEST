import 'package:c9p/app/config/constant.dart';
import 'package:c9p/app/data/provider/base_provider.dart';

import 'api_result.dart';

class UserProvider extends BaseProvider {
  static final UserProvider instance = UserProvider._internal();

  factory UserProvider() => instance;

  UserProvider._internal() {
    initProvider();
  }

  Future<ApiResult> getWeather(
    double lat,
    double lon,
  ) async {
    return await GET(
        'weather?lat=$lat&lon=$lon&exclude=current&appid=${ApiKey.api_key}&lang=vi&units=metric',
        baseUrl: 'https://api.openweathermap.org/data/2.5/',
        isNewFormat: true);
  }
}

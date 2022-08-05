class StorageKey {
  StorageKey._();

  static const String CurrentToken = 'CurrentToken';
  static const String AccountInfo = 'AccountInfo';
  static const String firstOpenOrder = 'firstOpenOrder';
  static const String scheduleWeather = 'scheduleWeather';
  static const String weather = 'weather';
  static const String orderId = 'orderId';
}

class MessageKey {
  static const String egCodeIsValid = 'Twoja sesja wygasła';
  static const String verification_id_invalid =
      'The verification ID used to create the phone auth credential is invalid.';
  static const String otp_invalid =
      'The sms verification code used to create the phone auth credential is invalid';
  static const String otp_expired = 'The sms code has expired';
  static const String OK = 'OK';
}

class ApiKey {
  static const EXAMINED = 'EXAMINED';
  static const api_key_weather = '0e1fae855949e83b906ee6dcc00708f9'; // weather
  static const api_key_google_map =
      'sHJOZnnjcuyir4oH1HZ1AsOPpHWq4GvvAiLRsdjI'; // weather

  static const name = 'name';
  static const address = 'address';
  static const phone = 'phone';
  static const qty = 'qty';
  static const lat = 'lat';
  static const lng = 'lng';
  static const deliverTime = 'deliverTime';
  static const product_id = 'product_id';
  static const uid = 'uid';
  static const device_token = 'device_token';
  static const password = 'password';
}

class AppConstant {
  static const ONE_DAY = 86400000; //mini giay
  static const FIFTEN_MINIUTES = 900000; //mini giay
  static const REGISTER_DEVICE = 'REGISTER_DEVICE'; //mini giay
  static const URL_WEATHER_ICON = 'http://openweathermap.org/img/wn/';
  static const URL_MENU = 'https://com9phut.vn/menu/';
  static const URL_WEATHER_ICON_DEFAULT =
      'http://openweathermap.org/img/wn/03d@2x.png';
}

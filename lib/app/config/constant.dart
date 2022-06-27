class StorageKey {
  StorageKey._();

  static const String CurrentToken = 'CurrentToken';
  static const String AccountInfo = 'AccountInfo';
  static const String firstOpenOrder = 'firstOpenOrder';
}

class MessageKey {
  static const String egCodeIsValid = 'Twoja sesja wygasła';
  static const String verification_id_invalid =
      'The verification ID used to create the phone auth credential is invalid.';
  static const String otp_invalid =
      'The sms verification code used to create the phone auth credential is invalid';
  static const String otp_expired = 'The sms code has expired';
  static const String ZERO_RESULTS ='ZERO_RESULTS';
}

class ApiKey {
  static const EXAMINED = 'EXAMINED';
  static const api_key_weather = 'cd796c5f287c96f21b833827def34ef1'; // weather
  static const api_key_google_map =
      'AIzaSyDTWuJevSvP9yY0-77_ezp52qimoZnmamY'; // weather

  static const name = 'name';
  static const address = 'address';
  static const phone = 'phone';
  static const qty = 'qty';
  static const lat = 'lat';
  static const lng = 'lng';
  static const deliverTime = 'deliverTime';
  static const product_id = 'product_id';
  static const uid = 'uid';
}

class AppConstant {
  static const URL_WEATHER_ICON = 'http://openweathermap.org/img/wn/';
  static const URL_WEATHER_ICON_DEFAULT =
      'http://openweathermap.org/img/wn/01d@2x.png';
}

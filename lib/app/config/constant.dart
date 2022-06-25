class StorageKey {
  StorageKey._();

  static const String CurrentToken = 'CurrentToken';
  static const String AccountInfo = 'AccountInfo';
}

class MessageKey {
  static const String egCodeIsValid = 'Twoja sesja wygasła';
  static const String verification_id_invalid =
      'The verification ID used to create the phone auth credential is invalid.';
  static const String otp_invalid =
      'The sms verification code used to create the phone auth credential is invalid';
  static const String otp_expired = 'The sms code has expired';
}

class ApiKey {
  static const EXAMINED = 'EXAMINED';
  static const api_key = 'cd796c5f287c96f21b833827def34ef1'; // weather
}

class AppConstant {
  static const URL_WEATHER_ICON = 'http://openweathermap.org/img/wn/!@2x.png';
  static const URL_WEATHER_ICON_DEFAULT = 'http://openweathermap.org/img/wn/01d@2x.png';
}

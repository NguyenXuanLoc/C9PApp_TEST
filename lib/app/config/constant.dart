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
  static const String NOT_FOUND_ANY_USER = 'Not found any user';
  static const String CHANGE_PASSWORD = 'Change Password';
  static const String CREATE_PASSWORD = 'Create password';
  static const String COD  = 'cod';
  static const String VNPay  = 'VNPay';
  static const String avatarDefault  = 'https://via.placeholder.com/150x150.png';
  static const String PENDING = 'Pending';
  static const String CREATED = 'Created';
  static const String DELIVERING = 'Delivering';
  static const String GET = 'Get';
  static const String CANCEL = 'Cancel';
  static const String FAULT = 'Fault';
  static const String SELFPOST = 'Selfpost';
  static const String DELIVERED = 'Delivered';
  static const String PAYED = 'Payed';
  static const String XU = 'Xu';

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
  static const description = 'description';
  static const deliverTime = 'deliverTime';
  static const product_id = 'product_id';
  static const uid = 'uid';
  static const device_token = 'device_token';
  static const saleId = 'saleId';
  static const password = 'password';
  static const password_confirmation = 'password_confirmation';
  static const current_password = 'current_password';
  static const vnp_ResponseCode = 'vnp_ResponseCode';
  static const combo_id = 'combo_id';
  static const useCombo = 'useCombo';
  static const packId = 'packId';
  static const minus = 'minus';
  static const plus = 'plus';
  static const used_xu = 'used_xu';
}

class AppConstant {
  static const ONE_DAY = 86400000; //mini giay
  static const FIFTEN_MINIUTES = 900000; //mini giay
  static const REGISTER_DEVICE = 'REGISTER_DEVICE'; //mini giay
  static const URL_WEATHER_ICON = 'http://openweathermap.org/img/wn/';
  static const URL_MENU = 'https://com9phut.vn/menu/';
  static const URL_WEATHER_ICON_DEFAULT =
      'http://openweathermap.org/img/wn/03d@2x.png';
  static const PAYMENT_SUCCESSFULL='00';
}

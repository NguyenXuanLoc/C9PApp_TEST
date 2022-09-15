import 'dart:convert';

PaymentInfoModel paymentInfoModelFromJson(String str) =>
    PaymentInfoModel.fromJson(json.decode(str));

String paymentInfoModelToJson(PaymentInfoModel data) =>
    json.encode(data.toJson());

class PaymentInfoModel {
  PaymentInfoModel({
    this.data,
    this.isSucess,
    this.message,
    this.isLogout,
  });

  String? data;
  bool? isSucess;
  String? message;
  bool? isLogout;

  factory PaymentInfoModel.fromJson(Map<String, dynamic> json) =>
      PaymentInfoModel(
        data: json["data"],
        isSucess: json["isSucess"],
        message: json["message"],
        isLogout: json["isLogout"],
      );

  Map<String, dynamic> toJson() => {
        "data": data,
        "isSucess": isSucess,
        "message": message,
        "isLogout": isLogout,
      };

  PaymentInfoModel copyOf(
  {String? data, bool? isSucess, String? message, bool? isLogout}) =>
      PaymentInfoModel(
          data: data ?? this.data,
          isSucess: isSucess ?? this.isSucess,
          message: message ?? this.message,
          isLogout: isLogout ?? this.isLogout);
}

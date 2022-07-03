// To parse this JSON data, do
//
//     final notifyModel = notifyModelFromJson(jsonString);

import 'dart:convert';

NotifyModel notifyModelFromJson(String str) => NotifyModel.fromJson(json.decode(str));

String notifyModelToJson(NotifyModel data) => json.encode(data.toJson());

class NotifyModel {
  NotifyModel({
    this.msg,
    this.orderShipStatus,
    this.orderId,
    this.orderStatus,
  });

  String? msg;
  String? orderShipStatus;
  String? orderId;
  String? orderStatus;

  factory NotifyModel.fromJson(Map<String, dynamic> json) => NotifyModel(
    msg: json["msg"],
    orderShipStatus: json["orderShipStatus"],
    orderId: json["orderId"],
    orderStatus: json["orderStatus"],
  );

  Map<String, dynamic> toJson() => {
    "msg": msg,
    "orderShipStatus": orderShipStatus,
    "orderId": orderId,
    "orderStatus": orderStatus,
  };
}

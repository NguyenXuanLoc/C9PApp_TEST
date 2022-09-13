// To parse this JSON data, do
//
//     final paymentSuccessModel = paymentSuccessModelFromJson(jsonString);

import 'dart:convert';

PaymentSuccessModel paymentSuccessModelFromJson(String str) => PaymentSuccessModel.fromJson(json.decode(str));

String paymentSuccessModelToJson(PaymentSuccessModel data) => json.encode(data.toJson());

class PaymentSuccessModel {
  PaymentSuccessModel({
    this.data,
    this.isSucess,
    this.message,
    this.isLogout,
  });

  Data? data;
  bool? isSucess;
  String? message;
  bool? isLogout;

  factory PaymentSuccessModel.fromJson(Map<String, dynamic> json) => PaymentSuccessModel(
    data: Data.fromJson(json["data"]),
    isSucess: json["isSucess"],
    message: json["message"],
    isLogout: json["isLogout"],
  );

  Map<String, dynamic> toJson() => {
    "data": data?.toJson(),
    "isSucess": isSucess,
    "message": message,
    "isLogout": isLogout,
  };
}

class Data {
  Data({
    this.id,
    this.description,
    this.fromAddress,
    this.toAddress,
    this.hubPhoneNumber,
    this.hubPhoneName,
    this.buyerPhone,
    this.buyerName,
    this.codAmount,
    this.shippingFee,
    this.deliverTime,
    this.shopOrderId,
    this.category,
    this.imageUrl,
    this.orderId,
    this.weight,
    this.createdTime,
    this.acceptedTime,
    this.inDeliveryTime,
    this.deliverredTime,
    this.verifiedTime,
    this.canceledTime,
    this.cancelReason,
    this.canceledBy,
    this.trackingUrl,
    this.returnType,
    this.returnAmount,
    this.notesType,
    this.fromLocation,
    this.toLocation,
    this.locality,
    this.itemQty,
    this.status,
    this.updatedAt,
    this.userId,
    this.channel,
    this.productId,
    this.orderStatus,
    this.amount,
    this.shipperName,
    this.shipperPhone,
    this.shipperNumber,
    this.shipperRate,
    this.orderType,
    this.comboId,
    this.returnXu
  });

  int? id;
  dynamic? description;
  String? fromAddress;
  String? toAddress;
  String? hubPhoneNumber;
  String? hubPhoneName;
  String? buyerPhone;
  String? buyerName;
  int? codAmount;
  int? shippingFee;
  dynamic? deliverTime;
  String? shopOrderId;
  dynamic? category;
  String? imageUrl;
  dynamic? orderId;
  int? weight;
  DateTime? createdTime;
  dynamic acceptedTime;
  dynamic inDeliveryTime;
  dynamic deliverredTime;
  dynamic verifiedTime;
  dynamic canceledTime;
  dynamic cancelReason;
  dynamic canceledBy;
  dynamic trackingUrl;
  dynamic returnType;
  dynamic returnAmount;
  dynamic notesType;
  dynamic fromLocation;
  dynamic toLocation;
  dynamic locality;
  int? itemQty;
  String? status;
  DateTime? updatedAt;
  int? userId;
  dynamic channel;
  dynamic productId;
  dynamic orderStatus;
  int? amount;
  int? returnXu;
  dynamic shipperName;
  dynamic shipperPhone;
  dynamic shipperNumber;
  dynamic shipperRate;
  String? orderType;
  int? comboId;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    description: json["Description"],
    fromAddress: json["FromAddress"],
    toAddress: json["ToAddress"],
    hubPhoneNumber: json["HubPhoneNumber"],
    hubPhoneName: json["HubPhoneName"],
    buyerPhone: json["BuyerPhone"],
    buyerName: json["BuyerName"],
    codAmount: json["CodAmount"],
    shippingFee: json["ShippingFee"],
    deliverTime: json["DeliverTime"],
    shopOrderId: json["ShopOrderId"],
    category: json["Category"],
    imageUrl: json["ImageUrl"],
    orderId: json["OrderId"],
    weight: json["Weight"],
    createdTime: DateTime.parse(json["CreatedTime"]),
    acceptedTime: json["AcceptedTime"],
    inDeliveryTime: json["InDeliveryTime"],
    deliverredTime: json["DeliverredTime"],
    verifiedTime: json["VerifiedTime"],
    canceledTime: json["CanceledTime"],
    cancelReason: json["CancelReason"],
    canceledBy: json["CanceledBy"],
    trackingUrl: json["TrackingUrl"],
    returnType: json["ReturnType"],
    returnAmount: json["ReturnAmount"],
    notesType: json["NotesType"],
    fromLocation: json["FromLocation"],
    toLocation: json["ToLocation"],
    locality: json["Locality"],
    itemQty: json["ItemQty"],
    status: json["Status"],
    updatedAt: DateTime.parse(json["updated_at"]),
    userId: json["user_id"],
    channel: json["channel"],
    productId: json["product_id"],
    orderStatus: json["OrderStatus"],
    amount: json["Amount"],
    shipperName: json["shipper_name"],
    shipperPhone: json["shipper_phone"],
    shipperNumber: json["shipper_number"],
    shipperRate: json["shipper_rate"],
    orderType: json["order_type"],
    comboId: json["combo_id"],
    returnXu: json["return_xu"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "Description": description,
    "FromAddress": fromAddress,
    "ToAddress": toAddress,
    "HubPhoneNumber": hubPhoneNumber,
    "HubPhoneName": hubPhoneName,
    "BuyerPhone": buyerPhone,
    "BuyerName": buyerName,
    "CodAmount": codAmount,
    "ShippingFee": shippingFee,
    "DeliverTime": deliverTime,
    "ShopOrderId": shopOrderId,
    "Category": category,
    "ImageUrl": imageUrl,
    "OrderId": orderId,
    "Weight": weight,
    "CreatedTime": createdTime?.toIso8601String(),
    "AcceptedTime": acceptedTime,
    "InDeliveryTime": inDeliveryTime,
    "DeliverredTime": deliverredTime,
    "VerifiedTime": verifiedTime,
    "CanceledTime": canceledTime,
    "CancelReason": cancelReason,
    "CanceledBy": canceledBy,
    "TrackingUrl": trackingUrl,
    "ReturnType": returnType,
    "ReturnAmount": returnAmount,
    "NotesType": notesType,
    "FromLocation": fromLocation,
    "ToLocation": toLocation,
    "Locality": locality,
    "ItemQty": itemQty,
    "Status": status,
    "updated_at": updatedAt?.toIso8601String(),
    "user_id": userId,
    "channel": channel,
    "product_id": productId,
    "OrderStatus": orderStatus,
    "Amount": amount,
    "shipper_name": shipperName,
    "shipper_phone": shipperPhone,
    "shipper_number": shipperNumber,
    "shipper_rate": shipperRate,
    "order_type": orderType,
    "combo_id": comboId,
  };
}

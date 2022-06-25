// To parse this JSON data, do
//
//     final orderModel = orderModelFromJson(jsonString);

import 'dart:convert';

List<OrderModel> orderModelFromJson(dynamic str) => List<OrderModel>.from(str.map((x) => OrderModel.fromJson(x)));

String orderModelToJson(List<OrderModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class OrderModel {
  OrderModel({
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
  DateTime? deliverTime;
  String? shopOrderId;
  String? category;
  dynamic? imageUrl;
  int? orderId;
  int? weight;
  DateTime? createdTime;
  dynamic? acceptedTime;
  dynamic inDeliveryTime;
  dynamic deliverredTime;
  dynamic verifiedTime;
  dynamic canceledTime;
  dynamic cancelReason;
  int? canceledBy;
  String? trackingUrl;
  int? returnType;
  int? returnAmount;
  int? notesType;
  String? fromLocation;
  String? toLocation;
  dynamic locality;
  int? itemQty;
  String? status;
  DateTime? updatedAt;
  int? userId;
  String? channel;
  int? productId;

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
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
    deliverTime: DateTime.parse(json["DeliverTime"]),
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
    "DeliverTime": deliverTime!.toIso8601String(),
    "ShopOrderId": shopOrderId,
    "Category": category,
    "ImageUrl": imageUrl,
    "OrderId": orderId,
    "Weight": weight,
    "CreatedTime": createdTime!.toIso8601String(),
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
    "updated_at": updatedAt!.toIso8601String(),
    "user_id": userId,
    "channel": channel,
    "product_id": productId,
  };
}

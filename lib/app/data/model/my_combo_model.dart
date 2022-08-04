// To parse this JSON data, do
//
//     final myComboModel = myComboModelFromJson(jsonString);

import 'dart:convert';

List<MyComboModel> myComboModelFromJson(List<dynamic> str) => List<MyComboModel>.from(str.map((x) => MyComboModel.fromJson(x)));

String myComboModelToJson(List<MyComboModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MyComboModel {
  MyComboModel({
    this.id,
    this.userId,
    this.saleId,
    this.initCombo,
    this.remainsCombo,
    this.createdAt,
    this.updatedAt,
    this.orderId,
    this.status,
    this.sale,
  });

  int? id;
  int? userId;
  int? saleId;
  int? initCombo;
  int? remainsCombo;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? orderId;
  String? status;
  Sale? sale;

  factory MyComboModel.fromJson(Map<String, dynamic> json) => MyComboModel(
    id: json["id"],
    userId: json["user_id"],
    saleId: json["sale_id"],
    initCombo: json["init_combo"],
    remainsCombo: json["remains_combo"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    orderId: json["order_id"],
    status: json["status"],
    sale: Sale.fromJson(json["sale"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "sale_id": saleId,
    "init_combo": initCombo,
    "remains_combo": remainsCombo,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "order_id": orderId,
    "status": status,
    "sale": sale?.toJson(),
  };
}

class Sale {
  Sale({
    this.id,
    this.name,
    this.startDate,
    this.endDate,
    this.status,
    this.inStock,
    this.discount,
    this.getFree,
    this.createdAt,
    this.updatedAt,
    this.img,
    this.description,
    this.code,
    this.price,
    this.saleId,
  });

  int? id;
  String? name;
  DateTime? startDate;
  DateTime? endDate;
  String? status;
  int? inStock;
  int? discount;
  int? getFree;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? img;
  String? description;
  String? code;
  String? price;
  String? saleId;

  factory Sale.fromJson(Map<String, dynamic> json) => Sale(
    id: json["id"],
    name: json["name"],
    startDate: DateTime.parse(json["start_date"]),
    endDate: DateTime.parse(json["end_date"]),
    status: json["status"],
    inStock: json["in_stock"],
    discount: json["discount"],
    getFree: json["get_free"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    img: json["img"],
    description: json["description"],
    code: json["code"],
    price: json["price"],
    saleId: json["sale_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "start_date": startDate?.toIso8601String(),
    "end_date": endDate?.toIso8601String(),
    "status": status,
    "in_stock": inStock,
    "discount": discount,
    "get_free": getFree,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "img": img,
    "description": description,
    "code": code,
    "price": price,
    "sale_id": saleId,
  };
}

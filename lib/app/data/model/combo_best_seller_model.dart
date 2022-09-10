// To parse this JSON data, do
//
//     final ComboSellingModel = ComboSellingModelFromJson(jsonString);

import 'dart:convert';

List<ComboSellingModel> comboSellingModelFromJson(List<dynamic> str) =>
    List<ComboSellingModel>.from(str.map((x) => ComboSellingModel.fromJson(x)));

String comboSellingModelToJson(List<ComboSellingModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ComboSellingModel {
  ComboSellingModel({
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

  factory ComboSellingModel.fromJson(Map<String, dynamic> json) =>
      ComboSellingModel(
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

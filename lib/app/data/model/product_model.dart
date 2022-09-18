// To parse this JSON data, do
//
//     final ProductModel = ProductModelFromJson(jsonString);

import 'dart:convert';

List<ProductModel> productModelFromJson(List<dynamic> str) =>
    List<ProductModel>.from(str.map((x) => ProductModel.fromJson(x)));

String productModelToJson(List<ProductModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProductModel {
  ProductModel({
    this.id,
    this.name,
    this.price,
    this.weight,
    this.createdAt,
    this.updatedAt,
    this.img,
    this.description,
    this.imgList,
    this.shippingFee,
    this.sales,
  });

  int? id;
  String? name;
  int? price;
  int? weight;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? img;
  String? description;
  String? imgList;
  int? shippingFee;
  List<dynamic>? sales;

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json["id"],
        name: json["name"],
        price: json["price"],
        weight: json["weight"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        img: json["img"],
        description: json["description"],
        imgList: json["img_list"],
        shippingFee: json["shipping_fee"],
        sales: List<dynamic>.from(json["sales"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "price": price,
        "weight": weight,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "img": img,
        "description": description,
        "img_list": imgList,
        "shipping_fee": shippingFee,
        "sales":
            sales != null ? List<dynamic>.from(sales!.map((x) => x)) : null,
      };
}

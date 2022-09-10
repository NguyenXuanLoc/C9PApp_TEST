// To parse this JSON data, do
//
//     final activeXuModel = activeXuModelFromJson(jsonString);

import 'dart:convert';

List<ActiveXuModel> activeXuModelFromJson(List<dynamic> str) =>
    List<ActiveXuModel>.from(str.map((x) => ActiveXuModel.fromJson(x)));

String activeXuModelToJson(List<ActiveXuModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ActiveXuModel {
  ActiveXuModel({
    this.id,
    this.packId,
    this.name,
    this.purchaseNum,
    this.status,
    this.price,
    this.buyXu,
    this.freeXu,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? packId;
  String? name;
  dynamic? purchaseNum;
  String? status;
  int? price;
  int? buyXu;
  int? freeXu;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory ActiveXuModel.fromJson(Map<String, dynamic> json) => ActiveXuModel(
        id: json["id"],
        packId: json["pack_id"],
        name: json["name"],
        purchaseNum: json["purchase_num"],
        status: json["status"],
        price: json["price"],
        buyXu: json["buy_xu"],
        freeXu: json["free_xu"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "pack_id": packId,
        "name": name,
        "purchase_num": purchaseNum,
        "status": status,
        "price": price,
        "buy_xu": buyXu,
        "free_xu": freeXu,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

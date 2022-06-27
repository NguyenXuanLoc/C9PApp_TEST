// To parse this JSON data, do
//
//     final promotionModel = promotionModelFromJson(jsonString);

import 'dart:convert';

List<PromotionModel> promotionModelFromJson(dynamic str) =>
    List<PromotionModel>.from(str.map((x) => PromotionModel.fromJson(x)));

String promotionModelToJson(List<PromotionModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PromotionModel {
  PromotionModel({
    this.id,
    this.imageUrl,
    this.bannerLink,
  });

  int? id;
  String? imageUrl;
  String? bannerLink;

  factory PromotionModel.fromJson(Map<String, dynamic> json) => PromotionModel(
        id: json["id"],
        imageUrl: json["image_url"],
        bannerLink: json["banner_link"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "image_url": imageUrl,
        "banner_link": bannerLink,
      };
}

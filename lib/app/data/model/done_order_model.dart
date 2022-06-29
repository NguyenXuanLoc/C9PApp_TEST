// To parse this JSON data, do
//
//     final doneOrderModel = doneOrderModelFromJson(jsonString);

import 'dart:convert';

import 'package:c9p/app/data/model/order_model.dart';

DoneOrderModel doneOrderModelFromJson(String str) =>
    DoneOrderModel.fromJson(json.decode(str));

String doneOrderModelToJson(DoneOrderModel data) => json.encode(data.toJson());

class DoneOrderModel {
  DoneOrderModel({
    this.meta,
    this.data,
  });

  Meta? meta;
  List<OrderModel>? data;

  factory DoneOrderModel.fromJson(Map<String, dynamic> json) => DoneOrderModel(
        meta: Meta.fromJson(json["meta"]),
        data: List<OrderModel>.from(
            json["data"].map((x) => OrderModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "meta": meta!.toJson(),
        "data": List<OrderModel>.from(data!.map((x) => x.toJson())),
      };
}

class Meta {
  Meta({
    this.total,
    this.perPage,
    this.currentPage,
    this.lastPage,
    this.firstPage,
    this.firstPageUrl,
    this.lastPageUrl,
    this.nextPageUrl,
    this.previousPageUrl,
  });

  int? total;
  int? perPage;
  int? currentPage;
  int? lastPage;
  int? firstPage;
  String? firstPageUrl;
  String? lastPageUrl;
  dynamic nextPageUrl;
  dynamic previousPageUrl;

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        total: json["total"],
        perPage: json["per_page"],
        currentPage: json["current_page"],
        lastPage: json["last_page"],
        firstPage: json["first_page"],
        firstPageUrl: json["first_page_url"],
        lastPageUrl: json["last_page_url"],
        nextPageUrl: json["next_page_url"],
        previousPageUrl: json["previous_page_url"],
      );

  Map<String, dynamic> toJson() => {
        "total": total,
        "per_page": perPage,
        "current_page": currentPage,
        "last_page": lastPage,
        "first_page": firstPage,
        "first_page_url": firstPageUrl,
        "last_page_url": lastPageUrl,
        "next_page_url": nextPageUrl,
        "previous_page_url": previousPageUrl,
      };
}

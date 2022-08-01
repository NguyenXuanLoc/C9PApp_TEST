// To parse this JSON data, do
//
//     final addressModel = addressModelFromJson(jsonString);

import 'dart:convert';

AddressModel addressModelFromJson(dynamic str) => AddressModel.fromJson(str);

String addressModelToJson(AddressModel data) => json.encode(data.toJson());

List<Prediction> predictionsModelFromJson(dynamic str) =>
    List<Prediction>.from(str.map((x) => Prediction.fromJson(x)));

String predictionsModelToJson(List<Prediction> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AddressModel {
  AddressModel({
    this.predictions,
    this.status,
  });

  List<Prediction>? predictions;
  String? status;

  factory AddressModel.fromJson(Map<String, dynamic> json) => AddressModel(
        predictions: json["predictions"] !=null? List<Prediction>.from(
            json["predictions"].map((x) => Prediction.fromJson(x))) :[],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "predictions": List<dynamic>.from(predictions!.map((x) => x.toJson())),
        "status": status,
      };
}

class Prediction {
  Prediction({
    this.description,
    this.placeId,
    this.reference,
    this.structuredFormatting,
  });

  String? description;
  String? placeId;
  String? reference;
  StructuredFormatting? structuredFormatting;

  factory Prediction.fromJson(Map<String, dynamic> json) => Prediction(
        description: json["description"],
        placeId: json["place_id"],
        reference: json["reference"],
        structuredFormatting:
            StructuredFormatting.fromJson(json["structured_formatting"]),
      );

  Map<String, dynamic> toJson() => {
        "description": description,
        "place_id": placeId,
        "reference": reference,
        "structured_formatting": structuredFormatting!.toJson(),
      };
}

class StructuredFormatting {
  StructuredFormatting({
    this.mainText,
    this.secondaryText,
  });

  String? mainText;
  String? secondaryText;

  factory StructuredFormatting.fromJson(Map<String, dynamic> json) =>
      StructuredFormatting(
        mainText: json["main_text"],
        secondaryText: json["secondary_text"],
      );

  Map<String, dynamic> toJson() => {
        "main_text": mainText,
        "secondary_text": secondaryText,
      };
}

// To parse this JSON data, do
//
//     final historyXuModel = historyXuModelFromJson(jsonString);

import 'dart:convert';

List<HistoryXuModel> historyXuModelFromJson(List<dynamic> str) =>
    List<HistoryXuModel>.from(str.map((x) => HistoryXuModel.fromJson(x)));

String historyXuModelToJson(List<HistoryXuModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class HistoryXuModel {
  HistoryXuModel({
    this.id,
    this.transactionId,
    this.type,
    this.varied,
    this.description,
    this.status,
    this.amount,
    this.createdAt,
    this.updatedAt,
    this.fromWalletId,
    this.walletId,
  });

  int? id;
  String? transactionId;
  String? type;
  String? varied;
  String? description;
  String? status;
  int? amount;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? fromWalletId;
  String? walletId;

  factory HistoryXuModel.fromJson(Map<String, dynamic> json) => HistoryXuModel(
        id: json["id"],
        transactionId: json["transaction_id"],
        type: json["type"],
        varied: json["varied"],
        description: json["description"],
        status: json["status"],
        amount: json["amount"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        fromWalletId: json["from_wallet_id"],
        walletId: json["wallet_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "transaction_id": transactionId,
        "type": type,
        "varied": varied,
        "description": description,
        "status": status,
        "amount": amount,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "from_wallet_id": fromWalletId,
        "wallet_id": walletId,
      };
}

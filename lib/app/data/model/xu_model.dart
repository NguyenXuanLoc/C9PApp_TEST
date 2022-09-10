// To parse this JSON data, do
//
//     final xuModel = xuModelFromJson(jsonString);

import 'dart:convert';

XuModel xuModelFromJson(String str) => XuModel.fromJson(json.decode(str));

String xuModelToJson(XuModel data) => json.encode(data.toJson());

class XuModel {
  XuModel({
    this.id,
    this.userId,
    this.balance,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.walletId,
    this.user,
  });

  int? id;
  int? userId;
  int? balance;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic? walletId;
  User? user;

  factory XuModel.fromJson(Map<String, dynamic> json) => XuModel(
    id: json["id"],
    userId: json["user_id"],
    balance: json["balance"],
    status: json["status"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    walletId: json["wallet_id"],
    user: User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "balance": balance,
    "status": status,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "wallet_id": walletId,
    "user": user?.toJson(),
  };
}

class User {
  User({
    this.id,
    this.email,
    this.rememberMeToken,
    this.name,
    this.phone,
    this.authToken,
    this.createdAt,
    this.updatedAt,
    this.roleId,
    this.note,
    this.status,
    this.image,
  });

  int? id;
  String? email;
  dynamic? rememberMeToken;
  String? name;
  String? phone;
  String? authToken;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? roleId;
  dynamic? note;
  String? status;
  String? image;

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    email: json["email"],
    rememberMeToken: json["remember_me_token"],
    name: json["name"],
    phone: json["phone"],
    authToken: json["auth_token"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    roleId: json["role_id"],
    note: json["note"],
    status: json["status"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "email": email,
    "remember_me_token": rememberMeToken,
    "name": name,
    "phone": phone,
    "auth_token": authToken,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "role_id": roleId,
    "note": note,
    "status": status,
    "image": image,
  };
}

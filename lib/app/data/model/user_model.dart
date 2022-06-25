// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({
    this.data,
    this.isSucess,
    this.message,
    this.isLogout,
  });

  Data? data;
  bool? isSucess;
  String? message;
  bool? isLogout;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        data: Data.fromJson(json["data"]),
        isSucess: json["isSucess"],
        message: json["message"],
        isLogout: json["isLogout"],
      );

  Map<String, dynamic> toJson() => {
        "data": data!.toJson(),
        "isSucess": isSucess,
        "message": message,
        "isLogout": isLogout,
      };
}

class Data {
  Data({
    this.userData,
    this.bearerToken,
  });

  UserData? userData;
  BearerToken? bearerToken;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        userData: UserData.fromJson(json["userData"]),
        bearerToken: BearerToken.fromJson(json["bearerToken"]),
      );

  Map<String, dynamic> toJson() => {
        "userData": userData!.toJson(),
        "bearerToken": bearerToken!.toJson(),
      };
}

class BearerToken {
  BearerToken({
    this.type,
    this.token,
  });

  String? type;
  String? token;

  factory BearerToken.fromJson(Map<String, dynamic> json) => BearerToken(
        type: json["type"],
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "token": token,
      };
}

class UserData {
  UserData({
    this.id,
    this.email,
    this.rememberMeToken,
    this.name,
    this.phone,
    this.authToken,
    this.createdAt,
    this.updatedAt,
    this.roleId,
    this.isActive,
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
  int? isActive;

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        id: json["id"],
        email: json["email"],
        rememberMeToken: json["remember_me_token"],
        name: json["name"],
        phone: json["phone"],
        authToken: json["auth_token"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        roleId: json["role_id"],
        isActive: json["is_active"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "remember_me_token": rememberMeToken,
        "name": name,
        "phone": phone,
        "auth_token": authToken,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
        "role_id": roleId,
        "is_active": isActive,
      };
}

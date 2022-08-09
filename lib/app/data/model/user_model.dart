// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({this.data, this.needUpdate, this.message, this.missingPinCode});

  Data? data;
  bool? needUpdate;
  bool? missingPinCode;
  String? message;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        data: Data.fromJson(json["data"]),
        needUpdate: json["needUpdate"],
        message: json["message"],
        missingPinCode: json["missingPinCode"],
      );

  Map<String, dynamic> toJson() => {
        "data": data!.toJson(),
        "needUpdate": needUpdate,
        "message": message,
        "missingPinCode": missingPinCode,
      };

  UserModel copyOf({Data? data, bool? needUpdate, String? message}) =>
      UserModel(
          data: data ?? this.data,
          needUpdate: needUpdate ?? this.needUpdate,
          message: message ?? this.message);
}

class Data {
  Data({
    this.userData,
    this.token,
  });

  UserData? userData;
  Token? token;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        userData: UserData.fromJson(json["userData"] ?? json["user"]),
        token: Token.fromJson(json["token"] ?? json["bearerToken"]),
      );

  Data copyOf({UserData? userData, Token? token}) =>
      Data(userData: userData ?? this.userData, token: token ?? this.token);

  Map<String, dynamic> toJson() => {
        "userData": userData!.toJson(),
        "token": token!.toJson(),
      };
}

class Token {
  Token({
    this.type,
    this.token,
  });

  String? type;
  String? token;

  factory Token.fromJson(Map<String, dynamic> json) => Token(
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
    this.note,
    this.status,
  });

  int? id;
  dynamic email;
  dynamic rememberMeToken;
  dynamic name;
  String? phone;
  String? authToken;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? roleId;
  int? isActive;
  String? status;
  dynamic note;

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
        note: json["note"],
        status: json["status"],
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
        "note": note,
        "status": status,
      };
}

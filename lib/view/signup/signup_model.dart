// To parse this JSON data, do
//
//     final signUpModel = signUpModelFromJson(jsonString);

import 'dart:convert';

SignUpModel signUpModelFromJson(String str) => SignUpModel.fromJson(json.decode(str));


class SignUpModel {
  SignUpModel({
    this.token,
    this.expireDate,
    this.data,
    this.status,
  });

  String? token;
  DateTime? expireDate;
  List<Datum>? data;
  bool? status;

  factory SignUpModel.fromJson(Map<String, dynamic> json) => SignUpModel(
    token: json["token"],
    expireDate: DateTime.parse(json["expire_date"]),
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    status: json["status"],
  );

}

class Datum {
  Datum({
    this.id,
    this.name,
    this.email,
    this.emailVerifiedAt,
    this.phoneNo,
    this.countryid,
    this.avatar,
    this.type,
    this.usertype,
    this.isVerified,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? name;
  String? email;
  dynamic emailVerifiedAt;
  String? phoneNo;
  String? countryid;
  String? avatar;
  String? type;
  String? usertype;
  String? isVerified;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    emailVerifiedAt: json["email_verified_at"],
    phoneNo: json["phone_no"],
    countryid: json["countryid"],
    avatar: json["avatar"],
    type: json["type"],
    usertype: json["usertype"],
    isVerified: json["is_verified"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

}

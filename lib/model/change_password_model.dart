// To parse this JSON data, do
//
//     final changePasswordModel = changePasswordModelFromJson(jsonString);

import 'dart:convert';

ChangePasswordModel changePasswordModelFromJson(String str) => ChangePasswordModel.fromJson(json.decode(str));


class ChangePasswordModel {
  ChangePasswordModel({
    this.status,
    this.message,
    this.data,
  });

  bool? status;
  String? message;
  String? data;

  factory ChangePasswordModel.fromJson(Map<String, dynamic> json) => ChangePasswordModel(
    status: json["status"],
    message: json["message"],
    data: json["data"],
  );

}

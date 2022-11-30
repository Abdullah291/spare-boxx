// To parse this JSON data, do
//
//     final typeModel = typeModelFromJson(jsonString);

import 'dart:convert';

TypeModel typeModelFromJson(String str) => TypeModel.fromJson(json.decode(str));


class TypeModel {
  TypeModel({
    this.status,
    this.message,
    this.types,
  });

  bool? status;
  String? message;
  List<Type>? types;

  factory TypeModel.fromJson(Map<String, dynamic> json) => TypeModel(
    status: json["status"],
    message: json["message"],
    types: List<Type>.from(json["types"].map((x) => Type.fromJson(x))),
  );

}

class Type {
  Type({
    this.id,
    this.type,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? type;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Type.fromJson(Map<String, dynamic> json) => Type(
    id: json["id"],
    type: json["type"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

}

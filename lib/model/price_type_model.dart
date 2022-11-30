// To parse this JSON data, do
//
//     final priceTypeModel = priceTypeModelFromJson(jsonString);

import 'dart:convert';

PriceTypeModel priceTypeModelFromJson(String str) => PriceTypeModel.fromJson(json.decode(str));


class PriceTypeModel {
  PriceTypeModel({
    this.status,
    this.message,
    this.priceTypes,
  });

  bool? status;
  String? message;
  List<PriceType>? priceTypes;

  factory PriceTypeModel.fromJson(Map<String, dynamic> json) => PriceTypeModel(
    status: json["status"],
    message: json["message"],
    priceTypes: List<PriceType>.from(json["price_types"].map((x) => PriceType.fromJson(x))),
  );

}

class PriceType {
  PriceType({
    this.id,
    this.pricetypes,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? pricetypes;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory PriceType.fromJson(Map<String, dynamic> json) => PriceType(
    id: json["id"],
    pricetypes: json["pricetypes"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

}

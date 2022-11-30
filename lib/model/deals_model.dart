// To parse this JSON data, do
//
//     final dealsModel = dealsModelFromJson(jsonString);

import 'dart:convert';

DealsModel dealsModelFromJson(String str) => DealsModel.fromJson(json.decode(str));


class DealsModel {
  DealsModel({
    this.status,
    this.message,
    this.deals,
  });

  bool? status;
  String? message;
  List<Deal>? deals;

  factory DealsModel.fromJson(Map<String, dynamic> json) => DealsModel(
    status: json["status"],
    message: json["message"],
    deals: List<Deal>.from(json["deals"].map((x) => Deal.fromJson(x))),
  );

}

class Deal {
  Deal({
    this.id,
    this.dealoption,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? dealoption;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Deal.fromJson(Map<String, dynamic> json) => Deal(
    id: json["id"],
    dealoption: json["dealoption"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );
}

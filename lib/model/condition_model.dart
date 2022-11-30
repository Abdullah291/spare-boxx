// To parse this JSON data, do
//
//     final conditionModel = conditionModelFromJson(jsonString);

import 'dart:convert';

ConditionModel conditionModelFromJson(String str) => ConditionModel.fromJson(json.decode(str));


class ConditionModel {
  ConditionModel({
    this.status,
    this.message,
    this.itemConditions,
  });

  bool? status;
  String? message;
  List<ItemCondition>? itemConditions;

  factory ConditionModel.fromJson(Map<String, dynamic> json) => ConditionModel(
    status: json["status"],
    message: json["message"],
    itemConditions: List<ItemCondition>.from(json["item_conditions"].map((x) => ItemCondition.fromJson(x))),
  );


}

class ItemCondition {
  ItemCondition({
    this.id,
    this.condition,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? condition;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory ItemCondition.fromJson(Map<String, dynamic> json) => ItemCondition(
    id: json["id"],
    condition: json["Condition"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

}

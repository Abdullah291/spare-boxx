// To parse this JSON data, do
//
//     final followerModel = followerModelFromJson(jsonString);

import 'dart:convert';

FollowerModel followerModelFromJson(String str) => FollowerModel.fromJson(json.decode(str));


class FollowerModel {
  FollowerModel({
    this.status,
    this.message,
    this.data,
    this.totalFollowers,
  });

  bool? status;
  String? message;
  List<Datum>? data;
  int? totalFollowers;

  factory FollowerModel.fromJson(Map<String, dynamic> json) => FollowerModel(
    status: json["status"],
    message: json["message"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    totalFollowers: json["total_followers"],
  );

}

class Datum {
  Datum({
    this.id,
    this.userId,
    this.followerId,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? userId;
  String? followerId;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    userId: json["user_id"],
    followerId: json["follower_id"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

}

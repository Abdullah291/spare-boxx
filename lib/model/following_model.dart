// To parse this JSON data, do
//
//     final followingModel = followingModelFromJson(jsonString);

import 'dart:convert';

FollowingModel followingModelFromJson(String str) => FollowingModel.fromJson(json.decode(str));

class FollowingModel {
  FollowingModel({
    this.status,
    this.message,
    this.data,
    this.totalFollowing,
  });

  bool? status;
  String? message;
  List<Datum>? data;
  int? totalFollowing;

  factory FollowingModel.fromJson(Map<String, dynamic> json) => FollowingModel(
    status: json["status"],
    message: json["message"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    totalFollowing: json["total_following"],
  );

}

class Datum {
  Datum({
    this.id,
    this.userId,
    this.followingId,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? userId;
  String? followingId;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    userId: json["user_id"],
    followingId: json["following_id"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

}

import 'dart:convert';
import 'dart:math';

FavoriteModel favoriteModelFromJson(String str) =>
    FavoriteModel.fromJson(json.decode(str));

class FavoriteModel {
  FavoriteModel({
    this.status,
    this.message,
    this.data,
    this.totalFavorites,
  });

  bool? status;
  String? message;
  List<Datum>? data;
  int? totalFavorites;

  factory FavoriteModel.fromJson(Map<String, dynamic> json) => FavoriteModel(
        status: json["status"],
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        totalFavorites: json["total_favorites"],
      );

  addData({required String userId, required String listingId}) {
    data?.add(Datum(
        id: Random().nextInt(1000000), userId: userId, favoriteId: listingId));
  }


}

class Datum {
  Datum({
    this.id,
    required this.userId,
    required this.favoriteId,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String userId;
  String favoriteId;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        userId: json["user_id"],
        favoriteId: json["favorite_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );
}

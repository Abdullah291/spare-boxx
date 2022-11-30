import 'dart:convert';

BannerModel bannerModelFromJson(String str) => BannerModel.fromJson(json.decode(str));


class BannerModel {
  BannerModel({
    this.status,
    this.message,
    this.bannerads,
  });

  bool? status;
  String? message;
  List<BannerShow>? bannerads;

  factory BannerModel.fromJson(Map<String, dynamic> json) => BannerModel(
    status: json["status"],
    message: json["message"],
    bannerads: List<BannerShow>.from(json["bannerads"].map((x) => BannerShow.fromJson(x))),
  );

}

class BannerShow {
  BannerShow({
    this.id,
    this.image,
    this.expiry,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? image;
  DateTime? expiry;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory BannerShow.fromJson(Map<String, dynamic> json) => BannerShow(
    id: json["id"],
    image: json["image"],
    expiry: DateTime.parse(json["expiry"]),
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );


}


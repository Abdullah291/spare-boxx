// To parse this JSON data, do
//
//     final userListingModel = userListingModelFromJson(jsonString);

import 'dart:convert';

import 'package:sparebboxx/model/listing_model.dart';

UserListingModel userListingModelFromJson(String str) => UserListingModel.fromJson(json.decode(str));


class UserListingModel {
  UserListingModel({
    this.status,
    this.message,
    this.data,
    this.images,
  });

  bool? status;
  String? message;
  List<Listing>? data;
  List<List<String>>? images;

  factory UserListingModel.fromJson(Map<String, dynamic> json) => UserListingModel(
    status: json["status"],
    message: json["message"],
    data: List<Listing>.from(json["data"].map((x) => Listing.fromJson(x))),
    images: List<List<String>>.from(json["images"].map((x) => List<String>.from(x.map((x) => x)))),
  );

}

// class Datum {
//   Datum({
//     this.id,
//     this.listimages,
//     this.title,
//     this.userId,
//     this.categoryId,
//     this.typeId,
//     this.itemId,
//     this.pricetypeId,
//     this.price,
//     this.dealId,
//     this.countryId,
//     this.address,
//     this.whatsappNumber,
//     this.brand,
//     this.description,
//     this.isFeatured,
//     this.isApproved,
//     this.isActive,
//     this.views,
//     this.isShop,
//     this.auction,
//     this.auctionEnd,
//     this.highlight,
//     this.isReported,
//     this.createdAt,
//     this.updatedAt,
//   });
//
//   int? id;
//   String? listimages;
//   String? title;
//   String? userId;
//   String? categoryId;
//   String? typeId;
//   String? itemId;
//   String? pricetypeId;
//   String? price;
//   String? dealId;
//   String? countryId;
//   String? address;
//   String? whatsappNumber;
//   String? brand;
//   String? description;
//   String? isFeatured;
//   String? isApproved;
//   String? isActive;
//   String? views;
//   String? isShop;
//   String? auction;
//   DateTime? auctionEnd;
//   String? highlight;
//   String? isReported;
//   DateTime? createdAt;
//   DateTime? updatedAt;
//
//   factory Datum.fromJson(Map<String, dynamic> json) => Datum(
//     id: json["id"],
//     listimages: json["Listimages"],
//     title: json["title"] ?? "",
//     userId: json["user_id"] ?? "",
//     categoryId: json["category_id"] ?? "",
//     typeId: json["type_id"] ?? "",
//     itemId: json["item_id"] ?? "",
//     pricetypeId: json["pricetype_id"] ?? "",
//     price: json["price"] ?? "",
//     dealId: json["deal_id"] ?? "",
//     countryId: json["country_id"] ?? "",
//     address: json["address"] ?? "",
//     whatsappNumber: json["Whatsapp_number"] ?? "",
//     brand: json["brand"] ?? "",
//     description: json["description"] ?? "",
//     isFeatured: json["is_featured"] ?? "",
//     isApproved: json["is_approved"] ?? "",
//     isActive: json["is_active"] ?? "",
//     views: json["views"] ?? "",
//     isShop: json["is_shop"] ?? "",
//     auction: json["auction"] ?? "",
//     auctionEnd: json["auction_end"] == null ? null : DateTime.parse(json["auction_end"]),
//     highlight: json["highlight"] ?? "",
//     isReported: json["is_reported"] ?? "",
//     createdAt: DateTime.parse(json["created_at"]),
//     updatedAt: DateTime.parse(json["updated_at"]),
//   );
//
// }

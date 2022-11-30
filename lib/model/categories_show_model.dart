import 'dart:convert';
import 'listing_model.dart';

CategoriesShowModel categoriesShowModelFromJson(String str) => CategoriesShowModel.fromJson(json.decode(str));


class CategoriesShowModel {
  CategoriesShowModel({
    this.status,
    this.listings,
  });

  bool? status;
  List<Listing>? listings;

  factory CategoriesShowModel.fromJson(Map<String, dynamic> json) => CategoriesShowModel(
    status: json["status"],
    listings: List<Listing>.from(json["listings"].map((x) => Listing.fromJson(x))),
  );

}


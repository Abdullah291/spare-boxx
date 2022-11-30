import 'dart:convert';
import 'listing_model.dart';

ViewBrandModel viewBrandFromJson(String str) => ViewBrandModel.fromJson(json.decode(str));


class ViewBrandModel {
  ViewBrandModel({
    this.status,
    this.listing,
  });

  bool? status;
  List<Listing>? listing;

  factory ViewBrandModel.fromJson(Map<String, dynamic> json) => ViewBrandModel(
    status: json["status"],
    listing: List<Listing>.from(json["listings"].map((x) => Listing.fromJson(x))),
  );

}


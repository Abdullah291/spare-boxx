import 'dart:convert';
import 'listing_model.dart';

AllListingModel allListingFromJson(String str) => AllListingModel.fromJson(json.decode(str));


class AllListingModel {
  AllListingModel({
    this.status,
    this.listing,
  });

  bool? status;
  List<Listing>? listing;

  factory AllListingModel.fromJson(Map<String, dynamic> json) => AllListingModel(
    status: json["status"],
    listing: List<Listing>.from(json["listings"].map((x) => Listing.fromJson(x))),
  );

}


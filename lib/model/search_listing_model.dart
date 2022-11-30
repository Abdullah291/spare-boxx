
import 'dart:convert';

import 'listing_model.dart';

SearchListingModel searchListingFromJson(String str) => SearchListingModel.fromJson(json.decode(str));


class SearchListingModel {
  SearchListingModel({
    this.status,
    this.listing,
  });

  bool? status;
  List<Listing>? listing;

  factory SearchListingModel.fromJson(Map<String, dynamic> json) => SearchListingModel(
    status: json["status"],
    listing: List<Listing>.from(json["listings"].map((x) => Listing.fromJson(x))),
  );


}


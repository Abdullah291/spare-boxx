class Listing {
  Listing({
    this.id,
    this.listimages,
    this.title,
    this.userId,
    this.categoryId,
    this.typeId,
    this.itemId,
    this.pricetypeId,
    this.price,
    this.dealId,
    this.countryId,
    this.address,
    this.whatsappNumber,
    this.brand,
    this.description,
    this.isFeatured,
    this.isApproved,
    this.isActive,
    this.views,
    this.isShop,
    this.auction,
    this.auctionEnd,
    this.highlight,
    this.isReported,
    this.createdAt,
    this.updatedAt,
    this.name,
    this.email,
    this.emailVerifiedAt,
    this.phoneNo,
    this.countryid,
    this.avatar,
    this.type,
  });

  int? id;
  String? listimages;
  String? title;
  String? userId;
  String? categoryId;
  String? typeId;
  String? itemId;
  String? pricetypeId;
  String? price;
  String? dealId;
  String? countryId;
  String? address;
  String? whatsappNumber;
  String? brand;
  String? description;
  String? isFeatured;
  String? isApproved;
  String? isActive;
  String? views;
  String? isShop;
  String? auction;
  DateTime? auctionEnd;
  String? highlight;
  String? isReported;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? name;
  String? email;
  dynamic emailVerifiedAt;
  String? phoneNo;
  String? countryid;
  String? avatar;
  String? type;

  factory Listing.fromJson(Map<String, dynamic> json) => Listing(
    id: json["id"],
    listimages: json["Listimages"],
    title: json["title"] ?? "",
    userId: json["user_id"] ?? "",
    categoryId: json["category_id"] ?? "",
    typeId: json["type_id"]?? "",
    itemId: json["item_id"] ?? "",
    pricetypeId: json["pricetype_id"] ?? "",
    price: json["price"] ?? "",
    dealId: json["deal_id"] ?? "",
    countryId: json["country_id"] ?? "",
    address: json["address"] ?? "",
    whatsappNumber: json["Whatsapp_number"] ?? "",
    brand: json["brand"] ?? "",
    description: json["description"] ?? "",
    isFeatured: json["is_featured"] ?? "",
    isApproved: json["is_approved"] ?? "",
    isActive: json["is_active"] ?? "",
    views: json["views"] ?? "",
    isShop: json["is_shop"] ?? "",
    auction: json["auction"] ?? "",
    auctionEnd:  json["auction_end"] == null ? null : DateTime.parse(json["auction_end"]),
    highlight: json["highlight"] ?? "",
    isReported: json["is_reported"] ?? "",
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    name: json["name"] ?? "",
    email: json["email"] ?? "",
    emailVerifiedAt: json["email_verified_at"] ?? "",
    phoneNo: json["phone_no"]?? "",
    countryid: json["countryid"] ?? "",
    avatar: json["avatar"] ?? "",
    type: json["type"] ?? "",
  );

}

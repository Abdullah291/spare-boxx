import 'dart:convert';

UserProfileData userProfileDataFromJson(String str) => UserProfileData.fromJson(json.decode(str));

class UserProfileData {
  UserProfileData({
    this.status,
    this.message,
    this.userData,
  });

  bool? status;
  String? message;
  List<UserDatum>? userData;

  factory UserProfileData.fromJson(Map<String, dynamic> json) => UserProfileData(
    status: json["status"],
    message: json["message"],
    userData: List<UserDatum>.from(json["user_data"].map((x) => UserDatum.fromJson(x))),
  );

}

class UserDatum {
  UserDatum({
    this.id,
    this.name,
    this.email,
    this.emailVerifiedAt,
    this.phoneNo,
    this.countryid,
    this.avatar,
    this.type,
    this.isActive,
    this.isReported,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? name;
  String? email;
  dynamic emailVerifiedAt;
  String? phoneNo;
  String? countryid;
  String? avatar;
  String? type;
  String? isActive;
  String? isReported;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory UserDatum.fromJson(Map<String, dynamic> json) => UserDatum(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    emailVerifiedAt: json["email_verified_at"],
    phoneNo: json["phone_no"],
    countryid: json["countryid"],
    avatar: json["avatar"],
    type: json["type"],
    isActive: json["is_active"],
    isReported: json["is_reported"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

}

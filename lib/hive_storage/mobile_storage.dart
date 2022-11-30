import 'package:hive/hive.dart';
part 'mobile_storage.g.dart';


@HiveType(typeId: 1)
class MobileStorage {
  MobileStorage({this.token,this.expireDate,this.id,this.name,this.email,
    this.phoneNo,this.countryId,this.avatar,this.type,this.userType,this.isVerified});
  @HiveField(0)
  String? token;
  @HiveField(1)
  DateTime? expireDate;
  @HiveField(2)
  int? id;
  @HiveField(3)
  String? name;
  @HiveField(4)
  String? email;
  @HiveField(5)
  String? phoneNo;
  @HiveField(6)
  String? countryId;
  @HiveField(7)
  String? avatar;
  @HiveField(8)
  String? type;
  @HiveField(9)
  String? userType;
  @HiveField(10)
  String? isVerified;
}
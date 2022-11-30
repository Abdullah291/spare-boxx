import 'package:get/get.dart';
import 'package:sparebboxx/model/user_listing_model.dart';
import 'package:sparebboxx/service/block_user_service.dart';
import 'package:sparebboxx/service/user_listing_service.dart';
import 'package:sparebboxx/utils/constant.dart';





class UserPostController extends GetxController with StateMixin {


  UserListingService userListingService = UserListingService();
  BlockUserService blockUserService = BlockUserService();
  UserListingModel? userListingModel;


  userPostListingShow({String? userId}) async {
    try {
      userListingModel = await userListingService.userListingService(userId);
      change(userListingModel, status: RxStatus.success());
      update();
    } catch (e) {
      snackBarTop(subtitle: e);
      change(e, status: RxStatus.error());
    }
    update();
  }


  blockUser(int? id) async {
    try {
      await blockUserService.blockUserService(id);
    }
    on Exception catch (e) {
      snackBar(subtitle: e.toString());
    }
    catch (e) {
      snackBar(subtitle: e);
    }
  }


}
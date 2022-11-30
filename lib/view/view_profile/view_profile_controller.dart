import 'package:get/get.dart';
import 'package:sparebboxx/hive_storage/mobile_storage.dart';
import 'package:sparebboxx/main.dart';
import 'package:sparebboxx/model/user_listing_model.dart';
import 'package:sparebboxx/service/user_listing_service.dart';
import 'package:sparebboxx/utils/constant.dart';





class UserListingController extends GetxController with StateMixin{


  UserListingService userListingService = UserListingService();
  UserListingModel? userListingModel;
  MobileStorage? mobileStorage = box?.get("userData");


  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    onStarted();
  }

  onStarted() async{
    await userListingShow();
  }


  userListingShow() async {
    try {
      userListingModel = await userListingService.userListingService(mobileStorage?.id.toString());
      change(userListingModel, status: RxStatus.success());
      update();
    } catch (e) {
      snackBarTop(subtitle: e);
      change(e, status: RxStatus.error());
    }
    update();
  }

}


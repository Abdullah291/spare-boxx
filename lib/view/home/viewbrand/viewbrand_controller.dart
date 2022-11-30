import 'package:get/get.dart';
import 'package:sparebboxx/hive_storage/mobile_storage.dart';
import 'package:sparebboxx/main.dart';
import 'package:sparebboxx/model/viewbrand_model.dart';
import 'package:sparebboxx/service/viewbrand_service.dart';
import 'package:sparebboxx/utils/constant.dart';





class ViewBrandController extends GetxController with StateMixin{

  ViewBrandService viewBrandService = ViewBrandService();
  ViewBrandModel? viewBrandModel;
  MobileStorage? mobileStorage = box?.get("userData");





  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    allListingShow();
  }


  allListingShow() async{
    try {
      viewBrandModel = await viewBrandService.viewBrandService();
      change(viewBrandModel,status: RxStatus.success());
      update();
    } catch(e){
      snackBarTop(subtitle: e);
      change(e,status: RxStatus.error());
    }
    update();
  }

}


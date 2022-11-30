import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sparebboxx/model/search_listing_model.dart';
import 'package:sparebboxx/service/search_listing_service.dart';
import 'package:sparebboxx/utils/constant.dart';

enum Filter{
  allItem,
  newItem,
  usedItem,
}

class SearchController extends GetxController with StateMixin{
  SearchListingService searchListingService = SearchListingService();
  SearchListingModel? searchListingModel;

  TextEditingController searchTitle= TextEditingController();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    change(searchListingModel,status: RxStatus.error());
    update();
  }

  bool loading=false;

  String? itemId;

  searchListingShow(String ids) async{
    if(searchTitle.text.isEmpty){
      return null;
    }
    else{
      try {
        loading=true;
        update();
        searchListingModel = await searchListingService.searchListingService(searchTitle.text.trim(),ids);

        print("this");
        print(searchListingModel?.listing?[0].email);
        if(searchListingModel?.listing?.isEmpty == true){
          change(searchListingModel,status: RxStatus.empty());
          update();
        }
        change(searchListingModel,status: RxStatus.success());
        loading=false;
        update();
      } catch(e){
        loading=false;
        update();
        snackBarTop(subtitle: e);
        change(e,status: RxStatus.error());
      }
      update();
    }
  }


  filterSelect(Filter filter){
    if(filter==Filter.newItem){
      itemId = "1";
      searchListingShow("1");
    }
    else if(filter==Filter.usedItem){
      itemId = "0";
      searchListingShow("0");
    }
    else{
      itemId = null;
      searchListingShow("");
    }
    update();
  }

}


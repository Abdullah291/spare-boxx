import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:sparebboxx/model/categories_model.dart';
import 'package:sparebboxx/model/condition_model.dart';
import 'package:sparebboxx/model/deals_model.dart';
import 'package:sparebboxx/model/get_type_model.dart';
import 'package:sparebboxx/model/listing_model.dart';
import 'package:sparebboxx/model/price_type_model.dart';
import 'package:http/http.dart' as http;
import 'package:sparebboxx/service/add_new_listing_service.dart';
import 'package:sparebboxx/service/block_listing.dart';
import 'package:sparebboxx/service/view_listing_service.dart';
import 'package:sparebboxx/utils/ad_helper.dart';
import 'package:sparebboxx/utils/constant.dart';



class DetailController extends GetxController{

  AddNewListingService addNewListingService =AddNewListingService();
  BlockListingService blockService = BlockListingService();
  ViewListingService viewListingService = ViewListingService();

  CategoriesModel? categoriesModel;
  TypeModel? typeModel;
  ConditionModel? conditionModel;
  PriceTypeModel? priceTypeModel;
  DealsModel? dealsModel;

  String? categoryNames;
  String? typeNames;
  String? dealNames;
  String? priceNames;

  var selectedPageIndex=0.obs;
  var pageController=PageController();

  bool isDetailPageInterstitialLoaded=false;
  late InterstitialAd detailPageInterstitial;



  @override
  void onInit() {
    // TODO: implement onInit
    interstitial();
    getListingApi();
    super.onInit();
  }

  getListingApi() async {
    try {
      List<http.Response> response = await addNewListingService.initialApis();
      categoriesModel = categoriesModelFromJson(response[0].body);
      typeModel = typeModelFromJson(response[1].body);
      conditionModel = conditionModelFromJson(response[2].body);
      priceTypeModel = priceTypeModelFromJson(response[3].body);
      dealsModel = dealsModelFromJson(response[4].body);
    } on Exception catch (e) {
      print(e);
    } catch (e) {
      print(e);
    }

    update();
  }



  details(Listing? am){
    categoriesFun(am?.categoryId);
    typeFun(am?.typeId);
    dealFun(am?.dealId);
    priceFun(am?.pricetypeId);
  }



  categoriesFun(categoryId){
    int? id=int.parse(categoryId);
    int? length=categoriesModel?.categories?.length ?? 0;
    for(int i=0;i<length;i++){
      if(categoriesModel?.categories?[i].id == id){
        categoryNames=categoriesModel?.categories?[i].name;
      }
    }
    update();
  }

  typeFun(typeId){
    int id=int.parse(typeId);
    int? length=typeModel?.types?.length ?? 0;
    for(int i=0;i<length;i++){
      if(typeModel?.types?[i].id == id){
        typeNames=typeModel?.types?[i].type;
      }
    }
    update();
  }

  dealFun(dealId){
    int id=int.parse(dealId);
    int? length=dealsModel?.deals?.length ?? 0;
    for(int i=0;i<length;i++){
      if(dealsModel?.deals?[i].id == id){
        dealNames=dealsModel?.deals?[i].dealoption;
      }
    }
    update();
  }

  priceFun(priceTypeId){
    int id=int.parse(priceTypeId);
    int? length=priceTypeModel?.priceTypes?.length ?? 0;
    for(int i=0;i<length;i++){
      if(priceTypeModel?.priceTypes?[i].id == id){
        priceNames=priceTypeModel?.priceTypes?[i].pricetypes;
      }
    }
    update();
  }

  Future<void> interstitial() async{
    await InterstitialAd.load(
      adUnitId: AdHelper.detailPageInterstitial(),
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (ad){
            print("HomePage Interstitial Loaded");
            detailPageInterstitial= ad;
            isDetailPageInterstitialLoaded=true;
          },
          onAdFailedToLoad: (error){
            print(error.toString());
            isDetailPageInterstitialLoaded=false;
          }
      ),
    );
    update();
  }


  blockListings(int? id) async{
    try {
      await blockService.blockListingService(id);
    }
    on Exception catch (e) {
      snackBar(subtitle: e.toString());
    }
    catch (e) {
      snackBar(subtitle: e);
    }
  }

  viewListings(int? id) async{
    try {
      await viewListingService.viewListingService(id);
      print("Ok");
    }
    on Exception catch (e) {
      print(e);
    }
    catch (e) {
      print(e);
    }
    update();
  }

}
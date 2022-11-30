import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:sparebboxx/model/categories_show_model.dart';
import 'package:sparebboxx/model/country_model.dart';
import 'package:sparebboxx/service/categories_show_service.dart';
import 'package:sparebboxx/service/country_service.dart';
import 'package:sparebboxx/utils/ad_helper.dart';





class CategoriesShowController extends GetxController with StateMixin {


  CategoriesShowService categoriesShowService = CategoriesShowService();
  CategoriesShowModel? categoriesShowModel;

  CountryService countryService = CountryService();
  CountryModel? countryModel;
  int length = 0;

  bool isCategoriesBannerLoaded=false;
  late BannerAd categoriesBanner;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    banner2();
    onStarted();
  }

  onStarted() async {
    await countryAll();
  }


  categoriesShowListing(int? id) async {
    try {
      categoriesShowModel =
      await categoriesShowService.categoriesShowListingService(id.toString());
      if (categoriesShowModel?.listings?.isEmpty ==true) {
        change(null, status: RxStatus.empty());
        update();
      }
      change(categoriesShowModel, status: RxStatus.success());
      update();
    } catch (e) {
      change(e, status: RxStatus.error());
    }
    update();
  }


  countryAll() async {
    try {
      countryModel = await countryService.countryService();
      length = countryModel?.data?.length ?? 0;
    } catch (e) {
      print(e);
    }
    update();
  }


  Future<void> banner2() async{

    categoriesBanner = BannerAd(
      adUnitId: AdHelper.banner2UnitId(),
      size: AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(
          onAdLoaded: (ad){
            print("HomePage Banner Loaded");
            isCategoriesBannerLoaded=true;
          },
          onAdClosed: (ad){
            ad.dispose();
            isCategoriesBannerLoaded=false;
          },
          onAdFailedToLoad: (ad,error){
            print(error.toString());
            isCategoriesBannerLoaded=false;
          }
      ),
    );
    await categoriesBanner.load();
    update();
  }


}


import 'package:get/get.dart';
import 'package:sparebboxx/hive_storage/mobile_storage.dart';
import 'package:sparebboxx/main.dart';
import 'package:sparebboxx/model/all_listing_model.dart';
import 'package:sparebboxx/model/banner_model.dart';
import 'package:sparebboxx/model/categories_model.dart';
import 'package:sparebboxx/model/condition_model.dart';
import 'package:sparebboxx/model/country_model.dart';
import 'package:sparebboxx/model/favourite_model.dart';
import 'package:sparebboxx/model/follower_model.dart';
import 'package:sparebboxx/model/following_model.dart';
import 'package:sparebboxx/model/listing_model.dart';
import 'package:sparebboxx/service/all_listing_service.dart';
import 'package:sparebboxx/service/banner_service.dart';
import 'package:sparebboxx/service/categories_service.dart';
import 'package:sparebboxx/service/condition_service.dart';
import 'package:sparebboxx/service/country_service.dart';
import 'package:sparebboxx/service/favorite_post_service.dart';
import 'package:sparebboxx/service/favourite_service.dart';
import 'package:sparebboxx/service/follower_service.dart';
import 'package:sparebboxx/service/following_service.dart';
import 'package:sparebboxx/utils/ad_helper.dart';
import 'package:sparebboxx/utils/constant.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class HomeController extends GetxController with StateMixin {
  AllListingService allListingService = AllListingService();
  CountryService countryService = CountryService();
  BannerService bannerService = BannerService();
  CategoriesService categoriesService = CategoriesService();
  ConditionService conditionService = ConditionService();
  FollowerService followerService = FollowerService();
  FollowingService followingService = FollowingService();
  FavouriteService favouriteService = FavouriteService();


  FavoritePostService favoritePostService = FavoritePostService();

  AllListingModel? allListingModel;
  CountryModel? countryModel;
  BannerModel? bannerModel;
  CategoriesModel? categoriesModel;
  ConditionModel? conditionModel;
  FollowerModel? followerModel;
  FollowingModel? followingModel;
  FavoriteModel? favouriteModel;
  bool? favoritePostModel;

  MobileStorage? mobileStorage = box?.get("userData");

  int length = 0;

  int auctionLength = 0;
  int featuredLength = 0;
  int popularLength = 0;

  bool isHomePageBannerLoaded = false;
  late BannerAd homePageBanner;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    onStarted();
  }

  onStarted() async {
    banner2();
    bannerShow();
    await countryAll();
    categoriesShow();
    conditionShow();
    favoritePostGet();
    followerShow(mobileStorage?.id.toString());
    followingShow(mobileStorage?.id.toString());
    await allListingShow();
  }

  conditionShow() async {
    try {
      conditionModel = await conditionService.conditionService();
    } catch (e) {
      print("Condition new and use error");
    }
    update();
  }

  Future<void> banner2() async {
    homePageBanner = BannerAd(
      adUnitId: AdHelper.banner1UnitId(),
      size: AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(onAdLoaded: (ad) {
        print("HomePage Banner Loaded");
        isHomePageBannerLoaded = true;
      }, onAdClosed: (ad) {
        ad.dispose();
        isHomePageBannerLoaded = false;
      }, onAdFailedToLoad: (ad, error) {
        print(error.toString());
        isHomePageBannerLoaded = false;
      }),
    );
    await homePageBanner.load();
    update();
  }

  bannerShow() async {
    try {
      bannerModel = await bannerService.bannerService();
      if (bannerModel?.bannerads?.isEmpty == true) {
        change(null, status: RxStatus.empty());
        update();
      }
      change(bannerModel, status: RxStatus.success());
      update();
    } catch (e) {
      change(e, status: RxStatus.error());
    }
    update();
  }

  categoriesShow() async {
    try {
      categoriesModel = await categoriesService.categoriesService();
      if (categoriesModel?.categories?.isEmpty == true) {
        change(null, status: RxStatus.empty());
        update();
      }
      change(categoriesModel, status: RxStatus.success());
      update();
    } catch (e) {
      change(e, status: RxStatus.error());
    }
    update();
  }

  allListingShow() async {
    try {
      allListingModel = await allListingService.allListingService();
      await checkAuction();
      await checkFeatured();
      await checkPopular();
      change(allListingModel, status: RxStatus.success());
      update();
    } catch (e) {
      snackBarTop(subtitle: e);
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

  checkAuction() {
    int? length = allListingModel?.listing?.length ?? 0;

    for (int i = 0; i < length; i++) {
      Listing? am = allListingModel?.listing?[i];
      if (am?.auction == "1") {
        auctionLength++;
      }
    }
    update();
  }

  checkFeatured() {
    int? length = allListingModel?.listing?.length ?? 0;
    for (int i = 0; i < length; i++) {
      Listing? am = allListingModel?.listing?[i];
      if (am?.isFeatured == "1") {
        featuredLength++;
      }
    }
    update();
  }

  checkPopular() {
    int? length = allListingModel?.listing?.length ?? 0;
    for (int i = 0; i < length; i++) {
      popularLength++;
    }
    update();
  }

  //Favorite Post

  favoritePostSend(int? id) async {
    try {
      favoritePostModel = await favoritePostService.favoritePostService(id);
      favoritePostGet();
    } catch (e) {
      print(e);
    }
    update();
  }

 // get favorite post


  favoritePostGet() async {
    MobileStorage? mobileStorage = box?.get("userData");
    try {
      favouriteModel = await favouriteService.favouriteService(mobileStorage?.id.toString());
    } catch (e) {
      print(e);
    }
    update();
  }


 bool checkFavorite(int? id,{bool? fav}) {
    // if(fav==false){
    //     favouriteModel?.data?.removeWhere((element) => element.favoriteId == id.toString());
    //     print("dine");
    //     update();
    //     return false;
    // }
    if (favouriteModel?.data != null) {
      int? length = favouriteModel?.data?.length ?? 0;
      for (int i = 0; i < length; i++) {
        if (favouriteModel?.data?[i].favoriteId == id.toString()) {
           return true;
        }
      }
    }
    return false;
  }

  //Followers

  followerShow(String? id) async {
    try {
      followerModel = await followerService.followerService(id);
    } catch (e) {
      print(e);
    }
    update();
  }

  //Following

  followingShow(String? id) async {
    try {
      followingModel = await followingService.followingService(id);
    } catch (e) {
      print(e);
    }
    update();
  }
}

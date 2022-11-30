import 'package:internet_connection_checker/internet_connection_checker.dart';

const Duration timeout = Duration(seconds: 20);
const String loginApi = 'https://spareboxx.com/api/login';
const String signUpApi = 'https://spareboxx.com/api/register';
const String forgotPasswordApi = 'http://client.imagesmaster.com/api/pass';
const String editProfileApi = 'https://spareboxx.com/api/profile';
const String createApi = 'https://spareboxx.com/api/createlist';
const String countryApi = 'https://spareboxx.com/api/allcountries';
const String categoriesApi = 'https://spareboxx.com/api/categories';
const String getTypesApi = 'https://spareboxx.com/api/gettypes';
const String conditionApi = 'https://spareboxx.com/api/conditions';
const String priceTypeApi = 'https://spareboxx.com/api/pricetypes';
const String dealApi = 'https://spareboxx.com/api/deals';
const String bannerApi = 'http://client.imagesmaster.com/api/bannerads/';
const String allListingApi =
    'http://client.imagesmaster.com/api/alllisting/?country_id=';
const String getUserDataApi = 'https://spareboxx.com/api/userlistdata/';
const String followerApi = 'http://client.imagesmaster.com/api/getfollower/';
const String followingApi = 'http://client.imagesmaster.com/api/getfollowing/';
const String favoriteApi = 'http://client.imagesmaster.com/api/getfavorite/';
const String favoritePostApi = 'http://client.imagesmaster.com/api/favorite';
const String userListing = 'http://client.imagesmaster.com/api/useridlist/';
const String changePasswordApi = 'https://spareboxx.com/api/updatepass';
const String blockListingApi = 'https://spareboxx.com/api/blocklist/';
const String blockUserApi = 'https://spareboxx.com/api/blockuser/';
const String viewBrandApi = 'https://spareboxx.com/api/alllisting/?is_shop=1';
const String viewListing = 'http://client.imagesmaster.com/api/getlisting/';

const String imageStorageLink =
    "http://client.imagesmaster.com/public/storage/listingimages/";
const String imageStorageLink2 =
    "http://client.imagesmaster.com/public/storage/images/";

wifiConnectionChecked() async {
  bool _connection = await InternetConnectionChecker().hasConnection;

  if (!_connection) {
    return Future.error('No internet');
  }
}

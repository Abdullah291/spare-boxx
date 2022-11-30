import 'dart:async';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:sparebboxx/hive_storage/mobile_storage.dart';
import 'package:sparebboxx/main.dart';
import 'package:sparebboxx/model/search_listing_model.dart';
import 'api_services.dart';





class SearchListingService {
  MobileStorage? mobileStorage = box?.get("userData");

  searchListingService(String title,String ids) async {
    try {
      await wifiConnectionChecked();
      http.Response response = await http.get(Uri.parse("$allListingApi?item_id=$ids&title=$title&country_id=${mobileStorage?.countryId}")).timeout(timeout);

      print("TIme to play");
      if(response.statusCode == 200){
        print("ddd");
        print(response.body);
        return searchListingFromJson(response.body);
      }else{
        print(response.statusCode);
        return Future.error("Oops, Something went wrong. Please try again later");
      }

    } on SocketException catch (_) {
      throw 'No Internet Connection';
    } on TimeoutException catch (_) {
      throw "Something went wrong please try again";
    } catch (e) {
      print(e);
      throw "Something went wrong please try again later";
    }
  }

}







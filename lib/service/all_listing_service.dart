import 'dart:async';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:sparebboxx/hive_storage/mobile_storage.dart';
import 'package:sparebboxx/main.dart';
import 'package:sparebboxx/model/all_listing_model.dart';
import 'api_services.dart';





class AllListingService {

  MobileStorage? mobileStorage = box?.get("userData");


  allListingService() async {
    try {
      await wifiConnectionChecked();
      http.Response response = await http.get(Uri.parse("$allListingApi${mobileStorage?.countryId??""}")).timeout(timeout);

      if(response.statusCode == 200){
        print(response.body);
        return allListingFromJson(response.body);
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







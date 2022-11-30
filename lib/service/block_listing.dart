import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:sparebboxx/hive_storage/mobile_storage.dart';
import 'package:sparebboxx/main.dart';
import 'package:sparebboxx/utils/constant.dart';
import 'api_services.dart';





class BlockListingService {

  MobileStorage? mobileStorage = box?.get("userData");

  blockListingService(int? id) async {
    try {
      http.Response response = await http.get(Uri.parse("$blockListingApi$id"),
      headers: {
        "Content-Type":"application/json",
        "Accept":"application/json",
        "Authorization":"bearer ${mobileStorage?.token}",
      },
      ).timeout(timeout);

      var decodeResponse = jsonDecode(response.body);
      var message = decodeResponse["message"];
      if(response.statusCode == 200){
         snackBarSuccessfully(subtitle: "Listing block Successfully");
         return ;
      }
      else if(response.statusCode == 403){
       return Future.error(message);
      }
      else{
        return Future.error("Oops, Something went wrong. Please try again later");
      }

    } on SocketException catch (_) {
      throw 'No Internet Connection';
    } on TimeoutException catch (_) {
      throw "Something went wrong please try again";
    } catch (e) {
      throw "Something went wrong please try again later";
    }
  }

}







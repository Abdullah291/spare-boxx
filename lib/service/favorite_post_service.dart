import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:sparebboxx/hive_storage/mobile_storage.dart';
import 'package:sparebboxx/main.dart';
import 'api_services.dart';





class FavoritePostService{

  MobileStorage? mobileStorage = box?.get("userData");


  Future favoritePostService(int? listingId) async {
    try {
      Map<String, String> header = {
        "Authorization": "Bearer ${mobileStorage?.token ?? ""}",
        "Content-Type": "application/json",
        "Accept": "application/json",
      };
      Map<String, String> userData = {
        "listing_id": "$listingId",
        "user_id": "${mobileStorage?.id}",
      };

      http.MultipartRequest request = http.MultipartRequest("POST", Uri.parse(favoritePostApi));
      request.headers.addAll(header);
      request.fields.addAll(userData);
      http.StreamedResponse response = await request.send();
      Uint8List responseData = await response.stream.toBytes();
      String result = String.fromCharCodes(responseData);
      var decodeResponse = jsonDecode(result);
      var status = decodeResponse["status"];
      var message = decodeResponse["message"];

      if(response.statusCode == 200){
        if(status==true){
          return status;
        }else{
         return status;
        }
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







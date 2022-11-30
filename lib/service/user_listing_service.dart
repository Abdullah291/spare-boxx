import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:sparebboxx/model/user_listing_model.dart';
import 'api_services.dart';





class UserListingService {

  userListingService(String? id) async {
    try {
      await wifiConnectionChecked();
      http.Response response = await http.get(Uri.parse("$userListing$id")).timeout(timeout);

      if(response.statusCode == 200){
        var decodeResponse = jsonDecode(response.body);
        var status = decodeResponse["status"];
        if (status == true) {
          return userListingModelFromJson(response.body);
        } else {
          return Future.error("No Data");
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







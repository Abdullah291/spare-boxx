import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:sparebboxx/model/follower_model.dart';
import 'api_services.dart';





class FollowerService {

  followerService(String? id) async {
    try {
      http.Response response = await http.get(Uri.parse("$followerApi${id??""}")).timeout(timeout);
      if(response.statusCode == 200){
        var decodeResponse = jsonDecode(response.body);
        var status = decodeResponse["status"];
        if (status == true) {
          return followerModelFromJson(response.body);
        } else {
          return Future.error("Follower Not Found");
        }
      }else{
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







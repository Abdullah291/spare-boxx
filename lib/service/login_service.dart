import 'package:http/http.dart' as http;
import 'package:sparebboxx/hive_storage/mobile_storage.dart';
import 'package:sparebboxx/view/login/login_model.dart';
import 'api_services.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io';

class LoginService {
  MobileStorage data = MobileStorage();
  Future loginServiceData(
      {required String email, required String password}) async {
    try {
      Map<String, String> userData = {
        "email": email,
        "password": password,
        "type": "0",
      };

      http.Response response = await http.post(
        Uri.parse(loginApi),
        body: jsonEncode(userData),
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.acceptHeader: "application/json",
        },
      ).timeout(timeout);


      if(response.statusCode == 200){
        var decodeResponse = jsonDecode(response.body);
        var status = decodeResponse["status"];
        if (status == true) {
          return loginModelFromJson(response.body);
        } else {
          return Future.error("Invalid Email and/or Password");
        }
      }else{
        print(response.statusCode);
        return Future.error(
            "Something went wrong. Please try again later");
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

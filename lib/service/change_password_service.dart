import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:sparebboxx/hive_storage/mobile_storage.dart';
import 'package:sparebboxx/main.dart';
import 'package:sparebboxx/model/change_password_model.dart';
import 'api_services.dart';





class ChangePasswordService{

  MobileStorage? mobileStorage = box?.get("userData");


 Future changePasswordService({
    required String oldPassword,
    required String password,
    required String passwordConfirmation,
  }) async {
    try {

      Map<String, String> header = {
        "Authorization": "Bearer ${mobileStorage?.token ?? ""}",
        "Content-Type": "application/json",
        "Accept": "application/json",
      };




      Map<String, String> userData = {
        "email": mobileStorage?.email ?? "",
        "old_password": oldPassword,
        "password": password,
        "password_confirmation": passwordConfirmation,
      };


      // Map<String,String> header={
      //   "Authorization": token.toString(),
      // };

      // var response =await client.post(Uri.parse("http://yard-app.com/yarddeveloper/api/login")
      //     ,body: userData,headers: header);

      http.MultipartRequest request = http.MultipartRequest("POST", Uri.parse(changePasswordApi));
      request.headers.addAll(header);
      request.fields.addAll(userData);
      http.StreamedResponse response = await request.send();
      Uint8List responseData = await response.stream.toBytes();
      String result = String.fromCharCodes(responseData);
      if(response.statusCode == 201){
        print(result);
        return changePasswordModelFromJson(result);
      }else if(response.statusCode == 403){
       return  Future.error("Old password isn't correct");
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







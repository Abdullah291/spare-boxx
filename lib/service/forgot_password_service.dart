import 'dart:typed_data';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:sparebboxx/utils/constant.dart';
import 'api_services.dart';
import 'dart:async';
import 'dart:io';


class ForgotPasswordService{
  Future forgotPasswordService({required String email}) async {
    try{
      Map<String, String> header = {
        "Content-Type": "application/json",
        "Accept": "application/json",
      };

      Map<String, String> userData = {
        "email": email,
      };

      http.MultipartRequest request = http.MultipartRequest("POST", Uri.parse(forgotPasswordApi));
      request.headers.addAll(header);
      request.fields.addAll(userData);
      http.StreamedResponse response = await request.send();
      Uint8List responseData = await response.stream.toBytes();
      String result = String.fromCharCodes(responseData);
      if(response.statusCode == 200){
        return Get.snackbar("Successfully","Password reset mail has been sent to ");
      }
      else if(response.statusCode == 404){
        return snackBar(subtitle: "Email not found.");
      }
      else if(response.statusCode != 200) {
        return Future.error("Oops, Something went wrong. Please try again later");
      }

    }on SocketException catch (_) {
      throw 'No Internet Connection';
    }on TimeoutException catch (_) {
      throw "Something went wrong please try again";
    } catch (e) {
      throw "Something went wrong please try again later";
    }
  }

}
import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:sparebboxx/hive_storage/mobile_storage.dart';
import 'package:sparebboxx/main.dart';
import 'package:sparebboxx/view/edit_profile/edit_profile_model.dart';
import 'api_services.dart';





class EditProfileService {


  MobileStorage? mobileStorage= box?.get("userData");


  editProfileServiceData({
    required String name,
    required String phone,
    File? avatar,
    required String countryId,
   }) async {
    try {
      Map<String,String> userData={
        "name": name,
        "phone_no": phone,
        "countryid": countryId,
      };

      http.MultipartRequest request = http.MultipartRequest("POST", Uri.parse(editProfileApi));
      request.headers['Accept'] = 'application/json';
      request.headers['Authorization'] = 'bearer  ${mobileStorage?.token}';
      request.fields.addAll(userData);


      if(avatar != null) {
        http.MultipartFile multipartFile = await http.MultipartFile.fromPath(
            'avatar', avatar.path);
        request.files.add(multipartFile);
      }

      http.StreamedResponse response= await request.send();

      Uint8List responseData = await response.stream.toBytes();

      String result =  String.fromCharCodes(responseData);


      if(response.statusCode == 200){
        print(result);
        return editProfileModelFromJson(result);
      } else{
        print(response.statusCode);
        return Future.error("Something went wrong. Please try again later");
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






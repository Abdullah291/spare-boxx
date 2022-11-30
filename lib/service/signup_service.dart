import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:sparebboxx/view/signup/signup_model.dart';
import 'api_services.dart';





class SignUpService {

  signUpServiceData({
     required String name,
    required String phone,
    required  String email,
    required String password,
    required String confirmPassword,
    required String countryId,
    required String type,
    required File? avatar}) async {
    try {

      Map<String,String> userData={
        "name": name,
        "email":email,
        "phone_no": phone,
        "password": password,
        "password_confirmation": confirmPassword,
        "countryid": countryId,
        "type": type,
      };

      http.MultipartRequest request = http.MultipartRequest("POST", Uri.parse(signUpApi));
      request.headers['Accept'] = 'application/json';
      request.fields.addAll(userData);
      http.MultipartFile multipartFile = await http.MultipartFile.fromPath(
          'avatar', avatar!.path);

      request.files.add(multipartFile);
      http.StreamedResponse response= await request.send();
      Uint8List responseData = await response.stream.toBytes();
      String result =  String.fromCharCodes(responseData);

      if(response.statusCode == 200){
        print("Every thing ok");
        return signUpModelFromJson(result);
      }
      else if(response.statusCode == 422){
       return Future.error("The email has already been taken");
      }
      else if(response.statusCode != 200){
        print(response.statusCode);
       return Future.error("Oops, Something went wrong. Please try again later");
      }
    } on TimeoutException catch (_) {
      throw "Something went wrong please try again";
    } on SocketException catch (_) {
      throw 'No Internet Connection';
    } catch (e) {
      throw "Something went wrong please try again later";
    }

  }

}




// Future featuredData(String token) async {
//   try {
//     bool _connection = await InternetConnectionChecker().hasConnection;
//
//     if (!_connection) {
//       return Future.error('No internet');
//     }
//
//
//
//
//     http.Response response = await http.get(Uri.parse("$featuredListingApi"), headers: {
//       HttpHeaders.contentTypeHeader: "application/json",
//       'Authorization': 'Bearer '+ token,
//     },).timeout(timeout);
//
//
//     if (response.statusCode == 201 || response.statusCode == 200) {
//       return featuredModelFromJson(response.body);
//     }
//     else{
//       return Future.error("Oops, Something went wrong. Please try again later");
//     }
//
//
//
//
//
//   } on SocketException catch (_) {
//     throw const SocketException('No Internet Connection');
//   } on TimeoutException catch (_) {
//     throw TimeoutException('Request Timed Out');
//   } catch (e) {
//     print(e);
//     throw Exception(e.toString());
//   }
// }






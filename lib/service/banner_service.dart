import 'dart:async';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:sparebboxx/model/banner_model.dart';
import 'api_services.dart';





class BannerService {

  bannerService() async {
    try {
      await wifiConnectionChecked();
      http.Response response = await http.get(Uri.parse(bannerApi)).timeout(timeout);



      if(response.statusCode == 200){
        return bannerModelFromJson(response.body);
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







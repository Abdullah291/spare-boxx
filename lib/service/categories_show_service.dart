import 'dart:async';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:sparebboxx/model/categories_show_model.dart';
import 'api_services.dart';





class CategoriesShowService{

  categoriesShowListingService(String id) async {
    try {
      http.Response response = await http.get(Uri.parse("$allListingApi?category_id=$id")).timeout(timeout);
      if(response.statusCode == 200){
        print(response.body);
        return categoriesShowModelFromJson(response.body);
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







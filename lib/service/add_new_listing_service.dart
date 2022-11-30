import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:sparebboxx/hive_storage/mobile_storage.dart';
import 'package:sparebboxx/main.dart';
import 'api_services.dart';


class AddNewListingService{

  MobileStorage? mobileStorage= box?.get("userData");


  addNewListingService({
    required String title,
    required String type_id,
    required String category_id,
    required String item_id,
    required String pricetype_id,
    required String price,
    required String deal_id,
    required String country_id,
    required String address,
    required String Whatsapp_number,
    required String brand,
    required String description,
    required String is_shop,
    required String auction,
    String? auction_end,
    required String highlight,
    required String is_featured,
    required List<File> imageList,
  })  async{


    try {
      Map<String, String> userData = {
        "title": title,
        "type_id": type_id,
        "category_id": category_id,
        "item_id": item_id,
        "pricetype_id": pricetype_id,
        "price": price,
        "deal_id": deal_id,
        "country_id": country_id,
        "address": address,
        "Whatsapp_number": Whatsapp_number,
        "brand": brand,
        "description": description,
        "is_shop": is_shop,
        "auction": auction,
        "auction_end": auction_end!,
        "highlight": highlight,
        "is_featured": is_featured,
      };


      http.MultipartRequest request = http.MultipartRequest(
          "POST", Uri.parse(createApi));
      request.headers['Accept'] = 'application/json';
      request.headers['Authorization'] = 'bearer ${mobileStorage?.token}';
      List<http.MultipartFile> multipleImages = <http.MultipartFile>[];
      for (int i = 0; i < imageList.length; i++) {
        http.MultipartFile multipartFile = await http.MultipartFile.fromPath(
            'multipics[]', imageList[i].path);
        multipleImages.add(multipartFile);
      }

      request.files.addAll(multipleImages);
      request.fields.addAll(userData);


      http.StreamedResponse response = await request.send();

      Uint8List responseData = await response.stream.toBytes();

      String result = String.fromCharCodes(responseData);

      if (response.statusCode == 200) {
        print("Every thing is ok");
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

  Future<List<http.Response>> initialApis() async{
    try {
        bool _connection = await InternetConnectionChecker().hasConnection;

        if (!_connection) {
          return Future.error('No internet');
        }
      List<http.Response> results= await Future.wait([
        http.get(Uri.parse(categoriesApi)),
        http.get(Uri.parse(getTypesApi)),
        http.get(Uri.parse(conditionApi)),
        http.get(Uri.parse(priceTypeApi)),
        http.get(Uri.parse(dealApi)),
        http.get(Uri.parse(countryApi)),
      ]).timeout(const Duration(seconds: 30));
        return results;
    } on SocketException catch (_) {
      throw 'No Internet Connection';
    } on TimeoutException catch (_) {
      throw "Something went wrong please try again";
    } catch (e) {
      throw "Something went wrong please try again later";
    }
  }

}
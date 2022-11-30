import 'dart:async';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'api_services.dart';





class ViewListingService {

  viewListingService(int? id) async {
    try {
      http.Response response = await http.get(Uri.parse("$viewListing$id")).timeout(timeout);

      if(response.statusCode == 200){
        print("Done");
         return ;
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







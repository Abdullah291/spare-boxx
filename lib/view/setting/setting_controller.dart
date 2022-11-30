import 'package:get/get.dart';



class SettingController extends GetxController {

   bool notification = false;
   bool promotion = false;
   bool emailNotification = false;
   bool darkMode = false;


   String? dropDownValue;


   dropDownChanged(value){
      dropDownValue= value;
      update();
   }

   notificationChanged(bool value){
      notification= value;
      update();
   }
   promotionChanged(bool value){
      promotion= value;
      update();
   }
   emailNotificationChanged(bool value){
      emailNotification= value;
      update();
   }
   darkModeChanged(bool value){
      darkMode= value;
      update();
   }

}

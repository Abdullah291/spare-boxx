import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sparebboxx/hive_storage/mobile_storage.dart';
import 'package:sparebboxx/main.dart';
import 'package:sparebboxx/service/login_service.dart';
import 'package:sparebboxx/utils/constant.dart';
import 'package:sparebboxx/view/bottom_navigation_bar/bottom_nav_bar_screen.dart';
import 'package:sparebboxx/view/login/login_model.dart';



class LoginController extends GetxController{

  TextEditingController email= TextEditingController();
  TextEditingController password= TextEditingController();

  LoginService loginService = LoginService();

  LoginModel? loginModel;

  final GlobalKey<FormState> authenticate=GlobalKey<FormState>();

  bool loading=false;



 Future login(context) async {
   if (authenticate.currentState!.validate()) {
     print("cool");
     try {
       loading=true;
       update();
       loginModel = await loginService.loginServiceData(
           email: email.text.trim(),
           password: password.text.trim());

       if(loginModel?.status == true){
         await box?.put("userData",
           MobileStorage(
             token: loginModel?.token,
             expireDate: loginModel?.expireDate,
             id: loginModel?.data?[0].id,
             name: loginModel?.data?[0].name,
             email: loginModel?.data?[0].email,
             phoneNo: loginModel?.data?[0].phoneNo,
             countryId: loginModel?.data?[0].countryid,
             avatar: loginModel?.data?[0].avatar,
             type: loginModel?.data?[0].type,
             userType: loginModel?.data?[0].usertype,
             isVerified: loginModel?.data?[0].isVerified,
           ),
         );
         MobileStorage mobileStorage= box?.get("userData");
         print(mobileStorage.token);
         loading=false;
         update();
       }
       Get.offAll(const BottomNavBarScreen());
     } catch(e){
       loading=false;
       update();
       snackBarTop(subtitle: e.toString());
     }
   }
 }
}
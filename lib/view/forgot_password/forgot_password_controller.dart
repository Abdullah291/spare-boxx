import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sparebboxx/service/forgot_password_service.dart';
import 'package:sparebboxx/utils/constant.dart';

class ForgotPasswordController extends GetxController{

  TextEditingController email= TextEditingController();
  bool loading=false;
  forgotPassword(BuildContext context) async{
    ForgotPasswordService forgotPasswordService= ForgotPasswordService();
    try{
      loading=true;
      update();
      print(email.text.trim());
      await forgotPasswordService.forgotPasswordService(email: email.text.trim());
      loading=false;
      update();
    } catch (e) {
      loading=false;
      update();
      snackBarTop(subtitle: e);
    }

  }

}


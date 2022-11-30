import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sparebboxx/hive_storage/mobile_storage.dart';
import 'package:sparebboxx/main.dart';
import 'package:sparebboxx/service/signup_service.dart';
import 'package:sparebboxx/utils/constant.dart';
import 'package:sparebboxx/view/bottom_navigation_bar/bottom_nav_bar_screen.dart';
import 'package:sparebboxx/view/signup/signup_model.dart';

import 'signup_2/signup_2_screen.dart';




class SignUpController extends GetxController{

  SignUpService signUpService = SignUpService();

  SignUpModel? signUpModel;

  TextEditingController yourName= TextEditingController();
  TextEditingController phoneNumber= TextEditingController();
  TextEditingController email= TextEditingController();
  TextEditingController password= TextEditingController();
  TextEditingController confirmPassword= TextEditingController();
  File? image;
  XFile? pickedFile;

  final GlobalKey<FormState> register=GlobalKey<FormState>();
  bool loading=false;

  String?  selectedCountry;


  signUp1(){
    if (register.currentState!.validate()) {
      if (password.text == confirmPassword.text) {
         if(selectedCountry != null) {
           Get.to(() => SignUp2Screen());
         }
         else{
           snackBar(subtitle: "Please Select Country");
         }
       }
    }
  }

  changedCountry(val){
    selectedCountry=val;
    update();
  }


  signUp2(context) async{

    if(image == null){
      return snackBarTop(subtitle:"Select your picture first");
    }

    try {
      loading=true;
      update();
      signUpModel = await signUpService.signUpServiceData(
        name: yourName.text.trim().toString(),
        phone: phoneNumber.text.trim().toString(),
        email: email.text.trim().toString(),
        password: password.text.trim().toString(),
        confirmPassword: confirmPassword.text.trim().toString(),
        countryId: selectedCountry ?? "1",
        type: "0",
        avatar: image,);

      if (signUpModel?.token != null) {
        await box?.put("userData",
          MobileStorage(
            token: signUpModel?.token,
            expireDate: signUpModel?.expireDate,
            id: signUpModel?.data?[0].id,
            name: signUpModel?.data?[0].name,
            email: signUpModel?.data?[0].email,
            phoneNo: signUpModel?.data?[0].phoneNo,
            countryId: signUpModel?.data?[0].countryid,
            avatar: signUpModel?.data?[0].avatar,
            type: signUpModel?.data?[0].type,
            userType: signUpModel?.data?[0].usertype,
            isVerified: signUpModel?.data?[0].isVerified,
          ),
        );
        MobileStorage mobileStorage = box?.get("userData");
        print(mobileStorage.token);
      }
      loading=false;
      update();
      Get.offAll(const BottomNavBarScreen());
    } catch(e){
      loading=false;
      update();
      snackBarTop(subtitle: e.toString());
    }

  }



  chooseImage() async {
     pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
     image = File(pickedFile!.path);
    if (pickedFile!.path == null) {
     await retrieveLost();
    }
    update();
  }

  Future<void> retrieveLost() async {
    final response = await ImagePicker().retrieveLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
        image= File(response.file!.path);
    } else {
      print(response.file);
    }
  }


}


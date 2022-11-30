import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sparebboxx/hive_storage/mobile_storage.dart';
import 'package:sparebboxx/main.dart';
import 'package:sparebboxx/model/country_model.dart';
import 'package:sparebboxx/service/country_service.dart';
import 'package:sparebboxx/service/edit_profile_service.dart';
import 'package:sparebboxx/utils/constant.dart';
import 'package:sparebboxx/view/edit_profile/edit_profile_model.dart';
// import 'dart:io';
import 'dart:io';


class EditProfileController extends GetxController {


  TextEditingController name= TextEditingController();
  TextEditingController phoneNumber= TextEditingController();
  File? image;
  XFile? pickedFile;

  MobileStorage? mobileStorage = box?.get("userData");

  EditProfileService editProfileService= EditProfileService();
  CountryService countryService = CountryService();
  EditProfileModel? editProfileModel;
  CountryModel? countryModel;


  String? countryName;


  @override
  void onInit() {
    name.text = mobileStorage!.name!;
    phoneNumber.text = mobileStorage!.phoneNo!;
    countryName = mobileStorage?.countryId;
    update();
    super.onInit();
  }


  editProfile() async{
    try{
       editProfileModel = await editProfileService.editProfileServiceData(
        name: name.text,
        phone: phoneNumber.text,
        avatar: image,
        countryId: countryName!,);

      await box?.put("userData", MobileStorage(
    token: mobileStorage?.token,
    expireDate: mobileStorage?.expireDate,
    id: mobileStorage?.id,
    name: editProfileModel?.data?.name,
    email: mobileStorage?.email,
    phoneNo: editProfileModel?.data?.phone,
    countryId: editProfileModel?.data?.country,
    avatar: editProfileModel?.data?.avatar,
    type: mobileStorage?.type,
    userType: mobileStorage?.userType,
    isVerified: mobileStorage?.isVerified,
    ),).whenComplete(() {
      update();
      Get.snackbar("Successfully", "Profile Update Successfully");
      });


    }catch(e){
      snackBarTop(subtitle: e);
    }
  }



  changedCountryName(val){
    print(val);
    countryName=val;
    print("this is $countryName");
    update();
  }

  countryAll() async {
    try {
      countryModel = await countryService.countryService();
      update();
    } catch (e) {
      print(e);
    }
  }


  chooseImage() async {
    pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    image = File(pickedFile!.path);
    if (pickedFile?.path == null) {
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

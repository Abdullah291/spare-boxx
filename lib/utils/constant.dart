import 'package:flutter/material.dart';
import 'package:get/get.dart';


const String instagramLink= "https://instagram.com/spareboxx?igshid=YmMyMTA2M2Y=";
const String facebookLink= "https://www.facebook.com/profile.php?id=100079153083847";


const String adminEmail = "jabir919@gmail.com";
const String adminName  = "";
const String adminImage = "jabi";



const Color kPrimary = Color(0xffFCC415);
const Color kSecondary = Color(0xffFFEBF0);
const Color kTertiary = Color(0xffF4F3FD);
const Color kOffWhite = Color(0xffFCFCFC);
const Color kAccent1 = Color(0xffF7658B);
const Color kAccent2 = Color(0xffACEDFB);
const Color white = Color(0xffFFFFFF);
const Color black = Color(0xff000000);
const Color kTextLight =  Color(0xff1F126B);
const Color kText2Light = Color(0xff78789D);
const Color kText3Light = Color(0xff1F1F39);
const Color kText4Light = Color(0xff382E1E);
const Color kButtonGrey = Color(0xffE5E5E5);
const Color kButtonGrey2 =Color(0xffF4F3FD);

UnderlineInputBorder fib = const UnderlineInputBorder(
  borderSide: BorderSide(
    color: kPrimary,
  ),
);

UnderlineInputBorder eib = const UnderlineInputBorder(
  borderSide: BorderSide(
    color: Colors.black,
  ),
);

RoundedRectangleBorder tileRadius = const RoundedRectangleBorder(
    borderRadius: BorderRadius.only(
        topRight: Radius.circular(20),
        bottomLeft: Radius.circular(20),
        bottomRight: Radius.circular(20)));

BorderRadius boxDecoration = const BorderRadius.only(
  topLeft: Radius.circular(2),
  topRight: Radius.circular(100),
  bottomLeft: Radius.circular(100),
  bottomRight: Radius.circular(100),
);

const BorderRadius borderRadius = BorderRadius.only(
  topLeft: Radius.circular(2),
  topRight: Radius.circular(100),
  bottomLeft: Radius.circular(100),
  bottomRight: Radius.circular(100),
);



snackBar({subtitle}){
  return Get.snackbar("Error", subtitle,
      backgroundColor: Colors.red.withOpacity(0.5),
      snackPosition: SnackPosition.BOTTOM,
      colorText: Colors.white,
      margin: const EdgeInsets.symmetric(vertical: 10));
}

snackBarTop({subtitle}){
  return Get.snackbar("Error", subtitle,
      backgroundColor: Colors.red.withOpacity(0.5),
      colorText: Colors.white,
      margin: const EdgeInsets.symmetric(vertical: 10));
}

snackBarSuccessfully({subtitle}){
  return Get.snackbar("Successfully", subtitle,
      backgroundColor: Colors.green.withOpacity(0.5),
      colorText: Colors.white,
      margin: const EdgeInsets.symmetric(vertical: 10));
}




//Privacy policy



const String privacyPolicy=
    "Privacy Policy "
    "Last updated: December 31, 2021"
    "This Privacy Policy describes Our policies and procedures on the collection, use and disclosure of Your information when You use the Service and tells You about Your privacy rights and how the law protects You."
    "We use Your Personal data to provide and improve the Service. By using the Service, You agree to the collection and use of information in accordance with this Privacy Policy. This Privacy Policy has been created with the help of the Privacy Policy Template.";




final ButtonStyle outlinedBorderStyle= OutlinedButton.styleFrom(
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(100)
    )
);
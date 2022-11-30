import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'constant.dart';

class MyTheme {
  static ThemeData lightTheme(BuildContext context) => ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
        secondaryHeaderColor: white,
        scaffoldBackgroundColor: white,
        primaryColor: kPrimary,
        appBarTheme: const AppBarTheme(
          backgroundColor: white,
          iconTheme: IconThemeData(
            color: white,
          )
        ),
        canvasColor: kTextLight,
        textTheme: MyTheme.textThemeLight,

      cardTheme: CardTheme(
            elevation: 4,
            margin: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10))),

        elevatedButtonTheme: elevatedButtons(context), colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.red).copyWith(secondary: Colors.white),


  );

  static ThemeData darkTheme(BuildContext context) => ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
        primaryColor: kPrimary,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.black,
            canvasColor: white,
        cardColor: const Color(0xff28282B),
        textTheme: MyTheme.textThemeDark,
        appBarTheme: const AppBarTheme(
          centerTitle: false,
          color: Colors.transparent,
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),


        bottomAppBarColor: const Color(0xff28282B),
        elevatedButtonTheme: elevatedButtons(context),
        cardTheme: CardTheme(
            color: const Color(0xff28282B),
            elevation: 4,
            margin: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10))),
      );

  static ElevatedButtonThemeData elevatedButtons(BuildContext context) =>
      ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
        primary: kPrimary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        textStyle: GoogleFonts.poppins(
            fontSize: 14, fontWeight: FontWeight.w400, color: kTextLight
        ),
        fixedSize: Size(Get.width*0.7, 50.h),
      ));

  static TextTheme textThemeLight = TextTheme(
    headline1: GoogleFonts.poppins(fontSize: 22.sp, fontWeight: FontWeight.w600, color: kTextLight),
    headline2: GoogleFonts.poppins(fontSize: 16.sp, color: kText2Light, ),
    headline3: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600,color: kText3Light),
    headline4: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w400, color: kTextLight),
    headline5: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w600,color: kTextLight),
    headline6: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w600, color: white),
    subtitle1: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w400, color: kText3Light,),
    subtitle2: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w400, color: kText2Light),
    bodyText1: GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.w700, color: kText4Light),
    bodyText2: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w400, color: black),
    caption: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.w600, color: black),
    button: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600, color: kTextLight),
  );

  static TextTheme textThemeDark = TextTheme(
    headline1: GoogleFonts.poppins(fontSize: 22.sp, fontWeight: FontWeight.w600, color: white),
    headline2: GoogleFonts.poppins(fontSize: 16.sp, color: kText2Light, ),
    headline3: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600,color: white),
    headline4: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w400, color: white),
    headline5: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w600,color: white),
    headline6: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w600, color: white),
    subtitle1: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w400, color: white,),
    subtitle2: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w400, color: kText2Light),
    bodyText1: GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.w700, color: white),
    bodyText2: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w400, color: white),
    caption: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.w600, color: white),
    button: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600, color: black),
  );
}

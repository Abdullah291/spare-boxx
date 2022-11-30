import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sparebboxx/utils/constant.dart';
import 'package:sparebboxx/utils/assets.dart';
import 'package:velocity_x/velocity_x.dart';




AppBar appBarWidget({String? title ,context}){
  return AppBar(
    elevation: 0,
    leading: GestureDetector(
      onTap: (){
        Get.back();
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(backIcon,width: 30,color: kPrimary,),
        ],
      ),
    ),
    title: title.toString().text.headline6(context).color(Theme.of(context).canvasColor).make(),
    centerTitle: true,
  );
}

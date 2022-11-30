import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sparebboxx/utils/constant.dart';
import 'package:sparebboxx/utils/theme_mode.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:intl/intl.dart';


Widget sendChatBubble(int index, String text,int type,DateTime time) {
  DateFormat dateFormat = DateFormat("HH:mm:a");
  String newTime = dateFormat.format(time);
  return Column(
    crossAxisAlignment: CrossAxisAlignment.end,
    children: [
       type==2 ?
        SizedBox(
            height: Get.height*0.5,
            width: Get.width*0.5,
            child: buildImage(text))
         :text.text.size(14).color(ThemeService().theme == ThemeMode.dark
             ? white
             : Colors.black,).make(),
      newTime.text.align(TextAlign.right)
          .color(ThemeService().theme == ThemeMode.dark
          ? white
          : Colors.black,).size(10).make().pOnly(top: 5,right: 10),
    ],
  ).box.withConstraints(
      BoxConstraints(maxWidth: Get.width *0.7, minWidth: 1)).
      customRounded(const BorderRadius.only(
    bottomLeft: Radius.circular(30),
    bottomRight: Radius.circular(30),
    topLeft: Radius.circular(30),
  ))
      .padding(const EdgeInsets.only(left: 14,right: 14,bottom: 8,top: 18))
      .color(Colors.grey.withOpacity(0.1)).make().marginOnly(bottom: 15);
}



Widget buildImage(imageUrl){
  return CachedNetworkImage(
    imageUrl: imageUrl,
    fit: BoxFit.fill,
    placeholder: (context, url) => SizedBox(
      width: Get.width*0.7,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          CircularProgressIndicator(),
        ],
      ),
    ),
    errorWidget: (context, url, error) => const Icon(Icons.error,size: 45,),
  );
}
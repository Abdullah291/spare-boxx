import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sparebboxx/utils/constant.dart';
import 'package:sparebboxx/utils/theme_mode.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:intl/intl.dart';

Widget receivedChatBubble( int index,String text, String sender, DateTime time) {

  DateFormat dateFormat = DateFormat("HH:mm:a");
  String newTime = dateFormat.format(time);

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      text.text.size(14).color(ThemeService().theme == ThemeMode.dark
          ? white : Colors.black,).make(),
      newTime.text.align(TextAlign.left).size(10)
          .color(ThemeService().theme == ThemeMode.dark
          ? white : Colors.black,).make().pOnly(top: 5,left: 10),
    ],
  ).box.
  rightRounded(value: 50).withConstraints(
      BoxConstraints(maxWidth: Get.width *0.7, minWidth: 1)).
  customRounded(const BorderRadius.only(
    bottomLeft: Radius.circular(30),
    bottomRight: Radius.circular(30),
    topRight: Radius.circular(30),
  ))
      .padding(const EdgeInsets.only(left: 14,right: 14,bottom: 8,top: 18))
      .color(ThemeService().theme == ThemeMode.dark
      ? kTertiary.withOpacity(0.2)
      : kTertiary)
      .make();
}
import 'package:flutter/material.dart';
import 'package:get/get.dart';



class Scrolling extends StatelessWidget {

  Widget? widget;
  Scrolling({this.widget});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: Get.width,
        padding: const EdgeInsets.symmetric(horizontal: 15,),
        child: SingleChildScrollView(
          child: widget,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:sparebboxx/utils/constant.dart';
import 'package:velocity_x/velocity_x.dart';


class DecoratedBoxWidget extends StatelessWidget {

   Widget? widget;

   DecoratedBoxWidget({this.widget});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: widget,
    ).box.border(color: kTertiary,width: 2).
    margin(const EdgeInsets.symmetric(horizontal: 10,vertical: 10)).
    padding(const EdgeInsets.symmetric(horizontal: 10,vertical: 25))
        .roundedLg.make();
  }
}

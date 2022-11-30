

import 'package:flutter/material.dart';
import 'package:sparebboxx/utils/constant.dart';
import 'package:velocity_x/velocity_x.dart';


class MessageCounterBox extends StatelessWidget {

   final String? number;
   const MessageCounterBox({this.number});

  @override
  Widget build(BuildContext context) {
    return  Container(
        height: 30,
        width: 30,
        decoration: const BoxDecoration(
        color: kPrimary,
        borderRadius: borderRadius,
    ),
    child: number.toString()
        .text
        .headline6(context)
        .size(12)
        .make()
    .centered()
    );
  }
}

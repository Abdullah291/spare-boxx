

import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class TimerWidget extends StatelessWidget {
   const TimerWidget({Key? key,this.title,this.subtitle}) : super(key: key);

   final int? title;
   final String? subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        "${title ?? "0"}".text.bodyText2(context).size(18).white.make(),
        "$subtitle".text.make(),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';



class NumberBox extends StatelessWidget {
 final String? number;
 final Color? color;
 final Color?  borderColor;
 const NumberBox({this.number,this.color,this.borderColor});
  @override
  Widget build(BuildContext context) {
    return  number!.text.buttonText(context).make().box.
      padding(const EdgeInsets.symmetric(vertical: 5,horizontal: 20))
        .border(color: borderColor!,width: 2).color(color!).roundedSM.make();
  }
}

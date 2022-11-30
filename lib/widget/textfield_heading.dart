import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';



class TextFieldHeading extends StatelessWidget {
  final String? title;
  const TextFieldHeading({Key? key, this.title}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.centerLeft,
        child: title!.text.headline3(context).make());
  }
}

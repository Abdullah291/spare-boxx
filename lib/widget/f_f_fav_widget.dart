import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class FFF extends StatelessWidget {
  final String? title;
  final String? subtitle;
  const FFF({this.title,this.subtitle});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        title.toString().text.headline1(context).make(),
        subtitle.toString().text.headline4(context).make(),
      ],
    );
  }
}

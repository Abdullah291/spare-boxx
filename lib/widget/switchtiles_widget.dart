import 'package:flutter/material.dart';
import 'package:sparebboxx/utils/constant.dart';
import 'package:velocity_x/velocity_x.dart';

class SwitchTiles extends StatelessWidget {

  final bool? value;
  final ValueChanged? onChanged;
  final String? title;

  const SwitchTiles({this.value,this.onChanged,this.title});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Switch(
        value: value!,
        inactiveThumbColor: kText2Light,
        inactiveTrackColor: kText2Light.withOpacity(0.2),
        activeTrackColor: kText2Light.withOpacity(0.2),
        activeColor: kPrimary,
        onChanged: onChanged!,
      ),
      title: title!.toString().text.headline4(context).make(),
    );
  }
}

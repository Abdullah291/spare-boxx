import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sparebboxx/utils/constant.dart';
import 'package:velocity_x/velocity_x.dart';

class Header1 extends StatelessWidget {
  final String? title;
  final String? subtitle;
  const Header1({Key? key, this.title, this.subtitle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 40),
        SvgPicture.asset(
          "assets/svg/spacebox_yellow.svg",
          color: kPrimary,
          width: 100,
          height: 100,
        ),
        title!.text.headline1(context).make(),
        subtitle!.text
            .subtitle2(context)
            .align(TextAlign.center)
            .make()
            .pSymmetric(v: 12),
      ],
    );
  }
}

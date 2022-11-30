import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:sparebboxx/utils/constant.dart';
import 'package:sparebboxx/view/support/support_controller.dart';
import 'package:velocity_x/velocity_x.dart';

class ExpandedTileWIdget extends StatelessWidget {

  final Article? article;

  const ExpandedTileWIdget({this.article});

  @override
  Widget build(BuildContext context) {
    return ExpandablePanel(
      theme: const ExpandableThemeData(
        iconColor: kPrimary,
      ),
      header :article!.title.toString().text.headline3(context).size(14).make(),
      collapsed: const SizedBox.shrink(),
      expanded: article!.body.toString().text.headline4(context).make(),
    ).box.border(color: kTertiary,width: 2).
    margin(const EdgeInsets.symmetric(vertical: 10)).
    padding(const EdgeInsets.symmetric(horizontal: 10,vertical: 10))
        .rounded.make();
  }
}
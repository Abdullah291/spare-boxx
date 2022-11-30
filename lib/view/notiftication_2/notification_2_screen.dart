import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sparebboxx/utils/constant.dart';
import 'package:sparebboxx/view/notifitcaition_1/notification_1_controller.dart';
import 'package:sparebboxx/widget/appbar_widget.dart';
import 'package:sparebboxx/widget/scrolling_widget.dart';
import 'package:velocity_x/velocity_x.dart';



class Notification2Screen extends StatelessWidget {

  final NotificationModel? nm;

   const Notification2Screen({this.nm});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(title:"Notification",context: context),
      body: Scrolling(
        widget: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
                borderRadius: boxDecoration,
                child: Image.asset(nm!.image.toString(),width: Get.width,height: 200,fit: BoxFit.fill,)).marginOnly(top: 25),

            nm.toString().text.headline1(context).make().marginSymmetric(vertical: 25),

            nm!.subtitle.toString().text.subtitle2(context).size(12).make().marginOnly(bottom: 15),

            "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
             "Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.".text.bodyText2(context).make()


          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sparebboxx/utils/constant.dart';
import 'package:sparebboxx/utils/theme_mode.dart';
import 'package:sparebboxx/view/notifitcaition_1/notification_1_controller.dart';
import 'package:sparebboxx/view/notiftication_2/notification_2_screen.dart';
import 'package:sparebboxx/widget/appbar_widget.dart';
import 'package:velocity_x/velocity_x.dart';

class Notification1Screen extends StatelessWidget {
  Notification1Screen({Key? key}) : super(key: key);

  NotificationController controller = Get.find<NotificationController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(title: "Notification", context: context),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        itemCount: controller.list.length,
        itemBuilder: (context, index) {
          NotificationModel nm = controller.list[index];
          return ListTile(
            onTap: () {
              Get.to(Notification2Screen(
                nm: nm,
              ));
            },
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            shape: tileRadius,
            tileColor: ThemeService().theme == ThemeMode.dark
                ? kTertiary.withOpacity(0.2)
                : kTertiary,
            leading: Image.asset(nm.image.toString()),
            title: nm.title.toString().text.headline3(context).make(),
            subtitle:
                nm.subtitle.toString().text.subtitle2(context).size(12).make(),
          ).marginOnly(top: 20);
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sparebboxx/utils/theme_mode.dart';
import 'package:sparebboxx/view/setting/setting_controller.dart';
import 'package:sparebboxx/widget/appbar_widget.dart';
import 'package:sparebboxx/widget/switchtiles_widget.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  SettingController controller = Get.find<SettingController>();
  ThemeService t= ThemeService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(title: "Setting", context: context),
      body: GetBuilder<SettingController>(
          init: SettingController(),
          builder: (controller) {
            return Column(
              children: [
                // TextFieldHeading(
                //   title: "Language",
                // ).pOnly(top: 20, bottom: 10,left: 15),
                // DropdownButton(
                //   dropdownColor: Theme.of(context).scaffoldBackgroundColor,
                //     hint: controller.dropDownValue == null
                //         ? 'Dropdown'.text.headline4(context).make()
                //         : controller.dropDownValue.toString().text.headline4(context).make(),
                //     isExpanded: true,
                //     iconSize: 35.0,
                //     icon: Icon(Icons.keyboard_arrow_down_sharp,color: kPrimary,),
                //     style: TextStyle(color: Colors.blue),
                //     items: ['English', 'Urdu', 'Hindi'].map(
                //       (val) {
                //         return DropdownMenuItem<String>(
                //           value: val,
                //           child: val.text.headline4(context).make(),
                //         );
                //       },
                //     ).toList(),
                //     onChanged: (val) {
                //       controller.dropDownChanged(val);
                //     }).pSymmetric(h: 15),
                // TextFieldHeading(
                //   title: "Notification",
                // ).pOnly(top: 20, bottom: 10,left: 15),
                // SwitchTiles(
                //   title: "Notifications",
                //   value: controller.notification,
                //   onChanged: (value) {
                //     controller.notificationChanged(value);
                //   },
                // ),
                // SwitchTiles(
                //   title: "Promotion",
                //   value: controller.promotion,
                //   onChanged: (value) {
                //     controller.promotionChanged(value);
                //   },
                // ),
                // SwitchTiles(
                //   title: "Email Notification",
                //   value: controller.emailNotification,
                //   onChanged: (value) {
                //     controller.emailNotificationChanged(value);
                //   },
                // ),

                SwitchTiles(
                  title: "Dark Mode",
                  value: t.loadThemeFromBox(),
                  onChanged: (value) {
                    setState(() {
                      t.switchTheme();
                    });
                  },
                ),
              ],
            );
          }),
      // bottomNavigationBar: Column(
      //   children: [
      //     ElevatedButton(
      //       onPressed: () {},
      //       child: "Save".text.make(),
      //     ),
      //   ],
      // )
      //     .box
      //     .color(Theme.of(context).scaffoldBackgroundColor)
      //     .topRounded(value: 10)
      //     .height(50)
      //     .make()
      //     .pSymmetric(v: 5),
    );
  }
}

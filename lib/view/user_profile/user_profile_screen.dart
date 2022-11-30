import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sparebboxx/hive_storage/mobile_storage.dart';
import 'package:sparebboxx/main.dart';
import 'package:sparebboxx/service/api_services.dart';
import 'package:sparebboxx/utils/constant.dart';
import 'package:sparebboxx/utils/assets.dart';
import 'package:sparebboxx/view/change_password/change_password_screen.dart';
import 'package:sparebboxx/view/edit_profile/edit_profile_screen.dart';
import 'package:sparebboxx/view/home/home_controller.dart';
import 'package:sparebboxx/view/login/login_screen.dart';
import 'package:sparebboxx/view/setting/setting_screen.dart';
import 'package:sparebboxx/view/support/support_screen.dart';
import 'package:sparebboxx/view/user_profile/pdf_api.dart';
import 'package:sparebboxx/view/user_profile/pdf_viewer_screen.dart';
import 'package:sparebboxx/view/view_profile/view_profile_screen.dart';
import 'package:sparebboxx/widget/f_f_fav_widget.dart';
import 'package:sparebboxx/widget/network_image_widget.dart';
import 'package:sparebboxx/widget/userprofile_listtile.dart';
import 'package:velocity_x/velocity_x.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({Key? key}) : super(key: key);

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  HomeController homeController = Get.find<HomeController>();

  MobileStorage? mobileStorage = box?.get("userData");



  void openPDF(BuildContext context, File file) => Navigator.of(context).push(
    MaterialPageRoute(builder: (context) => PDFViewerPage(file: file)),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimary,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ""
                .text
                .headline6(context)
                .size(16)
                .align(TextAlign.center)
                .make()
                .pSymmetric(v: 55),
            Column(
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    SizedBox(
                      width: Get.width,
                    ),
                    Positioned(
                      top: -50,
                      left: 0,
                      right: 0,
                      child: Container(
                        margin: const EdgeInsets.only(left: 15),
                        height: 120,
                        width: 120,
                        child: ClipRRect(
                          borderRadius: borderRadius,
                          child: NetworkProfileImageWidget(
                            imageUrl: '$imageStorageLink${mobileStorage
                                ?.avatar}',
                          ),
                        ),
                      ).centered(),
                    ),
                  ],
                ),
                "${mobileStorage?.name}"
                    .text
                    .headline1(context)
                    .align(TextAlign.center)
                    .make()
                    .marginOnly(top: 70),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    "${mobileStorage?.email}".text.headline4(context).make(),
                    const SizedBox(width: 5,),
                    if(mobileStorage?.isVerified != null)...{
                      const Icon(Icons.verified_rounded, color: Colors.blue,
                        size: 22,),
                    },
                  ],
                ),
                GetBuilder<HomeController>(
                    builder: (logic) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      FFF(
                        title: homeController.followerModel?.totalFollowers.toString() ?? "0",
                        subtitle: "Followers",
                      ),
                      FFF(
                        title: homeController.followerModel?.totalFollowers.toString() ?? "0",
                        subtitle: "Following",
                      ),
                    ],
                  );
                }).marginOnly(top: 15, bottom: 15),
                UserProfileListTile(
                  leading: personIcon,
                  title: "User Posts",
                  onTap: () {
                    Get.to(ViewProfileScreen());
                  },
                ),
                UserProfileListTile(
                  leading: "",
                  title: "Edit Profile",
                  onTap: () {
                    Get.to(const EditProfileScreen());
                  },
                ),
                UserProfileListTile(
                  leading: supportIcon,
                  title: "Support",
                  onTap: () {
                    Get.to(SupportScreen());
                  },
                ),
                UserProfileListTile(
                  leading: keyIcon,
                  title: "Change Password",
                  onTap: () {
                    Get.to(ChangePasswordScreen());
                  },
                ),
                UserProfileListTile(
                  leading: policyIcon,
                  title: "Policy",
                  onTap: () async{
                    const path = 'assets/pdf/privacy_policy.pdf';
                    final file = await PDFApi.loadAsset(path);
                    openPDF(context, file);
                  },
                ),
                UserProfileListTile(
                  leading: settingIcon,
                  title: "Setting",
                  onTap: () {
                    Get.to(const SettingScreen());
                  },
                ),
                UserProfileListTile(
                  leading: logoutIcon,
                  title: "Log out",
                  onTap: () async {
                    box?.clear();
                    Get.offAll(LoginScreen());
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            )
                .box
                .topRounded(value: 30)
                .padding(const EdgeInsets.symmetric(horizontal: 15))
                .color(Theme
                .of(context)
                .scaffoldBackgroundColor)
                .make(),
          ],
        ),
      ),
    );
  }
}

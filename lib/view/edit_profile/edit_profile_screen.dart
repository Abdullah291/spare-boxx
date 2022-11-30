import 'package:flutter_svg/flutter_svg.dart';
import 'package:sparebboxx/hive_storage/mobile_storage.dart';
import 'package:sparebboxx/main.dart';
import 'package:sparebboxx/utils/constant.dart';
import 'package:sparebboxx/utils/assets.dart';
import 'package:sparebboxx/view/edit_profile/edit_profile_controller.dart';
import 'package:sparebboxx/widget/network_image_widget.dart';
import 'package:sparebboxx/widget/textfield_heading.dart';
import 'package:sparebboxx/widget/textfield_widget.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sparebboxx/service/api_services.dart';


class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {

  EditProfileController controller = Get.find<EditProfileController>();

  MobileStorage? mobileStorage = box?.get("userData");


  @override
  void initState() {
    // TODO: implement initState
    controller.countryAll();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimary,
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(backIcon, width: 30,),
            ],
          ),
        ),
        title: "Your profile".text.headline6(context).make(),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                controller.chooseImage();
              },
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  SizedBox(width: Get.width,),
                  Positioned(
                    bottom: -65,
                    left: 0,
                    right: 0,
                    child: Container(
                      margin: const EdgeInsets.only(left: 15),
                      height: 140,
                      width: 140,
                      child: ClipRRect(
                        borderRadius: borderRadius,
                        child: GetBuilder<EditProfileController>(
                          builder: (logic) {
                            return Stack(
                              clipBehavior: Clip.none,
                              children: [
                                controller.image == null
                                    ? NetworkProfileImageWidget(
                                  imageUrl: '$imageStorageLink${mobileStorage
                                      ?.avatar}'
                                  ,).h(140).w(140)
                                    : Image.file(controller.image!,fit: BoxFit.cover,).h(140).w(
                                    140),
                                Positioned(
                                  bottom: 0,
                                  child: const Icon(
                                    Icons.camera_alt_rounded, color: white,
                                    size: 28,).box
                                      .width(140)
                                      .p8
                                      .make(),
                                )
                              ],
                            );
                          },
                        ),
                      ),
                    ).centered(),
                  ),
                ],
              ),
            ).box.bottomRounded(value: 40).color(kPrimary).height(120).make(),


            Column(
              children: [
                const TextFieldHeading(title: "Your name",),
                TextFieldWidget(
                  controller: controller.name,
                  prefixIcon: personIcon, hintText: "Enter your Name",),
                const TextFieldHeading(title: "Phone number",),
                TextFieldWidget(
                  controller: controller.phoneNumber,
                  prefixIcon: phoneIcon, hintText: "Enter your Phone Number",
                ),
                const TextFieldHeading(title: "Email",),
                TextFieldWidget(
                  readonly: true,
                  prefixIcon: emailIcon, hintText: "Enter your Email",
                  controller: TextEditingController(text: mobileStorage?.email),
                ),
                const TextFieldHeading(title: "Country",),

              ],
            ).paddingSymmetric(horizontal: 15).marginOnly(top: 100),


            GetBuilder<EditProfileController>(
                init: EditProfileController(),
                builder: (controller) {
                  return DropdownButton(
                    dropdownColor: Theme
                        .of(context)
                        .scaffoldBackgroundColor,
                    itemHeight: 60,
                    hint: (controller.countryName ?? 'Select Country')
                        .text
                        .headline4(context)
                        .make(),
                    isExpanded: true,
                    iconSize: 30.0,
                    style: Theme
                        .of(context)
                        .textTheme
                        .headline4,
                    items: controller.countryModel?.data?.map(
                          (val) {
                        return DropdownMenuItem<String>(
                          value: val.id.toString(),
                          child: val.name
                              .toString()
                              .text
                              .headline4(context)
                              .make(),
                        );
                      },
                    ).toList(),
                    value: controller.countryName,
                    onChanged: (val) {
                      controller.changedCountryName(val);
                    },
                  ).h(65);
                }).marginSymmetric(horizontal: 15).paddingOnly(top: 2),


          ],
        ),
      ),
      bottomNavigationBar: Column(
        children: [
          ElevatedButton(
            onPressed: () async {
              await controller.editProfile();
            },
            child: "Save".text.make(),
          ),
        ],
      ).box.color(Theme
          .of(context)
          .scaffoldBackgroundColor).topRounded(value: 10).height(50)
          .make()
          .paddingSymmetric(vertical: 5),
    );
  }
}

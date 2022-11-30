import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:sparebboxx/hive_storage/mobile_storage.dart';
import 'package:sparebboxx/utils/constant.dart';
import 'package:sparebboxx/utils/dynamic_linking.dart';
import 'package:sparebboxx/view/home/home_controller.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:sparebboxx/main.dart';

class ShareAndFavouriteWidget extends StatelessWidget {

  HomeController homeController = Get.find<HomeController>();

  ShareAndFavouriteWidget(
      {Key? key, this.favouriteTap, this.shareImage, this.shareTitle, this.listingId})
      : super(key: key);

  final VoidCallback? favouriteTap;
  final String? shareTitle;
  final String? shareImage;
  final int? listingId;

  MobileStorage? mobileStorage = box?.get("userData");


  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
        builder: (logic) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          mobileStorage?.token == null ? const SizedBox.shrink():  IconButton(
            onPressed: favouriteTap,
            icon: Icon(
              Icons
                  .favorite_outlined,
              color: homeController.checkFavorite(listingId) == true ? Colors
                  .red : white,
            )
                .box
                .p4
                .withRounded(
                value: 10)
                .color(kPrimary)
                .make(),
          ),
          IconButton(
           onPressed: () {
              DynamicLinkService.createFirstPostLink(
                  shareTitle ?? "", "$shareImage");
            },
            icon: FaIcon(FontAwesomeIcons.share,
              color: white,)
                .box
                .p4
                .withRounded(
                value: 10)
                .color(kPrimary)
                .make(),
          ),
        ],
      );
    });
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sparebboxx/hive_storage/mobile_storage.dart';
import 'package:sparebboxx/main.dart';
import 'package:sparebboxx/model/listing_model.dart';
import 'package:sparebboxx/service/api_services.dart';
import 'package:sparebboxx/utils/assets.dart';
import 'package:sparebboxx/utils/constant.dart';
import 'package:sparebboxx/view/detail/detail_controller.dart';
import 'package:sparebboxx/view/detail/detail_screen.dart';
import 'package:sparebboxx/view/home/home_controller.dart';
import 'package:sparebboxx/view/view_profile/view_profile_controller.dart';
import 'package:sparebboxx/widget/network_image_widget.dart';
import 'package:sparebboxx/widget/share_favourite_widget.dart';
import 'package:sparebboxx/widget/textfield_heading.dart';
import 'package:velocity_x/velocity_x.dart';


class ViewProfileScreen extends StatelessWidget {
  UserListingController userListingController = Get.find<UserListingController>();
  DetailController detailController = Get.find<DetailController>();
  HomeController homeController = Get.find<HomeController>();
  MobileStorage? mobileStorage = box?.get("userData");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimary,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  iconSize: 45,
                  icon: SvgPicture.asset(
                    backIcon,
                    width: 30,
                    color: Colors.white,
                  ),
                ),
              ],
            ).marginOnly(top: 20,),
            "Your Posts"
                .text
                .headline6(context)
                .size(16)
                .align(TextAlign.center)
                .make()
                .pOnly(bottom: 55),
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


                const TextFieldHeading(
                  title: "Listings",
                ).pOnly(bottom: 10,top: 25),
                GetBuilder<UserListingController>(builder: (controller) {
                  return controller.obx(
                        (state) =>
                        SizedBox(
                          child:GridView.builder(
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 15,
                                crossAxisSpacing: 12,
                                mainAxisExtent: 270,
                                // childAspectRatio: 2/5,
                              ),
                              padding: const EdgeInsets.only(bottom: 25),
                              shrinkWrap: true,
                              physics: const ClampingScrollPhysics(),
                              itemCount:
                              controller.userListingModel?.data?.length,
                              itemBuilder: (context, index) {
                                Listing? am = controller.userListingModel?.data?[index];
                                if (mobileStorage == null ? am?.countryId == am?.countryId
                                    : mobileStorage?.countryId == am?.countryId) {
                                  List<String>? images = am?.listimages?.split(",");
                                  return Material(
                                    color: Theme
                                        .of(context)
                                        .cardColor,
                                    child: Card(
                                      elevation: 0.5,
                                      child: InkWell(
                                        onTap: () {
                                          detailController.viewListings(am?.id);
                                          detailController.details(am);
                                          Get.to(DetailScreen(
                                            am: am,
                                            images: images ?? [],
                                            userDetailShow: false,
                                          ));
                                        },
                                        child: Ink(
                                          child: Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment
                                                .spaceBetween,

                                            children: [
                                              Stack(
                                                children: [
                                                  SizedBox(
                                                    height: 120,
                                                    width: 180,
                                                    child: ClipRRect(
                                                        borderRadius:
                                                        BorderRadius
                                                            .circular(
                                                            20),
                                                        child: buildImage(
                                                            "$imageStorageLink${images?[0] ??
                                                                ""}")),
                                                  ),
                                                  Positioned(
                                                    right: 10,
                                                    top: 10,
                                                    child: (am?.itemId == "1" ? "Used": "New").text
                                                        .headline3(
                                                        context)
                                                        .size(10)
                                                        .make()
                                                        .pSymmetric(
                                                        h: 10, v: 2)
                                                        .box
                                                        .color(kPrimary)
                                                        .roundedLg
                                                        .make(),
                                                  )
                                                ],
                                              ),
                                              (am?.title ?? "")
                                                  .text
                                                  .bodyText1(context)
                                                  .overflow(
                                                  TextOverflow.ellipsis)
                                                  .maxLines(1)
                                                  .make().marginOnly(
                                                  top: 8),

                                              Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment
                                                    .spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      "\$"
                                                          .text
                                                          .headline4(
                                                          context)
                                                          .make(),
                                                      (am?.price ?? "")
                                                          .text
                                                          .bodyText1(
                                                          context)
                                                          .make(),
                                                    ],
                                                  ),
                                                  for (int i = 0;
                                                  i < homeController
                                                      .length; i++) ...{
                                                    if (homeController
                                                        .countryModel
                                                        ?.data?[i].id
                                                        .toString() ==
                                                        am?.countryId) ...{
                                                      "${homeController
                                                          .countryModel
                                                          ?.data?[i].name}"
                                                          .text
                                                          .headline4(
                                                          context)
                                                          .maxLines(1)
                                                          .overflow(
                                                          TextOverflow
                                                              .ellipsis)
                                                          .size(12)
                                                          .make(),
                                                    }
                                                  },


                                                ],
                                              ),
                                              ShareAndFavouriteWidget(
                                                favouriteTap: () {
                                                  homeController.favoritePostSend(am?.id);
                                                },
                                                shareImage:
                                                "$imageStorageLink${images?[0] ?? ""}",
                                                shareTitle: am?.title,
                                                listingId: am?.id,
                                              ),
                                            ],
                                          ).pSymmetric(h: 10, v: 10),
                                        ),
                                      ),
                                    ).marginOnly(right: 20),
                                  );
                                } else {
                                  return const SizedBox.shrink();
                                }
                              }),
                          ),
                    onEmpty:Center(child: "Data Empty".text.headline3(context).make(),),
                    onLoading: const VxZeroList(
                      isBottomLinesActive: true, length: 5,),
                    onError: (error) =>
                        "No Data"
                            .text
                            .headline1(context)
                            .align(TextAlign.center)
                            .make()
                            .marginOnly(top: 120,bottom: 200),
                  );
                }),
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

  Widget buildImage(imageUrl) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      fit: BoxFit.fill,
      placeholder: (context, url) =>
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              CircularProgressIndicator(),
            ],
          ),
      errorWidget: (context, url, error) => const Icon(Icons.error, size: 60,),
    );
  }
}

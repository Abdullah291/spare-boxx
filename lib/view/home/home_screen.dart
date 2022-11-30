import 'package:carousel_pro_nullsafety/carousel_pro_nullsafety.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:sparebboxx/hive_storage/mobile_storage.dart';
import 'package:sparebboxx/model/categories_model.dart';
import 'package:sparebboxx/model/listing_model.dart';
import 'package:sparebboxx/service/api_services.dart';
import 'package:sparebboxx/utils/constant.dart';
import 'package:sparebboxx/utils/theme_mode.dart';
import 'package:sparebboxx/view/categories_listing/categories_show_listing_controller.dart';
import 'package:sparebboxx/view/categories_listing/categories_show_listing_screen.dart';
import 'package:sparebboxx/view/detail/detail_controller.dart';
import 'package:sparebboxx/view/detail/detail_screen.dart';
import 'package:sparebboxx/view/home/home_controller.dart';
import 'package:sparebboxx/view/home/viewall_listing/viewall_listing_screen.dart';
import 'package:sparebboxx/view/home/viewbrand/viewbrand_screen.dart';
import 'package:sparebboxx/widget/share_favourite_widget.dart';
import 'package:sparebboxx/widget/textfield_heading.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:sparebboxx/main.dart';
import 'package:cached_network_image/cached_network_image.dart';

enum Status { featured, popular, liveAuction }

class HomeScreen extends GetView<HomeController> {
  HomeController homeController = Get.find<HomeController>();
  DetailController detailController = Get.find<DetailController>();
  CategoriesShowController categoriesShowController =
      Get.find<CategoriesShowController>();
  MobileStorage? mobileStorage = box?.get("userData");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimary,
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            "SPARE BOXX"
                .text
                .caption(context)
                .size(22)
                .make()
                .paddingOnly(top: 40, left: 15),
            "Connect with out community"
                .text
                .bodyText2(context)
                .make()
                .paddingOnly(bottom: 10, left: 15),
            GetBuilder<HomeController>(builder: (logic) {
              return Column(
                children: [
                  controller.bannerModel?.status == true
                      ? controller.obx(
                          (state) => SizedBox(
                              height: 180.0,
                              width: Get.width,
                              child: Carousel(
                                defaultImage: Image.asset("assets/Photo.png"),
                                images: List.generate(
                                  controller.bannerModel?.bannerads?.length ??
                                      0,
                                  (index) {
                                    String? img = controller.bannerModel
                                            ?.bannerads?[index].image ??
                                        "";
                                    return ClipRRect(
                                        borderRadius: BorderRadius.circular(15),
                                        child: buildImage(
                                            "$imageStorageLink$img"));
                                  },
                                ),
                                dotSize: 10.0,
                                dotIncreaseSize: 1.1,
                                boxFit: BoxFit.fill,
                                dotSpacing: 20.0,
                                dotColor: white,
                                dotIncreasedColor: kPrimary,
                                indicatorBgPadding: 10.0,
                                dotBgColor: Colors.transparent,
                                borderRadius: true,
                                autoplayDuration: const Duration(minutes: 1),
                              )).pSymmetric(v: 20),
                          onEmpty: const Center(
                            child: Text("Data Empty"),
                          ),
                          onLoading: const VxZeroList(
                            isBottomLinesActive: true,
                            length: 1,
                          ),
                          onError: (error) => const VxZeroList(
                            isBottomLinesActive: true,
                            length: 1,
                          ),
                        )
                      : const SizedBox.shrink(),
                  Material(
                    color: kButtonGrey,
                    type: MaterialType.button,
                    borderRadius: BorderRadius.circular(15),
                    child: InkWell(
                        onTap: () {
                          Get.to(ViewBrandScreen());
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const TextFieldHeading(
                              title: "View Brands",
                            ).marginOnly(right: 10),
                            const Icon(
                              Icons.check_circle,
                              color: Colors.green,
                            ),
                          ],
                        ).paddingSymmetric(
                          vertical: 12,
                        )),
                  ).marginOnly(top: 20, bottom: 10),
                  GetBuilder<HomeController>(builder: (controller) {
                    return controller.obx(
                      (state) => Column(
                        children: [
                          const TextFieldHeading(
                            title: "Categories",
                          ).paddingOnly(bottom: 15, top: 10),
                          SizedBox(
                            height: 60,
                            child: ListView.builder(
                                shrinkWrap: true,
                                physics: const ClampingScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                itemCount: controller
                                        .categoriesModel?.categories?.length ??
                                    0,
                                itemBuilder: (context, index) {
                                  Category? category = controller
                                      .categoriesModel?.categories?[index];
                                  return GestureDetector(
                                    onTap: () {
                                      categoriesShowController
                                          .categoriesShowListing(category?.id);
                                      Get.to(CategoriesListingScreen());
                                    },
                                    child: Column(
                                      children: [
                                        "${category?.name}"
                                            .text
                                            .headline3(context)
                                            .make()
                                            .paddingSymmetric(
                                                horizontal: 15, vertical: 10)
                                            .box
                                            .color(kTertiary)
                                            .roundedLg
                                            .make()
                                            .marginOnly(right: 18, bottom: 15),
                                      ],
                                    ),
                                  );
                                }),
                          ),
                        ],
                      ),
                      onEmpty: const Center(
                        child: Text("Data Empty"),
                      ),
                      onLoading: const VxZeroList(
                        isBottomLinesActive: true,
                        length: 1,
                      ),
                      onError: (error) => const VxZeroList(
                        isBottomLinesActive: true,
                        length: 1,
                      ),
                    );
                  }),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const TextFieldHeading(
                        title: "Featured Listings",
                      ).pOnly(bottom: 10),
                      GestureDetector(
                          onTap: () {
                            Get.to(ViewAllListingScreen(
                              length:
                                  controller.allListingModel?.listing?.length,
                              title: "Featured Listings",
                              status: Status.featured,
                            ));
                          },
                          child: "View all"
                              .text
                              .color(Colors.blue)
                              .size(12)
                              .make()),
                    ],
                  ),
                  GetBuilder<HomeController>(builder: (logic) {
                    return controller.obx(
                      (state) => SizedBox(
                        height: controller.featuredLength > 0 ? 290 : 50,
                        child: controller.featuredLength > 0
                            ? ListView.builder(
                                padding: const EdgeInsets.only(bottom: 20),
                                shrinkWrap: true,
                                physics: const ClampingScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                itemCount:
                                    controller.allListingModel?.listing?.length,
                                itemBuilder: (context, index) {
                                  Listing? am = controller
                                      .allListingModel?.listing?[index];
                                  if (am?.isFeatured == "1") {

                                    List<String>? images =
                                        am?.listimages?.split(",");
                                    return SizedBox(
                                      width: 180,
                                      child: Material(
                                        color: Theme.of(context).cardColor,
                                        child: Card(
                                          elevation: 0.5,
                                          child: InkWell(
                                            onTap: () {
                                              detailController.viewListings(am?.id);
                                              detailController.details(am);
                                              Get.to(DetailScreen(
                                                am: am,
                                                images: images ?? [],
                                              ));
                                            },
                                            child: Ink(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
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
                                                                "$imageStorageLink${images?[0] ?? ""}")),
                                                      ),
                                                      Positioned(
                                                        right: 10,
                                                        top: 10,
                                                        child: (am?.itemId ==
                                                                    "1"
                                                                ? "Used"
                                                                : "New")
                                                            .text
                                                            .headline3(context)
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
                                                      .make()
                                                      .marginOnly(top: 8),
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
                                                      for (int i = 0; i < homeController.length; i++) ...{
                                                        if (homeController.countryModel?.data?[i].id.toString() ==
                                                            am?.countryId) ...{

                                                          "${homeController.countryModel?.data?[i].name}"
                                                              .text
                                                              .headline4(
                                                                  context)
                                                              .maxLines(1)
                                                              .overflow(
                                                                  TextOverflow
                                                                      .ellipsis)
                                                              .size(12)
                                                              .make()
                                                        }
                                                      },

                                                    ],
                                                  ),
                                                  ShareAndFavouriteWidget(
                                                    favouriteTap: () {
                                                      controller.favoritePostSend(am?.id);
                                                    },
                                                    shareImage:
                                                        "$imageStorageLink${images?[0] ?? ""}",
                                                    shareTitle: am?.title,
                                                    listingId: am?.id,
                                                  ),
                                                ],
                                              ).pSymmetric(h: 15, v: 15),
                                            ),
                                          ),
                                        ).marginOnly(right: 20),
                                      ),
                                    );
                                  } else {
                                    return const SizedBox.shrink();
                                  }
                                })
                            : Center(
                                child: "".text.headline4(context).make(),
                              ),
                      ),
                      onEmpty: const Center(
                        child: Text("Data Empty"),
                      ),
                      onLoading: const VxZeroList(
                        isBottomLinesActive: true,
                        length: 1,
                      ),
                      onError: (error) => const VxZeroList(
                        isBottomLinesActive: true,
                        length: 1,
                      ),
                    );
                  }),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const TextFieldHeading(
                        title: "Popular Listings",
                      ).pOnly(bottom: 10),
                      GestureDetector(
                          onTap: () {
                            Get.to(ViewAllListingScreen(
                              length:
                                  controller.allListingModel?.listing?.length,
                              title: "Popular Listings",
                              status: Status.popular,
                            ));
                          },
                          child: "View all"
                              .text
                              .color(Colors.blue)
                              .size(12)
                              .make()),
                    ],
                  ),
                  GetBuilder<HomeController>(builder: (controller) {
                    return controller.obx(
                      (state) => SizedBox(
                        height: controller.popularLength > 0 ? 290 : 50,
                        child: controller.popularLength > 0
                            ? ListView.builder(
                                padding: const EdgeInsets.only(bottom: 20),
                                shrinkWrap: true,
                                physics: const ClampingScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                itemCount: controller.allListingModel?.listing?.length,
                                itemBuilder: (context, index) {
                                  Listing? am = controller.allListingModel?.listing?[index];

                                    List<String>? images = am?.listimages?.split(",");
                                    return SizedBox(
                                      width: 180,
                                      child: Material(
                                        color: Theme.of(context).cardColor,
                                        child: Card(
                                          elevation: 0.5,
                                          child: InkWell(
                                            onTap: () {
                                              detailController.viewListings(am?.id);
                                              detailController.details(am);
                                              Get.to(DetailScreen(
                                                am: am,
                                                images: images ?? [],
                                              ));
                                            },
                                            child: Ink(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
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
                                                                "$imageStorageLink${images?[0] ?? ""}")),
                                                      ),
                                                      Positioned(
                                                        right: 10,
                                                        top: 10,
                                                        child: (am?.itemId ==
                                                                    "1"
                                                                ? "Used"
                                                                : "New")
                                                            .text
                                                            .headline3(context)
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
                                                      .make()
                                                      .marginOnly(top: 8),
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
                                                          i <
                                                              homeController
                                                                  .length;
                                                          i++) ...{
                                                        if (homeController
                                                                .countryModel
                                                                ?.data?[i]
                                                                .id
                                                                .toString() ==
                                                            am?.countryId) ...{
                                                          "${homeController.countryModel?.data?[i].name}"
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
                                                      controller.favoritePostSend(am?.id);
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
                                      ),
                                    );
                                })
                            : Center(
                                child: "".text.headline4(context).make(),
                              ),
                      ),
                      onEmpty: const Center(
                        child: Text("Data Empty"),
                      ),
                      onLoading: const VxZeroList(
                        isBottomLinesActive: true,
                        length: 1,
                      ),
                      onError: (error) => const VxZeroList(
                        isBottomLinesActive: true,
                        length: 1,
                      ),
                    );
                  }),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const TextFieldHeading(
                        title: "Live Auctions",
                      ).pOnly(bottom: 10),
                      GestureDetector(
                          onTap: () {
                            Get.to(ViewAllListingScreen(
                              length:
                                  controller.allListingModel?.listing?.length,
                              title: "Live Auctions",
                              status: Status.liveAuction,
                            ));
                          },
                          child: "View all"
                              .text
                              .color(Colors.blue)
                              .size(12)
                              .make()),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  GetBuilder<HomeController>(builder: (logic) {
                    return controller.obx(
                      (state) => SizedBox(
                        height: controller.auctionLength > 0 ? 350 : 50,
                        child: controller.auctionLength > 0
                            ? ListView.builder(
                                shrinkWrap: true,
                                physics: const ClampingScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                itemCount:
                                    controller.allListingModel?.listing?.length,
                                itemBuilder: (context, index) {
                                  Listing? am = controller
                                      .allListingModel?.listing?[index];
                                  if (am?.auction == "1") {
                                    List<String>? images =
                                        am?.listimages?.split(",");
                                    return SizedBox(
                                      height: 270,
                                      width: 270,
                                      child: Material(
                                        color: Theme.of(context).cardColor,
                                        child: Card(
                                          elevation: 0.5,
                                          child: InkWell(
                                            onTap: () {
                                              detailController.viewListings(am?.id);
                                              detailController.details(am);
                                              Get.to(DetailScreen(
                                                am: am,
                                                images: images ?? [],
                                              ));
                                            },
                                            child: Ink(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [

                                                  SizedBox(
                                                    height: 200,
                                                    width: 270,
                                                    child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
                                                        child: buildImage(
                                                            "$imageStorageLink${images?[0] ?? ''}")),
                                                  ),
                                                  (am?.title ?? "")
                                                      .text
                                                      .headline5(context)
                                                      .maxLines(1)
                                                      .overflow(
                                                          TextOverflow.ellipsis)
                                                      .make()
                                                      .marginOnly(top: 15),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      "\$ ${am?.price ?? ""}"
                                                          .text
                                                          .headline5(context)
                                                          .make(),
                                                      for (int i = 0;
                                                          i <
                                                              homeController
                                                                  .length;
                                                          i++) ...{
                                                        if (homeController
                                                                .countryModel
                                                                ?.data?[i]
                                                                .id
                                                                .toString() ==
                                                            am?.countryId) ...{
                                                          "${homeController.countryModel?.data?[i].name}"
                                                              .text
                                                              .headline4(
                                                                  context)
                                                              .maxLines(1)
                                                              .overflow(
                                                                  TextOverflow
                                                                      .ellipsis)
                                                              .size(12)
                                                              .make(),
                                                        },
                                                      },

                                                    ],
                                                  ),
                                                  ShareAndFavouriteWidget(
                                                    favouriteTap: () {
                                                      controller.favoritePostSend(am?.id);
                                                    },
                                                    shareImage:
                                                        "$imageStorageLink${images?[0] ?? ""}",
                                                       shareTitle: am?.title,
                                                    listingId: am?.id,
                                                  ),
                                                ],
                                              ).pSymmetric(h: 10, v: 5),
                                            ),
                                          ),
                                        ).marginOnly(right: 20),
                                      ),
                                    );
                                  } else {
                                    return const SizedBox.shrink();
                                  }
                                })
                            : Center(
                                child: "".text.headline4(context).make(),
                              ),
                      ),
                      onEmpty: const Center(
                        child: Text(
                          "Data Empty",
                        ),
                      ),
                      onLoading: const VxZeroList(
                        isBottomLinesActive: true,
                        length: 1,
                      ),
                      onError: (error) => const VxZeroList(
                        isBottomLinesActive: true,
                        length: 1,
                      ),
                    );
                  }),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              );
            })
                .box
                .topRounded(value: 30)
                .padding(const EdgeInsets.symmetric(horizontal: 15))
                .color(ThemeService().theme == ThemeMode.dark
                    ? Theme.of(context).scaffoldBackgroundColor
                    : kOffWhite)
                .make(),
          ],
        ),
      ),
      bottomNavigationBar: GetBuilder<HomeController>(builder: (logic) {
        if (controller.isHomePageBannerLoaded) {
          return SizedBox(
              height: controller.homePageBanner.size.height.toDouble(),
              child: AdWidget(ad: controller.homePageBanner));
        } else {
          return const SizedBox.shrink();
        }
      }),
    );
  }

  Widget buildImage(imageUrl) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      fit: BoxFit.fill,
      placeholder: (context, url) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          CircularProgressIndicator(),
        ],
      ),
      errorWidget: (context, url, error) => const Icon(
        Icons.error,
        size: 60,
      ),
    );
  }
}

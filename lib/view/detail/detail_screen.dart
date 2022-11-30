import 'package:cached_network_image/cached_network_image.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sparebboxx/hive_storage/mobile_storage.dart';
import 'package:sparebboxx/model/listing_model.dart';
import 'package:sparebboxx/service/api_services.dart';
import 'package:sparebboxx/utils/constant.dart';
import 'package:sparebboxx/utils/assets.dart';
import 'package:sparebboxx/utils/dynamic_linking.dart';
import 'package:sparebboxx/view/detail/detail_controller.dart';
import 'package:sparebboxx/view/detail/userPosts/userpost_screen.dart';
import 'package:sparebboxx/view/detail/userPosts/userpost_controller.dart';
import 'package:sparebboxx/widget/fab_menu_widget.dart';
import 'package:sparebboxx/widget/network_image_widget.dart';
import 'package:sparebboxx/widget/timer_widget.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:sparebboxx/main.dart';

class DetailScreen extends StatelessWidget {
  Listing? am;
  List images;
  bool? showAgain;
  bool? userDetailShow;

  DetailScreen({required this.am, required this.images, this.showAgain = true,this.userDetailShow=true});

  DetailController controller = Get.find<DetailController>();
  UserPostController userPostController = Get.find<UserPostController>();

  MobileStorage? mobileStorage = box?.get("userData");

  @override
  Widget build(BuildContext context) {
    int? endTime;
    if (am?.auctionEnd != null) {
      List? auctionEnd = am?.auctionEnd.toString().split(" ");
      List? auctionEndDate = auctionEnd?[0].toString().split("-");
      endTime = DateTime(
          int.parse(auctionEndDate?[0]),
          int.parse(auctionEndDate?[1]),
          int.parse(auctionEndDate?[2])).millisecondsSinceEpoch + 1000 * 30;
    }
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(Icons.close, color: Colors.white,)),
        actions: [
          mobileStorage?.token == null
              ? const SizedBox.shrink()
              : IconButton(
              onPressed: () {
                Get.bottomSheet(Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListTile(
                      tileColor: Theme.of(context).scaffoldBackgroundColor,
                      onTap: () {
                        DynamicLinkService.createFirstPostLink(
                            am?.title ?? "", "$imageStorageLink${images[0] ?? ""}");
                      },
                      leading: Icon(
                        Icons.adaptive.share,
                        color: Theme
                            .of(context)
                            .canvasColor,
                      ),
                      title: "Share".text.headline4(context).make(),
                    ),
                    ListTile(
                      tileColor: Theme.of(context).scaffoldBackgroundColor,
                      onTap: () {
                        controller.blockListings(am?.id);
                      },
                      leading: Icon(
                        Icons.report,
                        color: Theme
                            .of(context)
                            .canvasColor,
                      ),
                      title: "Report".text.headline4(context).make(),
                    ),
                  ],
                ));
              },
              icon: Icon(Icons.more_vert, color: Colors.white,)
                  .marginOnly(right: 20)),
        ],
      ),
      body: SingleChildScrollView(
        child: GetX<DetailController>(
            init: DetailController(),
            builder: (controller) {
              return Column(children: [
                images.isNotEmpty
                    ? Stack(
                  children: [
                    SizedBox(
                      height: 400,
                      child: PageView.builder(
                          pageSnapping: true,
                          controller: controller.pageController,
                          onPageChanged: controller.selectedPageIndex,
                          itemCount: images.length - 1,
                          itemBuilder: (context, index) {
                            String image = images[index];
                            return CachedNetworkImage(
                              imageUrl: imageStorageLink + image,
                              fit: BoxFit.fill,
                              placeholder: (context, url) =>
                                  Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.center,
                                    children: const [
                                      CircularProgressIndicator(),
                                    ],
                                  ),
                              errorWidget: (context, url, error) =>
                              const Icon(
                                Icons.error,
                                size: 80,
                              ),
                            ).w(Get.width);
                          }),
                    ),
                    Positioned(
                      bottom: 15,
                      left: 0,
                      right: 0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                            images.length - 1,
                                (index) =>
                                Container(
                                  margin: const EdgeInsets.only(right: 8),
                                  width: 40,
                                  height: 5,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                    BorderRadius.circular(100),
                                    color: controller.selectedPageIndex ==
                                        index
                                        ? white
                                        : Colors.grey.withOpacity(0.6),
                                  ),
                                )),
                      ),
                    ),
                  ],
                ).pSymmetric(v: 20)
                    : const SizedBox(),
                (am?.title ?? "")
                    .text
                    .headline1(context)
                    .fontWeight(FontWeight.w400)
                    .make()
                    .marginSymmetric(horizontal: 15),

                ListTile(
                  leading: const Icon(Icons.location_on_rounded),
                  title: (am?.address ?? "").text.subtitle2(context).make(),
                ),
                mobileStorage?.token == null || userDetailShow == false ? const SizedBox.shrink()
                    : ListTile(
                  leading: const Icon(Icons.call),
                  title: (am?.phoneNo ?? "").text.subtitle2(context).make(),
                ),
                mobileStorage?.token == null || userDetailShow == false ? const SizedBox.shrink()
                    : ListTile(
                  leading: SvgPicture.asset(
                    emailIcon,
                    color: Colors.grey,
                    width: 20,
                  ),
                  title: (am?.email ?? "").text.subtitle2(context).make(),
                ),
                ExpandablePanel(
                  theme: const ExpandableThemeData(
                    iconColor: kPrimary,
                  ),
                  header: "Description".text.headline3(context).size(14).make(),
                  collapsed: const SizedBox.shrink(),
                  expanded:
                  (am?.description ?? "").text.headline4(context).make(),
                )
                    .box
                    .border(color: kTertiary, width: 2)
                    .margin(const EdgeInsets.symmetric(vertical: 15))
                    .padding(const EdgeInsets.symmetric(
                    horizontal: 10, vertical: 10))
                    .rounded
                    .make(),

               userDetailShow == false ? const SizedBox.shrink() : ListTile(
                  onTap: () {
                    if (showAgain == true) {
                      userPostController.userPostListingShow(userId: am?.userId);
                      Get.to(UserPostScreen(am: am,));
                    }
                  },
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: SizedBox(
                      height: 50,
                      width: 50,
                      child: NetworkImageWidget(
                          imageUrl: "$imageStorageLink2${am?.avatar ?? ''}"),
                    ),
                  ),
                  title:
                  (am?.name ?? "").text.headline3(context).size(14).make(),
                  subtitle: mobileStorage?.token == null
                      ? const SizedBox.shrink()
                      : (am?.email ?? "").text.subtitle2(context).make(),
                  trailing: showAgain == true ? const Icon(
                    Icons.arrow_forward_ios_sharp,
                    size: 20,
                  ) : const SizedBox.shrink(),
                ),

                SizedBox(
                  height: userDetailShow == false ? 0 : 20,
                ),
                ListTile(
                  leading: "Category: ".text.headline3(context).size(14).make(),
                  title: (controller.categoryNames ?? "")
                      .text
                      .subtitle2(context)
                      .make(),
                ),
                ListTile(
                  leading: "Type: ".text.headline3(context).size(14).make(),
                  title: (controller.typeNames ?? "")
                      .text
                      .subtitle2(context)
                      .make(),
                ),
                ListTile(
                  leading:
                  "Price Type: ".text.headline3(context).size(14).make(),
                  title: (controller.priceNames ?? "")
                      .text
                      .subtitle2(context)
                      .make(),
                ),

                ListTile(
                  leading: "Deal: ".text.headline3(context).size(14).make(),
                  title: (controller.dealNames ?? "")
                      .text
                      .subtitle2(context)
                      .make(),
                ),

                GetBuilder<DetailController>(builder: (logic) {
                  return ListTile(
                    leading: "Views: ".text.headline3(context).size(14).make(),
                    title: (am?.views ?? "")
                        .text
                        .subtitle2(context)
                        .make(),
                  );
                }),


                if(am?.auctionEnd != null)...{
                  CountdownTimer(
                    endTime: endTime,
                    widgetBuilder: (_, CurrentRemainingTime? time) {
                      if (time == null) {
                        return 'Auction End'.text.headline3(context)
                            .size(18)
                            .make()
                            .paddingAll(15);
                      }
                      return Column(
                        children: [
                          "Auction End".text.headline1(context).size(16)
                              .make()
                              .paddingOnly(bottom: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TimerWidget(title: time.days, subtitle: "Days",),
                              TimerWidget(
                                title: time.hours, subtitle: "Hours",),
                              TimerWidget(title: time.min, subtitle: "Min",),
                              TimerWidget(title: time.sec, subtitle: "Sec",),
                            ],
                          ),
                        ],
                      )
                          .paddingAll(15)
                          .box
                          .color(kPrimary.withOpacity(0.9))
                          .roundedLg
                          .make()
                          .marginSymmetric(horizontal: Get.width * 0.05,
                          vertical: 15);
                    },
                  ),
                }

                // GetBuilder<DetailController>(
                //     init: DetailController(),
                //     builder: (logic) {
                //       return ExpandablePanel(
                //               theme: const ExpandableThemeData(
                //                 iconColor: kPrimary,
                //               ),
                //               header: "Features"
                //                   .text
                //                   .headline3(context)
                //                   .size(14)
                //                   .make(),
                //               collapsed: const SizedBox.shrink(),
                //               expanded: Column(
                //                 children: [
                //                   CheckboxListTile(
                //                     contentPadding: EdgeInsets.zero,
                //                     controlAffinity:
                //                         ListTileControlAffinity.leading,
                //                     selected: controller.accept,
                //                     dense: false,
                //                     title: "Accept Card".text.make(),
                //                     value: controller.accept,
                //                     onChanged: (value) {},
                //                   ),
                //                   CheckboxListTile(
                //                     contentPadding: EdgeInsets.zero,
                //                     controlAffinity:
                //                         ListTileControlAffinity.leading,
                //                     selected: controller.accept,
                //                     dense: false,
                //                     title: "Accept Card".text.make(),
                //                     value: controller.accept,
                //                     onChanged: (value) {},
                //                   ),
                //                   CheckboxListTile(
                //                     contentPadding: EdgeInsets.zero,
                //                     controlAffinity:
                //                         ListTileControlAffinity.leading,
                //                     selected: controller.accept,
                //                     dense: false,
                //                     title: "Accept Card".text.make(),
                //                     value: controller.accept,
                //                     onChanged: (value) {},
                //                   ),
                //                 ],
                //               ))
                //           .box
                //           .border(color: kTertiary, width: 2)
                //           .margin(const EdgeInsets.only(bottom: 15))
                //           .padding(const EdgeInsets.symmetric(
                //               horizontal: 10, vertical: 10))
                //           .rounded
                //           .make();
                //     }),
              ]);
            }),
      ),
      floatingActionButton: mobileStorage?.token == null || userDetailShow == false || am?.email == mobileStorage?.email
          ? const SizedBox.shrink()
          : FabMenuWidget(
        am: am,
      ),
      bottomNavigationBar: GetBuilder<DetailController>(builder: (logic) {
        if (controller.isDetailPageInterstitialLoaded) {
          controller.detailPageInterstitial.show();
        }
        return const SizedBox.shrink();
      }),
    );
  }
}

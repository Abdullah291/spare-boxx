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
import 'package:sparebboxx/utils/theme_mode.dart';
import 'package:sparebboxx/view/detail/detail_screen.dart';
import 'package:sparebboxx/view/home/home_controller.dart';
import 'package:sparebboxx/view/home/home_screen.dart';
import 'package:sparebboxx/widget/share_favourite_widget.dart';
import 'package:velocity_x/velocity_x.dart';



class ViewAllListingScreen extends StatelessWidget {
  ViewAllListingScreen({Key? key,this.length,this.title,this.status}) : super(key: key);
  HomeController homeController = Get.find<HomeController>();
  MobileStorage? mobileStorage = box?.get("userData");
  int? length;
  String? title;
  Enum? status;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ThemeService().theme == ThemeMode.dark
            ? Theme
            .of(context)
            .scaffoldBackgroundColor
            : kOffWhite,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: kPrimary,
          leading:  IconButton(
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
          title: "$title"
              .text
              .caption(context)
              .size(16)
              .make(),
        ),
        body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      GetBuilder<HomeController>(builder: (controller) {
        return controller.obx(
              (state) => Container(
                margin: const EdgeInsets.only(right: 10),
                width: Get.width,
            child: Wrap(
              alignment: WrapAlignment.start,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: List.generate(
                  length ?? 0, (index) {
                Listing? am = controller.allListingModel?.listing?[index];

                if (status== Status.featured ? am?.isFeatured == "1" :
                   status== Status.liveAuction ? am?.auction == "1" :
                    status== Status.popular ) {
                  List<String>? images = am?.listimages
                      ?.split(",");
                  return SizedBox(
                    width: Get.width*0.47,
                    height: 280,
                    child: GestureDetector(
                      onTap: () {
                        Get.to(DetailScreen(
                          am: am,
                          images: images ?? [],
                        ));
                      },
                      child: Material(
                        color: Theme
                            .of(context)
                            .cardColor,
                        child: Card(
                          elevation: 0.5,
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [
                              Stack(
                                children: [
                                  SizedBox(
                                    height: 120,
                                    width: 180,
                                    child: ClipRRect(
                                        borderRadius:
                                        BorderRadius.circular(20),
                                        child: buildImage(
                                            "$imageStorageLink${images?[0] ??
                                                ""}")),
                                  ),
                                  Positioned(
                                    right: 10,
                                    top: 10,
                                    child: (am?.itemId == "1"
                                        ? "Used"
                                        : "New")
                                        .text
                                        .headline3(context)
                                        .size(10)
                                        .make()
                                        .pSymmetric(h: 10, v: 2)
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
                                  .overflow(TextOverflow.ellipsis)
                                  .maxLines(1)
                                  .make()
                                  .marginOnly(top: 8),

                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      "\$"
                                          .text
                                          .headline4(context)
                                          .make(),
                                      (am?.price ?? "")
                                          .text
                                          .bodyText1(context)
                                          .make(),
                                    ],
                                  ),
                                  for (int i = 0;
                                  i < homeController.length;
                                  i++) ...{
                                    if (homeController
                                        .countryModel?.data?[i].id
                                        .toString() ==
                                        am?.countryId) ...{
                                      "${homeController.countryModel?.data?[i]
                                          .name}"
                                          .text
                                          .headline4(context)
                                          .maxLines(1)
                                          .overflow(TextOverflow.ellipsis)
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
                        ).marginOnly(left: 10),
                      ),
                    ),
                  ).marginOnly(bottom: 15);
                }
                else{
                  return const SizedBox.shrink();
                }
              }
               )
                ),
          ),
          onEmpty: const Center(
            child: Text("Data Empty"),
          ),
          onLoading: const VxZeroList(
            isBottomLinesActive: true,
            length: 3,
          ),
          onError: (error) => "No Data"
              .text
              .headline1(context)
              .align(TextAlign.center)
              .make()
              .marginOnly(top: 120, bottom: 200),
        );
      }).box
        .topRounded(value: 30).padding(const EdgeInsets.only(top: 20))
        .make()
            ]
        )
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

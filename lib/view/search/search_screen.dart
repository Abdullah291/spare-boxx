import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sparebboxx/model/listing_model.dart';
import 'package:sparebboxx/service/api_services.dart';
import 'package:sparebboxx/utils/constant.dart';
import 'package:sparebboxx/utils/loading_indicator.dart';
import 'package:sparebboxx/view/detail/detail_controller.dart';
import 'package:sparebboxx/view/detail/detail_screen.dart';
import 'package:sparebboxx/view/home/home_controller.dart';
import 'package:sparebboxx/view/search/search_controller.dart';
import 'package:sparebboxx/widget/share_favourite_widget.dart';
import 'package:velocity_x/velocity_x.dart';

class SearchScreen extends GetView<SearchController> {
  DetailController detailController = Get.find<DetailController>();
  HomeController homeController = Get.find<HomeController>();
  SearchController controllers = Get.find<SearchController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: "Search"
            .toString()
            .text
            .headline6(context)
            .color(Theme
            .of(context)
            .canvasColor)
            .make(),
        centerTitle: true,
      ),
      body: GetBuilder<SearchController>(builder: (logic) {
        return Stack(
          children: [
            Column(
              children: [
                "Use the flters to enhance your searh results"
                    .toString()
                    .text
                    .headline5(context)
                    .fontWeight(FontWeight.w400)
                    .make(),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextField(
                        controller: controller.searchTitle,
                        cursorColor: kPrimary,
                        style: Theme
                            .of(context)
                            .textTheme
                            .headline5!
                            .copyWith(fontWeight: FontWeight.w400),
                        decoration: InputDecoration(
                            contentPadding: const EdgeInsets.only(left: 15),
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(100.0),
                            ),
                            filled: true,
                            fillColor: kTertiary,
                            suffixIcon: GestureDetector(
                              onTap: () {
                                controllers.searchListingShow("");
                              },
                              child: Column(
                                children: [
                                  const Icon(
                                    Icons.search,
                                    color: Colors.white,
                                    size: 30,
                                  )
                                      .p8()
                                      .box
                                      .color(kPrimary)
                                      .roundedFull
                                      .make()
                                ],
                              ),
                            ))).box
                        .width(Get.width * 0.7)
                        .roundedFull
                        .make(),
                    GestureDetector(
                        onTap: () {
                          Get.bottomSheet(Column(
                            // mainAxisSize: MainAxisSize.min,
                            children: [
                              Align(
                                alignment: Alignment.center,
                                child: "Filter".text.headline3(context).size(16).make(
                                ).marginOnly(top: 15,bottom: 5),
                              ),
                              Divider(
                                thickness: 1.0,
                              ),
                              SizedBox(height: 5,),
                              Row(
                                children: [
                                  SizedBox(width: 20,),
                                  OutlinedButton(
                                      style: OutlinedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(100)
                                          ),
                                          backgroundColor: controller.itemId==null? kPrimary: Colors.transparent
                                      ),
                                      onPressed: (){
                                        controller.filterSelect(Filter.allItem);
                                      }, child: "All".text.headline2(context).make()),
                                  SizedBox(width: 15,),
                                  OutlinedButton(
                                      style: OutlinedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(100)
                                          ),
                                          backgroundColor: controller.itemId=="1"? kPrimary: Colors.transparent
                                      ),
                                      onPressed: (){
                                       controller.filterSelect(Filter.newItem);
                                      }, child: "New".text.headline2(context).make()),
                                  SizedBox(width: 15,),
                                  OutlinedButton(
                                      style: OutlinedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(100)
                                          ),
                                        backgroundColor: controller.itemId=="0"? kPrimary: Colors.transparent
                                      ),
                                      onPressed: (){
                                        controller.filterSelect(Filter.usedItem);

                                      }, child: "Used".text.headline2(context).make()),

                                ],
                              )
                            ],
                          ).box.color(Theme.of(context).scaffoldBackgroundColor).make());
                        },
                        child: Image
                            .asset(
                          "assets/Icon.png",
                          height: 50,
                        )
                            .box
                            .color(kPrimary)
                            .roundedFull
                            .make()),
                  ],
                ),
                Expanded(
                  child: controller.obx(
                        (state) =>
                        GridView.builder(
                            padding: const EdgeInsets.only(bottom: 20,top: 10),
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              mainAxisExtent: 270,
                              crossAxisSpacing: 10,
                              crossAxisCount: 2,
                            ),
                            shrinkWrap: true,
                            physics: const ClampingScrollPhysics(),
                            itemCount: controller.searchListingModel?.listing
                                ?.length ?? 0,
                            itemBuilder: (context, index) {
                              Listing? am = controller.searchListingModel?.listing?[index];
                              List<String>? images = am?.listimages?.split(",");
                              return Material(
                                color: Theme
                                    .of(context)
                                    .cardColor,
                                child: Card(
                                  elevation: 0.5,
                                  child: InkWell(
                                    onTap: () {
                                      detailController.details(am);
                                      Get.to(DetailScreen(
                                        am: am,
                                        images: images ?? [],
                                      ));
                                    },
                                    child: Ink(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment
                                            .start,
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          Stack(
                                            children: [
                                              SizedBox(
                                                height: 100,
                                                width: 180,
                                                child: ClipRRect(
                                                    borderRadius:
                                                    BorderRadius.circular(
                                                        20),
                                                    child: buildImage(
                                                        "$imageStorageLink${images?[0] ??
                                                            ""}")),
                                              ),
                                              Positioned(
                                                right: 10,
                                                top: 10,
                                                child: (am?.itemId == "1" ? "Used": "New")
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
                                              .overflow(TextOverflow
                                              .ellipsis)
                                              .maxLines(1)
                                              .make()
                                              .marginOnly(top: 8),

                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  "\$".text.headline4(
                                                      context)
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
                                                if (homeController.countryModel
                                                    ?.data?[i].id
                                                    .toString() ==
                                                    am?.countryId) ...{
                                                  "${homeController.countryModel
                                                      ?.data?[i].name}"
                                                      .text
                                                      .headline4(context)
                                                      .maxLines(1)
                                                      .overflow(
                                                      TextOverflow.ellipsis)
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
                            }),
                    onError: (error) =>
                        Container(
                            margin: EdgeInsets.symmetric(vertical: Get.height * 0.25),
                            child: Center(
                              child: "Search Listing Here".text.headline2(
                                  context)
                                  .make(),
                            )),
                    onLoading: const VxZeroList(
                        length: 1, isBottomLinesActive: true),
                    onEmpty:Container(
                        margin: EdgeInsets.symmetric(vertical: Get.height * 0.25),
                        child: Center(
                          child: "Nothing Found".text.headline2(context)
                              .make(),
                        )),
                  ),
                ),
              ],
            ).p16(),
            if(controllers.loading)...{
              const LoadingIndicator(),
            }

                  ],
                );
              }

      ) );
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
      errorWidget: (context, url, error) =>
      const Icon(
        Icons.error,
        size: 45,
      ),
    );
  }
}

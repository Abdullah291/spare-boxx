import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:sparebboxx/model/listing_model.dart';
import 'package:sparebboxx/service/api_services.dart';
import 'package:sparebboxx/utils/constant.dart';
import 'package:sparebboxx/view/categories_listing/categories_show_listing_controller.dart';
import 'package:sparebboxx/view/detail/detail_controller.dart';
import 'package:sparebboxx/view/detail/detail_screen.dart';
import 'package:sparebboxx/view/home/home_controller.dart';
import 'package:sparebboxx/widget/appbar_widget.dart';
import 'package:velocity_x/velocity_x.dart';



class CategoriesListingScreen extends GetView<CategoriesShowController> {
  CategoriesListingScreen({Key? key}) : super(key: key);

  CategoriesShowController categoriesShowController=Get.find<CategoriesShowController>();
  HomeController homeController =Get.find<HomeController>();
  DetailController detailController =Get.find<DetailController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(title: "Categories Listing", context: context),
      body: controller.obx(
            (state) =>
            GridView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 20),
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200,
                  childAspectRatio: 1/1.4,
                ),
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                itemCount: categoriesShowController.categoriesShowModel?.listings
                    ?.length ?? 0,
                itemBuilder: (context, index) {
                  Listing? datum = categoriesShowController.categoriesShowModel?.listings?[index];
                  List<String>? images = datum?.listimages?.split(",");
                  return Material(
                    color: Theme
                        .of(context)
                        .cardColor,
                    child: Card(
                      elevation: 0.5,
                      child: InkWell(
                        onTap: () {
                          detailController.details(datum);
                          Get.to(DetailScreen(
                            am: datum,
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
                                    child: "sale"
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
                              (datum?.title ?? "")
                                  .text
                                  .bodyText1(context)
                                  .overflow(TextOverflow
                                  .ellipsis)
                                  .maxLines(1)
                                  .make()
                                  .marginOnly(top: 8),
                              for (int i = 0;
                              i < homeController.length;
                              i++) ...{
                                if (homeController.countryModel
                                    ?.data?[i].id
                                    .toString() ==
                                    datum?.countryId) ...{
                                  "${homeController.countryModel?.data?[i].name}"
                                      .text
                                      .headline4(context)
                                      .maxLines(1)
                                      .overflow(
                                      TextOverflow.ellipsis)
                                      .size(12)
                                      .make(),
                                }
                              },
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      "\$".text.headline4(
                                          context)
                                          .make(),
                                      (datum?.price ?? "")
                                          .text
                                          .bodyText1(context)
                                          .make(),
                                    ],
                                  ),
                                  const Icon(
                                    Icons.favorite_outlined,
                                    color: white,
                                  )
                                      .box
                                      .padding(
                                      const EdgeInsets
                                          .symmetric(
                                          horizontal: 4,
                                          vertical: 4))
                                      .withRounded(value: 10)
                                      .color(kPrimary)
                                      .make(),
                                ],
                              )
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
      bottomNavigationBar: GetBuilder<CategoriesShowController>(
          builder: (logic) {
            if(controller.isCategoriesBannerLoaded){
              return SizedBox(
                  height: controller.categoriesBanner.size.height.toDouble(),
                  child: AdWidget(ad: controller.categoriesBanner)
              );
            }
            else{
              return const SizedBox.shrink();
            }
          }),
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
      errorWidget: (context, url, error) =>
      const Icon(
        Icons.error,
        size: 45,
      ),
    );
  }
}

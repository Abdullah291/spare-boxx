import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sparebboxx/service/api_services.dart';
import 'package:sparebboxx/utils/assets.dart';
import 'package:sparebboxx/utils/constant.dart';
import 'package:sparebboxx/view/detail/detail_controller.dart';
import 'package:sparebboxx/view/detail/detail_screen.dart';
import 'package:sparebboxx/view/detail/userPosts/userpost_controller.dart';
import 'package:sparebboxx/view/home/home_controller.dart';
import 'package:sparebboxx/widget/network_image_widget.dart';
import 'package:sparebboxx/widget/share_favourite_widget.dart';
import 'package:sparebboxx/widget/textfield_heading.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:sparebboxx/model/listing_model.dart';


class UserPostScreen extends StatelessWidget {
  UserPostController userPostController =
      Get.find<UserPostController>();
  HomeController homeController = Get.find<HomeController>();
  DetailController detailController = Get.find<DetailController>();


  UserPostScreen({Key? key,this.am}) : super(key: key);

  Listing? am;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimary,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                IconButton(
                  onPressed: () {
                    Get.bottomSheet(Container(
                      color: Colors.white,
                      child: ListTile(
                        onTap: () {
                          userPostController.blockUser(am?.id);
                        },
                        contentPadding: EdgeInsets.zero,
                        leading: Icon(
                          Icons.block,
                          color: Theme.of(context).canvasColor,
                        ),
                        title: "Block User".text.headline4(context).make(),
                      ),
                    ));
                  },
                  iconSize: 45,
                  icon:const Icon(Icons.more_vert,color: Colors.white),
                ),
              ],
            ).marginOnly(top: 20,),
            "User Posts"
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
                            imageUrl:
                              "$imageStorageLink2${am?.avatar ?? ''}",
                          ),
                        ),
                      ).centered(),
                    ),
                  ],
                ),
                (am?.name ?? "")
                    .text
                    .headline1(context)
                    .align(TextAlign.center)
                    .make()
                    .marginOnly(top: 70),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    (am?.email ?? "").text.headline4(context).make(),
                    const SizedBox(
                      width: 5,
                    ),
                    if (am?.emailVerifiedAt != null) ...{
                      const Icon(
                        Icons.verified_rounded,
                        color: Colors.blue,
                        size: 22,
                      ),
                    },
                  ],
                ),
                const TextFieldHeading(
                  title: "Listings",
                ).pOnly(bottom: 10, top: 25),
                GetBuilder<UserPostController>(builder: (controller) {
                  return controller.obx(
                    (state) => SizedBox(
                      child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 15,
                            mainAxisExtent: 270,
                            // childAspectRatio: 2/5,
                          ),
                          padding: const EdgeInsets.only(bottom: 25),
                          shrinkWrap: true,
                          physics: const ClampingScrollPhysics(),
                          itemCount: controller.userListingModel?.data?.length,
                          itemBuilder: (context, index) {
                            Listing? datum =
                                controller.userListingModel?.data?[index];
                              List<String>? images = datum?.listimages?.split(",");
                              return GestureDetector(
                                onTap: (){
                                  Get.to(DetailScreen(
                                    am: am,
                                    images: images ?? [],
                                    showAgain: false,
                                  ) );
                                },
                                child: Material(
                                  color: Theme.of(context).cardColor,
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
                                                      "$imageStorageLink${images?[0] ?? ""}")),
                                            ),
                                            Positioned(
                                              right: 10,
                                              top: 10,
                                              child: (datum?.itemId == "1"
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
                                        (datum?.title ?? "")
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
                                                (datum?.price ?? "")
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
                                                  datum?.countryId) ...{
                                                "${homeController.countryModel?.data?[i].name}"
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
                                            homeController.favoritePostSend(datum?.id);
                                          },
                                          shareImage:
                                          "$imageStorageLink${images?[0] ?? ""}",
                                          shareTitle: datum?.title,
                                          listingId: datum?.id,
                                        ),
                                      ],
                                    ).pSymmetric(h: 10, v: 10),
                                  ).marginOnly(right: 20),
                                ),
                              );

                          }),
                    ),
                    onEmpty: const Center(
                      child: Text("Data Empty"),
                    ),
                    onLoading: const VxZeroList(
                      isBottomLinesActive: true,
                      length: 5,
                    ),
                    onError: (error) => "No Data"
                        .text
                        .headline1(context)
                        .align(TextAlign.center)
                        .make()
                        .marginOnly(top: 120, bottom: 200),
                  );
                }),
              ],
            )
                .box
                .topRounded(value: 30)
                .padding(const EdgeInsets.symmetric(horizontal: 15))
                .color(Theme.of(context).scaffoldBackgroundColor)
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

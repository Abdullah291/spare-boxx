import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sparebboxx/hive_storage/mobile_storage.dart';
import 'package:sparebboxx/utils/constant.dart';
import 'package:sparebboxx/utils/loading_indicator.dart';
import 'package:sparebboxx/utils/theme_mode.dart';
import 'package:sparebboxx/utils/validation.dart';
import 'package:sparebboxx/view/add_new_listing/add_new_listing_controller.dart';
import 'package:sparebboxx/widget/appbar_widget.dart';
import 'package:sparebboxx/widget/without_login_widget.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:sparebboxx/main.dart';


class AddNewListingScreen extends GetView<AddNewListingController> {
   MobileStorage? mobileStorage= box?.get("userData");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
      ThemeService().theme == ThemeMode.dark ? Colors.black : kOffWhite,
      appBar: appBarWidget(title: "Add New Listing", context: context),
      body:mobileStorage?.token == null?const WithoutLoginScreen():SingleChildScrollView(
        child: GetBuilder<AddNewListingController>(
            builder: (controller) {
              return Stack(
                children: [
                  Form(
                    key: controller.form,
                    child: Column(
                      children: [
                        "Add upto 6 good looking photos"
                            .text
                            .headline3(context)
                            .color(kPrimary)
                            .make()
                            .pOnly(bottom: 15),
                        GridView.builder(
                            shrinkWrap: true,
                            physics: const ClampingScrollPhysics(),
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              mainAxisSpacing: 15,
                              crossAxisSpacing: 10,
                            ),
                            itemCount: controller.image.length + 1,
                            itemBuilder: (context, index) {
                              if (index == controller.image.length) {
                                return GestureDetector(
                                  onTap: () async {
                                    await controller.chooseImage();
                                  },
                                  child: DottedBorder(
                                    color: kPrimary,
                                    strokeWidth: 2,
                                    borderType: BorderType.Rect,
                                    child: const Center(
                                      child: Icon(
                                        Icons.add,
                                        color: kPrimary,
                                        size: 60,
                                      ),
                                    ),
                                  ),
                                );
                              } else {
                                return Image.file(controller.image[index],
                                    fit: BoxFit.cover);
                              }
                            }),
                        Card(
                          elevation: 0.3,
                          child: TextFormField(
                            controller: controller.titleController,
                            validator: Validation().titleValidation,
                            maxLength: 100,
                            maxLines: 4,
                            style: Theme
                                .of(context)
                                .textTheme
                                .headline4,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              counterStyle: Theme
                                  .of(context)
                                  .textTheme
                                  .headline4
                                  ?.copyWith(fontSize: 12),
                              hintText: "Title your item",
                                errorStyle: const TextStyle(
                                  fontSize: 12,
                                )
                            ),
                          ),
                        ).pSymmetric(v: 15),
                        DropdownButton(
                          dropdownColor: Theme
                              .of(context)
                              .scaffoldBackgroundColor,
                          itemHeight: 60,
                          hint: (controller.selectedCategory ?? 'Select Category')
                              .text
                              .headline4(context)
                              .make(),
                          isExpanded: true,
                          iconSize: 30.0,
                          style: Theme
                              .of(context)
                              .textTheme
                              .headline4,
                          value: controller.selectedCategory,
                          items: controller.categoriesModel?.categories?.map((val) {
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
                          onChanged: (val) {
                            controller.changedCategory(val);
                          },
                        ),
                        DropdownButton(
                          dropdownColor: Theme
                              .of(context)
                              .scaffoldBackgroundColor,
                          itemHeight: 60,
                          hint: (controller.selectedType ?? 'Select Type')
                              .text
                              .headline4(context)
                              .make(),
                          isExpanded: true,
                          iconSize: 30.0,
                          style: Theme
                              .of(context)
                              .textTheme
                              .headline4,
                          value: controller.selectedType,
                          items: controller.typeModel?.types?.map(
                                (val) {
                              return DropdownMenuItem<String>(
                                value: val.id.toString(),
                                child: val.type
                                    .toString()
                                    .text
                                    .headline4(context)
                                    .make(),
                              );
                            },
                          ).toList(),
                          onChanged: (val) {
                            controller.changedType(val);
                          },
                        ),
                        DropdownButton(
                          dropdownColor: Theme
                              .of(context)
                              .scaffoldBackgroundColor,
                          itemHeight: 60,
                          hint: (controller.selectedCondition ?? 'Select Condition')
                              .text
                              .headline4(context)
                              .make(),
                          isExpanded: true,
                          iconSize: 30.0,
                          style: Theme
                              .of(context)
                              .textTheme
                              .headline4,
                          value: controller.selectedCondition,
                          items: controller.conditionModel?.itemConditions?.map(
                                (val) {
                              return DropdownMenuItem<String>(
                                value: val.id.toString(),
                                child: val.condition
                                    .toString()
                                    .text
                                    .headline4(context)
                                    .make(),
                              );
                            },
                          ).toList(),
                          onChanged: (val) {
                            controller.changedCondition(val);
                          },
                        ),
                        DropdownButton(
                          dropdownColor: Theme
                              .of(context)
                              .scaffoldBackgroundColor,
                          itemHeight: 60,
                          hint: (controller.selectedPrice ?? 'Select Price')
                              .text
                              .headline4(context)
                              .make(),
                          isExpanded: true,
                          iconSize: 30.0,
                          style: Theme
                              .of(context)
                              .textTheme
                              .headline4,
                          value: controller.selectedPrice,
                          items: controller.priceTypeModel?.priceTypes?.map(
                                (val) {
                              return DropdownMenuItem<String>(
                                value: val.id.toString(),
                                child: val.pricetypes
                                    .toString()
                                    .text
                                    .headline4(context)
                                    .make(),
                              );
                            },
                          ).toList(),
                          onChanged: (val) {
                            controller.changedPrice(val);
                          },
                        ),
                        Card(
                            elevation: 0.3,
                            child: TextFormField(
                              controller: controller.priceController,
                              validator: Validation().priceValidation,
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              maxLength: 10,
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .headline4,
                              decoration: InputDecoration(
                                errorStyle: const TextStyle(
                                  fontSize: 12,
                                ),
                                border: InputBorder.none,
                                counterStyle: Theme
                                    .of(context)
                                    .textTheme
                                    .headline4
                                    ?.copyWith(fontSize: 12),
                                hintText: "Enter Price",
                              ),
                            )).pSymmetric(v: 15),
                        DropdownButton(
                          dropdownColor: Theme
                              .of(context)
                              .scaffoldBackgroundColor,
                          itemHeight: 60,
                          hint: (controller.selectedDeal ?? 'Select Deal')
                              .text
                              .headline4(context)
                              .make(),
                          isExpanded: true,
                          iconSize: 30.0,
                          style: Theme
                              .of(context)
                              .textTheme
                              .headline4,
                          value: controller.selectedDeal,
                          items: controller.dealsModel?.deals?.map(
                                (val) {
                              return DropdownMenuItem<String>(
                                value: val.id.toString(),
                                child: val.dealoption
                                    .toString()
                                    .text
                                    .headline4(context)
                                    .make(),
                              );
                            },
                          ).toList(),
                          onChanged: (val) {
                            controller.changedDeal(val);
                          },
                        ),
                        DropdownButton(
                          dropdownColor: Theme
                              .of(context)
                              .scaffoldBackgroundColor,
                          itemHeight: 60,
                          hint: (controller.selectedCountry ?? 'Select Country')
                              .text
                              .headline4(context)
                              .make(),
                          isExpanded: true,
                          iconSize: 30.0,
                          style: Theme
                              .of(context)
                              .textTheme
                              .headline4,
                          value: controller.selectedCountry,
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
                          onChanged: (val) {
                            controller.changedCountry(val);
                          },
                        ),
                        Card(
                            elevation: 0.3,
                            child: TextFormField(
                              controller: controller.addressController,
                              validator: Validation().addressValidation,
                              maxLength: 250,
                              maxLines: 4,
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .headline4,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                  errorStyle: const TextStyle(
                                    fontSize: 12,
                                  ),
                                counterStyle: Theme
                                    .of(context)
                                    .textTheme
                                    .headline4
                                    ?.copyWith(fontSize: 12),
                                hintText: "Enter Address",
                              ),
                            )).pSymmetric(v: 15),
                        Card(
                            elevation: 0.3,
                            child: TextFormField(
                              controller: controller.phoneNumberController,
                              validator: Validation().whatsUpNumberValidation,
                              maxLength: 20,
                              maxLines: 1,
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .headline4,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                  errorStyle: const TextStyle(
                                    fontSize: 12,
                                  ),
                                counterStyle: Theme
                                    .of(context)
                                    .textTheme
                                    .headline4
                                    ?.copyWith(fontSize: 12),
                                hintText: "What's App Number",
                              ),
                            )).pSymmetric(v: 15),
                        Card(
                            elevation: 0.3,
                            child: TextFormField(
                              controller: controller.brandController,
                              validator: Validation().brandValidation,
                              maxLength: 50,
                              maxLines: 1,
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .headline4,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                counterStyle: Theme
                                    .of(context)
                                    .textTheme
                                    .headline4
                                    ?.copyWith(fontSize: 12),
                  errorStyle: const TextStyle(
                  fontSize: 12,
                  ),
                                hintText: "Enter Brand",
                              ),
                            )).pSymmetric(v: 15),
                        Card(
                            elevation: 0.3,
                            child: TextFormField(
                              controller: controller.brandDescriptionController,
                              validator: Validation().brandDescriptionValidation,
                              maxLength: 1000,
                              maxLines: 4,
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .headline4,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                counterStyle: Theme
                                    .of(context)
                                    .textTheme
                                    .headline4
                                    ?.copyWith(fontSize: 12),
                                hintText: "Enter Brand Description",
                                  errorStyle: const TextStyle(
                                    fontSize: 12,
                                  ),
                              ),
                            )).pSymmetric(v: 15),
                        // DropdownButton(
                        //   dropdownColor: Theme
                        //       .of(context)
                        //       .scaffoldBackgroundColor,
                        //   itemHeight: 60,
                        //   hint: (controller.selectedShop ?? 'Select Shop')
                        //       .text
                        //       .headline4(context)
                        //       .make(),
                        //   isExpanded: true,
                        //   iconSize: 30.0,
                        //   style: Theme
                        //       .of(context)
                        //       .textTheme
                        //       .headline4,
                        //   value: controller.selectedShop,
                        //   items: controller.shopList.map(
                        //         (val) {
                        //       return DropdownMenuItem<String>(
                        //         value: val.id.toString(),
                        //         child: val.name
                        //             .toString()
                        //             .text
                        //             .headline4(context)
                        //             .make(),
                        //       );
                        //     },
                        //   ).toList(),
                        //   onChanged: (val) {
                        //     controller.changedShop(val);
                        //   },
                        // ),
                        // DropdownButton(
                        //   dropdownColor: Theme
                        //       .of(context)
                        //       .scaffoldBackgroundColor,
                        //   itemHeight: 60,
                        //   hint: (controller.selectedFeatured ?? 'Select Featured')
                        //       .text
                        //       .headline4(context)
                        //       .make(),
                        //   isExpanded: true,
                        //   iconSize: 30.0,
                        //   style: Theme
                        //       .of(context)
                        //       .textTheme
                        //       .headline4,
                        //   value: controller.selectedFeatured,
                        //   items: controller.featuredList.map(
                        //         (val) {
                        //       return DropdownMenuItem<String>(
                        //         value: val.id.toString(),
                        //         child: val.name
                        //             .toString()
                        //             .text
                        //             .headline4(context)
                        //             .make(),
                        //       );
                        //     },
                        //   ).toList(),
                        //   onChanged: (val) {
                        //     controller.changedFeatured(val);
                        //   },
                        // ),
                        DropdownButton(
                          dropdownColor: Theme
                              .of(context)
                              .scaffoldBackgroundColor,
                          itemHeight: 60,
                          hint: (controller.selectedAuction ?? 'Select Auction')
                              .text
                              .headline4(context)
                              .make(),
                          value: controller.selectedAuction,
                          isExpanded: true,
                          iconSize: 30.0,
                          style: Theme
                              .of(context)
                              .textTheme
                              .headline4,
                          items: controller.auctionList.map(
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
                          onChanged: (val) {
                            controller.changedAuction(val);
                          },
                        ),


                      controller.selectedAuction == '1' ?
                           GestureDetector(
                        onTap: () {
                          controller.selectDate(context);
                        },
                        child: Container(
                            padding: const EdgeInsets.only(bottom: 12),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                    color: Colors.grey.withOpacity(0.8)),
                              ),
                            ),
                            margin: const EdgeInsets.only(right: 12, top: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment
                                  .spaceBetween,
                              children: [
                                (controller.selectedDate == null
                                    ? "Auction End Date"
                                    : controller.auctionDate!).text
                                    .headline4(context).make(),
                                const Icon(Icons.calendar_today_sharp),
                              ],
                            )


                        ),
                      )
                          : const SizedBox.shrink(),

                        Card(
                            elevation: 0.3,
                            child: TextFormField(
                              controller: controller.address1Controller,
                              validator: Validation().highlightValidation,
                              maxLength: 1000,
                              maxLines: 4,
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .headline4,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                  errorStyle: const TextStyle(
                                    fontSize: 12,
                                  ),
                                counterStyle: Theme
                                    .of(context)
                                    .textTheme
                                    .headline4
                                    ?.copyWith(fontSize: 12),
                                hintText: "Enter Highlight",
                              ),
                            )).pSymmetric(v: 15),
                        ElevatedButton(
                          onPressed: () {
                            controller.addNewListing(context);
                          },
                          child: "Add Listing".text.make(),
                        ).marginOnly(top: 20),
                      ],
                    ),
                  ),
                  if(controller.loading)...{
                    const LoadingIndicator(),
                  }
                ],
              );
            }),
      )
          .box
          .margin(const EdgeInsets.symmetric(horizontal: 15, vertical: 15))
          .make(),
    );
  }
}

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:sparebboxx/model/auction_model.dart';
import 'package:sparebboxx/model/categories_model.dart';
import 'package:sparebboxx/model/condition_model.dart';
import 'package:sparebboxx/model/country_model.dart';
import 'package:sparebboxx/model/deals_model.dart';
import 'package:sparebboxx/model/featured_model.dart';
import 'package:sparebboxx/model/get_type_model.dart';
import 'package:sparebboxx/model/price_type_model.dart';
import 'package:sparebboxx/model/shop_model.dart';
import 'package:sparebboxx/service/add_new_listing_service.dart';
import 'package:sparebboxx/utils/constant.dart';
import 'package:sparebboxx/view/home/home_controller.dart';


class AddNewListingController extends GetxController with StateMixin<List<http.Response>>{

  final AddNewListingService _addNewListingServices = AddNewListingService();

  HomeController controller = Get.find<HomeController>();

  final GlobalKey<FormState> form=GlobalKey<FormState>();



  TextEditingController titleController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController brandController = TextEditingController();
  TextEditingController brandDescriptionController = TextEditingController();
  TextEditingController address1Controller = TextEditingController();




  final List<File> image = [];

  CategoriesModel? categoriesModel;
  TypeModel? typeModel;
  ConditionModel? conditionModel;
  PriceTypeModel? priceTypeModel;
  DealsModel? dealsModel;
  CountryModel? countryModel;

  String? selectedCategory;
  String? selectedType;
  String?  selectedCondition;
  String?  selectedPrice;
  String?  selectedDeal;
  String?  selectedCountry;
  String?  selectedAuction;

  bool loading=false;

  List<ShopModel> shopList= [
    ShopModel(id: 0,name: "No"),
    ShopModel(id: 1,name: "Yes"),
  ];
  List<FeaturedModel> featuredList= [
    FeaturedModel(id: 0,name: "No"),
    FeaturedModel(id: 1,name: "Yes"),
  ];
  List<AuctionModel> auctionList= [
    AuctionModel(id: 0,name: "No"),
    AuctionModel(id: 1,name: "Yes"),
  ];


  @override
  void onInit() {
    super.onInit();
    listingApi();
  }



  addNewListing(context) async{
    if (form.currentState!.validate()) {
      if (selectedCategory == null) {
        snackBar(subtitle: "Please Select Category");
      }
      else if (selectedType == null) {
        snackBar(subtitle: "Please Select Type");
      }
      else if (selectedCondition == null) {
        snackBar(subtitle: "Please Select Condition");
      }
      else if (selectedPrice == null) {
        snackBar(subtitle: "Please Select Price");
      }
      else if (selectedDeal == null) {
        snackBar(subtitle: "Please Select Deal");
      }
      else if (selectedCountry == null) {
        snackBar(subtitle: "Please Select Country");
      }
      else if (selectedAuction == null) {
        snackBar(subtitle: "Please Select Auction");
      }
      else if (image.isEmpty) {
        snackBar(subtitle: "Please Select Image");
      }
      else {
        try {
          loading=true;
          update();
          await _addNewListingServices.addNewListingService(
              title: titleController.text.trim(),
              type_id: selectedType!,
              category_id: selectedCategory!,
              item_id: selectedCondition!,
              pricetype_id: selectedPrice!,
              price: priceController.text.trim(),
              deal_id: selectedDeal!,
              country_id: selectedCountry!,
              address: addressController.text.trim(),
              Whatsapp_number: phoneNumberController.text.trim(),
              brand: brandController.text.trim(),
              description: brandDescriptionController.text.trim(),
              is_shop: "0",
              auction: selectedAuction!,
              auction_end: selectedAuction == "1" ? auctionDate.toString() : "",
              highlight: address1Controller.text.trim(),
              is_featured: "0",
              imageList: image);

           await  clearPage();
           update();
           controller.onStarted();
          loading=false;
          update();
           Get.snackbar("Successfully", "New list add Successfully");
        } catch(e){
          loading=false;
          update();
          snackBarTop(subtitle: e.toString());
        }
      }
    }
  }


  listingApi() async {
    try {
      List<http.Response> response = await _addNewListingServices
          .initialApis();
      categoriesModel = categoriesModelFromJson(response[0].body);
      typeModel = typeModelFromJson(response[1].body);
      conditionModel = conditionModelFromJson(response[2].body);
      priceTypeModel = priceTypeModelFromJson(response[3].body);
      dealsModel = dealsModelFromJson(response[4].body);
      countryModel = countryModelFromJson(response[5].body);
    } on Exception catch (err) {
      snackBar(subtitle: err.toString());
    } catch (err) {
      snackBar(subtitle: err.toString());
    }

    update();
  }



  changedCategory(val){
    selectedCategory=val;
    update();
  }
  changedType(val){
    selectedType=val;
    update();
  }
  changedCondition(val){
    selectedCondition=val;
    update();
  }
  changedPrice(val){
    selectedPrice=val;
    update();
  }
  changedDeal(val){
    selectedDeal=val;
    update();
  }
  changedCountry(val){
    selectedCountry=val;
    update();
  }

  changedAuction(val){
    selectedAuction=val;
    update();
  }




  chooseImage() async {
    var pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    image.add(File(pickedFile!.path));
    if (pickedFile.path == null) retrieveLostData();
    update();
  }

  Future<void> retrieveLostData() async {
    final LostData response = await ImagePicker().getLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      image.add(File(response.file!.path));
    } else {
      print(response.file);
    }
  }

  DateTime? selectedDate;
  // var dob;
  String? auctionDate;

  Future selectDate(BuildContext context) async {
    selectedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1980),
        lastDate: DateTime(2050),
        builder: (BuildContext? context, Widget? child) {
          return Theme(
            data: ThemeData.light().copyWith(
              primaryColor: kPrimary,
              colorScheme: const ColorScheme.light(primary: kPrimary),
              buttonTheme: const ButtonThemeData(
                  textTheme: ButtonTextTheme.primary
              ),
            ),
            child: child!,
          );
        });
    DateTime dateTime = DateTime.now();
    auctionDate =  selectedDate!.toString().split(" ").first +" "+  dateTime.toString().split(" ").last;
    update();
  }



  clearPage() {
    titleController.clear();
    priceController.clear();
    addressController.clear();
    phoneNumberController.clear();
    brandController.clear();
    brandDescriptionController.clear();
    address1Controller.clear();
    image.clear();
    selectedCategory = null;
    selectedType = null;
    selectedCondition = null;
    selectedPrice = null;
    selectedDeal = null;
    selectedCountry = null;
    selectedAuction = null;
  }

}
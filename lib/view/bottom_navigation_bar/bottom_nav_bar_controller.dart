import 'package:get/get.dart';
import 'package:sparebboxx/hive_storage/mobile_storage.dart';
import 'package:sparebboxx/main.dart';
import 'package:sparebboxx/view/add_new_listing/add_new_listing_screen.dart';
import 'package:sparebboxx/view/home/home_screen.dart';
import 'package:sparebboxx/view/message/chat_head_screen.dart';
import 'package:sparebboxx/view/search/search_screen.dart';
import 'package:sparebboxx/view/user_profile/user_profile_screen.dart';
import 'package:sparebboxx/widget/without_login_widget.dart';

class BottomNavBarController extends GetxController {
  int currentIndex = 0;

  MobileStorage? mobileStorage= box?.get("userData");

  List li=[
    HomeScreen(),
    SearchScreen(),
    AddNewListingScreen(),
    MessageScreen(),
    const UserProfileScreen(),
  ];


  @override
  void onInit() {
    change();
    update();
    super.onInit();
  }

  selected(int index) {
    currentIndex = index;
    change();
    update();
  }

  change(){
    if(currentIndex ==2){
      if(mobileStorage?.token==null){
        li[2]= const WithoutLoginScreen();
      }
    }
    if(currentIndex ==3){
      if(mobileStorage?.token==null){
        li[3]= const WithoutLoginScreen();
      }
    }
    if(currentIndex ==4){
      if(mobileStorage?.token==null){
        li[4]= const WithoutLoginScreen();
      }
    }
  }
}

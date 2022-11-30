import 'package:get/get.dart';
import 'package:sparebboxx/view/add_new_listing/add_new_listing_controller.dart';
import 'package:sparebboxx/view/categories_listing/categories_show_listing_controller.dart';
import 'package:sparebboxx/view/change_password/change_password_controller.dart';
import 'package:sparebboxx/view/detail/detail_controller.dart';
import 'package:sparebboxx/view/detail/userPosts/userpost_controller.dart';
import 'package:sparebboxx/view/edit_profile/edit_profile_controller.dart';
import 'package:sparebboxx/view/forgot_password/forgot_password_controller.dart';
import 'package:sparebboxx/view/home/home_controller.dart';
import 'package:sparebboxx/view/home/viewbrand/viewbrand_controller.dart';
import 'package:sparebboxx/view/login/login_controller.dart';
import 'package:sparebboxx/view/message/chat_controller.dart';
import 'package:sparebboxx/view/notifitcaition_1/notification_1_controller.dart';
import 'package:sparebboxx/view/onboarding/on_boarding_controller.dart';
import 'package:sparebboxx/view/search/search_controller.dart';
import 'package:sparebboxx/view/setting/setting_controller.dart';
import 'package:sparebboxx/view/signup/signup_controller.dart';
import 'package:sparebboxx/view/support/support_controller.dart';
import 'package:sparebboxx/view/view_profile/view_profile_controller.dart';

class DataBinding implements Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => OnBoardingController(),fenix: true);
    Get.lazyPut(() => LoginController(),fenix: true);
    Get.lazyPut(() => SignUpController(),fenix: true);
    Get.lazyPut(() => HomeController(),fenix: true);
    Get.lazyPut(() => CategoriesShowController(),fenix: true);
    Get.lazyPut(() => ChatController(),fenix: true);
    Get.lazyPut(() => DetailController(),fenix: true);
    Get.lazyPut(() => AddNewListingController(),fenix: true);
    Get.lazyPut(() => SearchController(),fenix: true);
    Get.lazyPut(() => ForgotPasswordController(),fenix: true);
    Get.lazyPut(() => EditProfileController(),fenix: true);
    Get.lazyPut(() => SupportController(),fenix: true);
    Get.lazyPut(() => SettingController(),fenix: true);
    Get.lazyPut(() => NotificationController(),fenix: true);
    Get.lazyPut(() => UserListingController(),fenix: true);
    Get.lazyPut(() => ChangePasswordController(),fenix: true);
    Get.lazyPut(() => UserPostController(),fenix: true);
    Get.lazyPut(() => ViewBrandController(),fenix: true);
  }
}

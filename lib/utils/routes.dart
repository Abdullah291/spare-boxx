import 'package:get/get.dart';
import 'package:sparebboxx/view/add_new_listing/add_new_listing_screen.dart';
import 'package:sparebboxx/view/bottom_navigation_bar/bottom_nav_bar_screen.dart';
import 'package:sparebboxx/view/change_password/change_password_screen.dart';
import 'package:sparebboxx/view/edit_profile/edit_profile_screen.dart';
import 'package:sparebboxx/view/forgot_password/forgot_password_screen.dart';
import 'package:sparebboxx/view/home/home_screen.dart';
import 'package:sparebboxx/view/login/login_screen.dart';
import 'package:sparebboxx/view/message/chat_head_screen.dart';
import 'package:sparebboxx/view/notifitcaition_1/notification_1_screen.dart';
import 'package:sparebboxx/view/onboarding/on_boarding_screen.dart';
import 'package:sparebboxx/view/setting/setting_screen.dart';
import 'package:sparebboxx/view/signup/signup_1/signup_1_screen.dart';
import 'package:sparebboxx/view/signup/signup_2/signup_2_screen.dart';
import 'package:sparebboxx/view/support/support_screen.dart';
import 'package:sparebboxx/view/user_profile/user_profile_screen.dart';
import 'package:sparebboxx/view/view_profile/view_profile_screen.dart';

class Routes {
  static const String onBoardingScreen = '/on_boarding_screen';
  static const String signUp1Screen = '/signup_1_screen';
  static const String signUp2Screen = '/signup_2_screen';
  static const String loginScreen = '/login_screen';
  static const String forgotPasswordScreen = '/forgot_password_screen';
  static const String changePasswordScreen = '/change_password_screen';
  static const String bottomNavBarScreen = '/bottom_nav_bar_screen';
  static const String userProfileScreen = '/user_profile_screen';
  static const String editProfileScreen = '/edit_profile_screen';
  static const String supportScreen = '/support_screen';
  static const String settingScreen = '/setting_screen';
  static const String viewProfileScreen = '/view_profile_screen';
  static const String homeScreen = '/home_screen';
  static const String notification1Screen = '/notification_1_screen';
  static const String messageScreen = '/message_screen';
  static const String detailScreen = '/detail_screen';
  static const String addListingScreen = '/add_new_listing_screen';

  static List<GetPage>? routes = <GetPage>[
    GetPage(
      name: onBoardingScreen,
      page: () => const OnBoardingScreen(),
    ),
    GetPage(
      name: signUp1Screen,
      page: () => SignUp1Screen(),
    ),
    GetPage(
      name: signUp2Screen,
      page: () => SignUp2Screen(),
    ),
    GetPage(
      name: loginScreen,
      page: () => LoginScreen(),
    ),
    GetPage(
      name: forgotPasswordScreen,
      page: () => ForgotPasswordScreen(),
    ),
    GetPage(
      name: changePasswordScreen,
      page: () => ChangePasswordScreen(),
    ),
    GetPage(
      name: bottomNavBarScreen,
      page: () => const BottomNavBarScreen(),
    ),
    GetPage(
      name: userProfileScreen,
      page: () => const UserProfileScreen(),
    ),
    GetPage(
      name: editProfileScreen,
      page: () => const EditProfileScreen(),
    ),
    GetPage(
      name: supportScreen,
      page: () => SupportScreen(),
    ),
    GetPage(
      name: settingScreen,
      page: () => const SettingScreen(),
    ),
    GetPage(
      name: viewProfileScreen,
      page: () => ViewProfileScreen(),
    ),
    GetPage(
      name: homeScreen,
      page: () => HomeScreen(),
    ),
    GetPage(
      name: notification1Screen,
      page: () => Notification1Screen(),
    ),
    GetPage(
      name: messageScreen,
      page: () => MessageScreen(),
    ),
    GetPage(
      name: addListingScreen,
      page: () => AddNewListingScreen(),
    ),
  ];
}

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'on_boarding_model.dart';

class OnBoardingController extends GetxController {
  RxInt selectedPageIndex = 0.obs;
  PageController pageController = PageController();

  forwardAction() {
    pageController.nextPage(
        duration: 300.milliseconds, curve: Curves.slowMiddle);
  }

  skipPage() {
    pageController.jumpToPage(2);
  }

  backPage() {
    pageController.jumpToPage(0);
  }

  List<OnBoardingModel> onBodyList = [
    OnBoardingModel(
      image: "assets/feature 1@2x 1.png",
      title: "Quick and Easy",
      description: "Find the best deals in your neighborhood",
    ),
    OnBoardingModel(
      image: "assets/feature 2@2x 1.png",
      title: "Meetup or Get Delivered",
      description: "Selling your stuff is simple and fast",
    ),
    OnBoardingModel(
      image: "assets/feature 3@2x 1.png",
      title: "Buy & Sell",
      description:
          "Spare Boxx is the best marketplace that gives you the chance to buy and sell anything quickly and easily",
    ),
  ].obs;

  List<OnBoardingModel> get getOnBodyList => onBodyList;
}

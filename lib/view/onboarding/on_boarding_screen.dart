import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sparebboxx/utils/constant.dart';
import 'package:sparebboxx/view/bottom_navigation_bar/bottom_nav_bar_screen.dart';
import 'package:sparebboxx/view/login/login_screen.dart';
import 'package:sparebboxx/view/onboarding/on_boarding_controller.dart';
import 'package:sparebboxx/view/onboarding/on_boarding_model.dart';
import 'package:sparebboxx/view/signup/signup_1/signup_1_screen.dart';
import 'package:velocity_x/velocity_x.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetX<OnBoardingController>(
          init: OnBoardingController(),
          builder: (controller) {
            return Stack(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: PageView.builder(
                          pageSnapping: true,
                          controller: controller.pageController,
                          onPageChanged: controller.selectedPageIndex,
                          itemCount: controller.getOnBodyList.length,
                          itemBuilder: (context, index) {
                            OnBoardingModel om = controller.onBodyList[index];
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                SizedBox(
                                  width: 262.w,
                                  height: 253.h,
                                  child: Image.asset(
                                    om.image!,
                                    fit: BoxFit.fill,
                                  ),
                                ).marginOnly(top: 30),
                                om.title!.text.headline1(context).make(),
                                om.description!.text
                                    .headline2(context)
                                    .align(TextAlign.center)
                                    .make()
                                    .marginSymmetric(horizontal: 20),
                              ],
                            );
                          }),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                          controller.getOnBodyList.length,
                          (index) => Container(
                                margin:  const   EdgeInsets.only(right: 8),
                                width:
                                    controller.selectedPageIndex == index ? 25 : 10,
                                height: 5,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color: controller.selectedPageIndex == index
                                      ? Colors.red
                                      : Colors.red.withOpacity(0.4),
                                ),
                              )),
                    ).marginOnly(bottom: Get.height * 0.1),
                    controller.selectedPageIndex == 2
                        ? "Welcome, let’s get started!"
                            .text
                            .headline2(context)
                            .bold
                            .make()
                        : "".text.make(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MaterialButton(
                          elevation: 0,
                          height: 50.h,
                          minWidth: 145.w,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          color: controller.selectedPageIndex == 2
                              ? kButtonGrey
                              : kButtonGrey2,
                          onPressed: () {
                            if (controller.selectedPageIndex == 0) {
                              controller.skipPage();
                            } else if (controller.selectedPageIndex == 1) {
                              controller.backPage();
                            } else {
                              Get.offAll(LoginScreen());
                            }
                          },
                          child: controller.selectedPageIndex == 0
                              ? "Skip".text.headline5(context).make()
                              : controller.selectedPageIndex == 1
                                  ? "Back".text.headline5(context).make()
                                  : "Login".text.headline5(context).make(),
                        ),
                      const SizedBox(
                          width: 10,
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            fixedSize: Size(145.w, 50.h),
                          ),
                          child: controller.selectedPageIndex == 0
                              ? "Next".text.headline6(context).make()
                              : controller.selectedPageIndex == 1
                                  ? "Next".text.headline6(context).make()
                                  : "Sign Up".text.headline6(context).make(),
                          onPressed: () {
                            if (controller.selectedPageIndex == 0) {
                              controller.forwardAction();
                            } else if (controller.selectedPageIndex == 1) {
                              controller.forwardAction();
                            } else {
                              Get.to(SignUp1Screen());
                            }
                          },
                        ),
                      ],
                    ).marginOnly(bottom: 15, top: 15),
                  ],
                ),
                controller.selectedPageIndex == 2? Positioned(
                  top: 40,
                  right: 0,
                  child: GestureDetector(
                    onTap: (){
                      Get.offAll(const BottomNavBarScreen());
                    },
                    child: "Skip".text.make().paddingSymmetric(horizontal: 25,
                        vertical: 5)
                        .box.leftRounded(value: 100)
                        .color(kButtonGrey2).make(),
                  ),
                ):const SizedBox.shrink(),
              ],
            );
          }),
    );
  }
}

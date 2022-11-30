import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sparebboxx/utils/constant.dart';
import 'package:sparebboxx/utils/assets.dart';
import 'package:sparebboxx/utils/loading_indicator.dart';
import 'package:sparebboxx/utils/validation.dart';
import 'package:sparebboxx/view/forgot_password/forgot_password_screen.dart';
import 'package:sparebboxx/view/login/login_controller.dart';
import 'package:sparebboxx/view/signup/signup_1/signup_1_screen.dart';
import 'package:sparebboxx/widget/boxdecoration_widget.dart';
import 'package:sparebboxx/widget/scrolling_widget.dart';
import 'package:sparebboxx/widget/signup_header_widget.dart';
import 'package:sparebboxx/widget/textfield_heading.dart';
import 'package:sparebboxx/widget/textfield_widget.dart';
import 'package:velocity_x/velocity_x.dart';

import '../bottom_navigation_bar/bottom_nav_bar_screen.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  LoginController controller = Get.find<LoginController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: Get.height,
        width: Get.width,
        child: GetBuilder<LoginController>(
            builder: (logic) {
          return Stack(
            children: [
              Scrolling(
                widget: Form(
                  key: controller.authenticate,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Header1(
                        title: "Log in",
                        subtitle: "Welcome back!",
                      ),
                      DecoratedBoxWidget(
                        widget: Column(
                          children: [
                            const TextFieldHeading(
                              title: "Email",
                            ),
                            TextFieldWidget(
                              controller: controller.email,
                              prefixIcon: emailIcon,
                              hintText: "Enter Email",
                              validator: Validation().emailValidator,
                            ),
                            const TextFieldHeading(
                              title: "Password",
                            ).marginOnly(top: 5),
                            TextFieldWidget(
                              controller: controller.password,
                              prefixIcon: keyIcon,
                              hintText: "********",
                              suffixIcon: eyeIcon,
                              validator: Validation().passValidator,
                            ),
                            GestureDetector(
                              onTap: () {
                                Get.to(ForgotPasswordScreen());
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  "Forgot you password?"
                                      .text
                                      .headline3(context)
                                      .color(kPrimary)
                                      .make()
                                      .marginOnly(top: 15),
                                ],
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                controller.login(context);
                              },
                              child: "Log In".text.make(),
                            ).marginOnly(top: 15, bottom: 10),
                            Wrap(
                              children: [
                                "Don’t have an account? ".text.subtitle2(context)
                                    .make(),
                                GestureDetector(
                                  onTap: () {
                                    Get.to(SignUp1Screen());
                                  },
                                  child: "Sign up"
                                      .text
                                      .headline3(context)
                                      .color(kPrimary)
                                      .make(),
                                )
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 50,
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
              ),
             if(controller.loading)...{
               const LoadingIndicator(),
             }
            ],
          );
        }),
      ),
    );
  }
}

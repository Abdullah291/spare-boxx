import 'package:get/get.dart';
import 'package:sparebboxx/utils/constant.dart';
import 'package:sparebboxx/utils/loading_indicator.dart';
import 'package:sparebboxx/view/signup/signup_controller.dart';
import 'package:sparebboxx/widget/boxdecoration_widget.dart';
import 'package:sparebboxx/widget/numberbox_widget.dart';
import 'package:sparebboxx/widget/scrolling_widget.dart';
import 'package:sparebboxx/widget/signup_header_widget.dart';
import 'package:sparebboxx/widget/textfield_heading.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:flutter/material.dart';
import 'package:dashed_circle/dashed_circle.dart';

class SignUp2Screen extends StatelessWidget {

  SignUpController controller = Get.find<SignUpController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: Get.height,
        width: Get.width,
        child: GetBuilder<SignUpController>(builder: (logic) {
          return Stack(
            children: [
              Scrolling(
                widget: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Header1(
                      title: "Signup",
                      subtitle:
                      "Please enter your details to sign up and create an account.",
                    ),
                    DecoratedBoxWidget(
                      widget: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const NumberBox(
                                number: "1",
                                color: kPrimary,
                                borderColor: kPrimary,
                              ),
                              const Divider(
                                color: kPrimary,
                                thickness: 3,
                              ).box.width(60).make(),
                              const NumberBox(
                                number: "2",
                                color: kTertiary,
                                borderColor: kPrimary,
                              ),
                            ],
                          ),
                          const TextFieldHeading(
                            title: "Choose Your Profile Picture",
                          ).marginSymmetric(vertical: 25),
                          GestureDetector(
                            onTap: () {
                              controller.chooseImage();
                            },
                            child: DashedCircle(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SizedBox(
                                  height: 115,
                                  width: 115,
                                  child: GetBuilder<SignUpController>(
                                      builder: (controller) {
                                        if (controller.image == null) {
                                          return "Select your picture"
                                              .text
                                              .subtitle2(context).align(
                                              TextAlign.center)
                                              .make().centered();
                                        }
                                        else {
                                          return ClipRRect(
                                            borderRadius: BorderRadius.circular(
                                                100),
                                            child: Image.file(
                                              controller.image!, height: 145,
                                              fit: BoxFit.cover,),
                                          );
                                        }
                                      }),
                                ),
                              ),
                              color: kText2Light,
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              controller.signUp2(context);
                            },
                            child: "Sign up".text.make(),
                          ).marginOnly(top: 20),
                        ],
                      ),
                    )
                  ],
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

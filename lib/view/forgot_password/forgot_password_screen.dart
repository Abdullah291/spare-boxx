import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sparebboxx/utils/assets.dart';
import 'package:sparebboxx/utils/loading_indicator.dart';
import 'package:sparebboxx/utils/validation.dart';
import 'package:sparebboxx/view/forgot_password/forgot_password_controller.dart';
import 'package:sparebboxx/widget/boxdecoration_widget.dart';
import 'package:sparebboxx/widget/scrolling_widget.dart';
import 'package:sparebboxx/widget/signup_header_widget.dart';
import 'package:sparebboxx/widget/textfield_heading.dart';
import 'package:sparebboxx/widget/textfield_widget.dart';
import 'package:velocity_x/velocity_x.dart';


class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({Key? key}) : super(key: key);

  ForgotPasswordController controller = Get.find<ForgotPasswordController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: Get.height,
        width: Get.width,
        child: GetBuilder<ForgotPasswordController>(builder: (logic) {
          return Stack(
            children: [
              Scrolling(
                widget: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Header1(
                      title: "Forgot your Password",
                      subtitle: "Please enter your email. We will send a link to your email to reset your password.",
                    ),
                    DecoratedBoxWidget(
                      widget: Column(
                        children: [

                          const TextFieldHeading(title: "Email",),
                          TextFieldWidget(
                            controller: controller.email,
                            prefixIcon: emailIcon, hintText: "Enter Email",
                            validator: Validation().emailValidator,
                          ),


                          ElevatedButton(
                            onPressed: () {
                              controller.forgotPassword(context);
                            }, child: "Send my link".text.make(),).marginOnly(
                            top: 10,),


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


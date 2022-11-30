import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sparebboxx/utils/assets.dart';
import 'package:sparebboxx/utils/loading_indicator.dart';
import 'package:sparebboxx/utils/validation.dart';
import 'package:sparebboxx/view/change_password/change_password_controller.dart';
import 'package:sparebboxx/widget/boxdecoration_widget.dart';
import 'package:sparebboxx/widget/scrolling_widget.dart';
import 'package:sparebboxx/widget/signup_header_widget.dart';
import 'package:sparebboxx/widget/textfield_heading.dart';
import 'package:sparebboxx/widget/textfield_widget.dart';
import 'package:velocity_x/velocity_x.dart';


class ChangePasswordScreen extends StatelessWidget {

  ChangePasswordController controller = Get.find<ChangePasswordController>();

  ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: Get.height,
        width: Get.width,
        child: Stack(
          children: [
            Scrolling(
              widget: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Header1(
                    title: "Change password",
                    subtitle: "Please set a new and strong password",
                  ),
                  DecoratedBoxWidget(
                    widget: Form(
                      key: controller.passwordValidate,
                      child: Column(
                        children: [
                          const TextFieldHeading(title: "Old Password",),
                          TextFieldWidget(controller: controller.oldPassword,prefixIcon: keyIcon,validator: Validation().passValidator,hintText: "********",suffixIcon: eyeIcon,),
                          const TextFieldHeading(title: "New Password",).marginOnly(top: 5),
                          TextFieldWidget(controller: controller.password,prefixIcon: keyIcon,validator: Validation().passValidator,hintText: "********",suffixIcon: eyeIcon,),
                          const TextFieldHeading(title: "Confirm Password",).marginOnly(top: 5),
                          TextFieldWidget(controller: controller.passwordConfirmation,prefixIcon: keyIcon,validator: Validation().passValidator,hintText: "********",suffixIcon: eyeIcon,),

                          ElevatedButton(
                            onPressed: (){
                              controller.changePassword();
                            }, child: "Confirm".text.make(),).marginOnly(top: 10,),


                        ],
                      ),
                    ),
                  )

                ],
              ),
            ),
            if(controller.loading)...{
              const LoadingIndicator(),
            }
          ],
        ),
      ),
    );
  }
}


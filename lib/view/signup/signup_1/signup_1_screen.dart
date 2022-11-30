import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sparebboxx/utils/constant.dart';
import 'package:sparebboxx/utils/assets.dart';
import 'package:sparebboxx/utils/validation.dart';
import 'package:sparebboxx/view/add_new_listing/add_new_listing_controller.dart';
import 'package:sparebboxx/view/signup/signup_controller.dart';
import 'package:sparebboxx/widget/boxdecoration_widget.dart';
import 'package:sparebboxx/widget/numberbox_widget.dart';
import 'package:sparebboxx/widget/scrolling_widget.dart';
import 'package:sparebboxx/widget/signup_header_widget.dart';
import 'package:sparebboxx/widget/textfield_heading.dart';
import 'package:sparebboxx/widget/textfield_widget.dart';
import 'package:velocity_x/velocity_x.dart';

class SignUp1Screen extends StatelessWidget {

  AddNewListingController addNewListingController = Get.find<
      AddNewListingController>();
  SignUpController signUpController = Get.find<SignUpController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scrolling(
        widget: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Header1(
              title: "Signup",
              subtitle:
              "Please enter your details to sign up and create an account.",
            ),
            Form(
              key: signUpController.register,
              child: DecoratedBoxWidget(
                widget: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const NumberBox(
                          number: "1",
                          color: kTertiary,
                          borderColor: kPrimary,
                        ),
                        const Divider(
                          color: kPrimary,
                          thickness: 3,
                        ).box.width(60).make(),
                        const NumberBox(
                          number: "2",
                          color: kTertiary,
                          borderColor: kTertiary,
                        ),
                      ],
                    ).marginOnly(bottom: 20),
                    const TextFieldHeading(
                      title: "Your name",
                    ),
                    TextFieldWidget(
                      controller: signUpController.yourName,
                      prefixIcon: personIcon,
                      hintText: "Enter your Name",
                      validator: Validation().nameValidator,
                    ),
                    const TextFieldHeading(
                      title: "Phone number",
                    ),
                    TextFieldWidget(
                      controller: signUpController.phoneNumber,
                      prefixIcon: phoneIcon,
                      hintText: "Enter your Phone Number",
                      validator: Validation().phoneValidation,
                    ),
                    const TextFieldHeading(
                      title: "Email",
                    ),
                    TextFieldWidget(
                      controller: signUpController.email,
                      prefixIcon: emailIcon,
                      hintText: "Enter your Email",
                      validator: Validation().emailValidator,
                    ),
                    const TextFieldHeading(
                      title: "Password",
                    ),
                    TextFieldWidget(
                      controller: signUpController.password,
                      prefixIcon: keyIcon,
                      hintText: "Enter your Password",
                      validator: Validation().passValidator,
                    ),
                    const TextFieldHeading(
                      title: "Confirm Password",
                    ),
                    TextFieldWidget(
                      controller: signUpController.confirmPassword,
                      prefixIcon: keyIcon,
                      hintText: "Enter your Confirm Password",
                      validator: Validation().passValidator,
                    ),
                    GetBuilder<AddNewListingController>(builder: (logic) {
                      return DropdownButton(
                        dropdownColor: Theme
                            .of(context)
                            .scaffoldBackgroundColor,
                        itemHeight: 60,
                        hint: (signUpController.selectedCountry ?? 'Select Country')
                            .text
                            .headline4(context)
                            .make(),
                        isExpanded: true,
                        iconSize: 30.0,
                        style: Theme
                            .of(context)
                            .textTheme
                            .headline4,
                        value: signUpController.selectedCountry,
                        items: addNewListingController.countryModel?.data?.map(
                              (val) {
                            return DropdownMenuItem<String>(
                              value: val.id.toString(),
                              child: val.name
                                  .toString()
                                  .text
                                  .headline4(context)
                                  .make(),
                            );
                          },
                        ).toList(),
                        onChanged: (val) {
                          signUpController.changedCountry(val);
                        },
                      );
                    }),
                    ElevatedButton(
                      onPressed: () {
                        signUpController.signUp1();
                      },
                      child: "Next".text.make(),
                    ).marginOnly(
                      top: 15,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ).pOnly(top: 15),
      ),
    );
  }
}

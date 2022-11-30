import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sparebboxx/utils/constant.dart';
import 'package:sparebboxx/view/login/login_screen.dart';
import 'package:velocity_x/velocity_x.dart';



class WithoutLoginScreen extends StatelessWidget {
  const WithoutLoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
       width: Get.width,
       child: Column(
         crossAxisAlignment: CrossAxisAlignment.center,
         children: [
           const Spacer(),
           GestureDetector(
               onTap: () {
                 Get.offAll(LoginScreen());
               },
               child: const Icon(Icons.login_outlined,color: kPrimary,size: 30,).box.gray400.p32.roundedFull.make()),
           "Please login to use this feature".text.align(TextAlign.center).headline5(context).make().w(200).marginOnly(top: 15),
           const Spacer(),
           ElevatedButton(
             onPressed: () {
               Get.offAll(LoginScreen());
             },
             child: "Go back to Login".text.make(),
           ).marginOnly(bottom: 30),
         ],
       ),
    );
  }
}

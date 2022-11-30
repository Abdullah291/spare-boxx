import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sparebboxx/utils/assets.dart';
import 'package:sparebboxx/utils/constant.dart';


class BackArrowButton extends StatelessWidget {
   const BackArrowButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Get.back();
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(backIcon,width: 30,color: kPrimary,),
        ],
      ),
    );
  }
}

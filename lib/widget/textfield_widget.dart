import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sparebboxx/utils/constant.dart';
import 'package:velocity_x/velocity_x.dart';

class TextFieldWidget extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final String? prefixIcon;
  final String? suffixIcon;
  final FormFieldValidator<String>? validator;
  final bool readonly;

  const TextFieldWidget(
      {Key? key,
      this.controller,
      this.hintText,
      this.prefixIcon,
      this.suffixIcon,
      this.validator,
      this.readonly=false
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: readonly,
      controller: controller,
      validator: validator,
      cursorColor: kPrimary,
      cursorWidth: 3,
      decoration: InputDecoration(
        prefixIcon: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              "$prefixIcon",
              width: 22,
            ),
          ],
        ),
        suffixIcon: suffixIcon==null ? const SizedBox.shrink(): Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              "$suffixIcon",
              width: 22,
            ),
          ],
        ),
        hintText: hintText,
        enabledBorder: eib,
        focusedBorder: fib,
        hintStyle: const TextStyle(
          color: Color(0xff969696),
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
        errorStyle: const TextStyle(
          fontSize: 12,
        )
      ),
      style: Theme.of(context).textTheme.headline4,
    ).box.margin(const EdgeInsets.only(bottom: 8)).make();
  }
}

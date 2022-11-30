import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sparebboxx/utils/constant.dart';
import 'package:sparebboxx/utils/theme_mode.dart';
import 'package:velocity_x/velocity_x.dart';

class UserProfileListTile extends StatelessWidget {
  final String? leading;
  final String? title;
  final GestureTapCallback? onTap;

  const UserProfileListTile({Key? key, this.leading, this.title, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        children: [
          ListTile(
            tileColor:
                ThemeService().theme == ThemeMode.dark ? Colors.black : white,
            onTap: onTap,
            leading: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
             leading != "" ?  SvgPicture.asset(
                  "$leading",
                  width: 22,
                )  : const FaIcon(FontAwesomeIcons.userEdit,size: 20,color: kPrimary,),
              ],
            ),
            title: title.toString().text.subtitle1(context).make(),
          ),
          if (title != "Log out") ...{
            Container(
              height: 0,
              decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(
                  color: ThemeService().theme == ThemeMode.dark
                      ? kText2Light.withOpacity(0.2)
                      : kText2Light.withOpacity(0.2),
                )),
              ),
            )
          },
        ],
      ),
    );
  }
}

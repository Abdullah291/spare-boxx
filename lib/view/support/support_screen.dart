import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sparebboxx/utils/constant.dart';
import 'package:sparebboxx/utils/assets.dart';
import 'package:sparebboxx/view/support/support_controller.dart';
import 'package:sparebboxx/widget/appbar_widget.dart';
import 'package:sparebboxx/widget/expanded_tiles_widget.dart';
import 'package:sparebboxx/widget/textfield_heading.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:get/get.dart';

class SupportScreen extends StatelessWidget {
  SupportScreen({Key? key}) : super(key: key);

  SupportController controller = Get.find<SupportController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(title: "Support", context: context),
      body: Container(
        margin: const EdgeInsets.only(left: 15, right: 15, bottom: 25),
        child: Column(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SvgPicture.asset(
                  supportIcon,
                  height: Get.height*0.25,
                ),
                const SizedBox(
                  width: 25,
                ),
                "Contact Support"
                    .text
                    .headline6(context)
                    .size(18)
                    .color(kPrimary).align(TextAlign.center)
                    .make(),
              ],
            )
                .box
                .color(kTertiary)
                .p8
                .roundedSM
                .make()
                .marginSymmetric(vertical: 25),
            const TextFieldHeading(
              title: "Frequently asked questions",
            ),
            ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 10),
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                itemCount: controller.supportQuestion.length,
                itemBuilder: (context, index) {
                  Article article = controller.supportQuestion[index];
                  return ExpandedTileWIdget(article: article);
                }),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                    onTap: () async {
                      try {
                        if (await canLaunch(instagramLink)) {
                          launch(instagramLink,
                              forceSafariVC: false,
                              forceWebView: true,
                              enableDomStorage: true,
                              webOnlyWindowName: '_self',
                              enableJavaScript: true);
                        }
                      } catch (e) {
                        print(e);
                      }
                    },
                    child: const FaIcon(
                      FontAwesomeIcons.instagram,
                      size: 30,
                      color: kPrimary,
                    )
                        .pSymmetric(v: 10, h: 15)
                        .box
                        .color(kTertiary)
                        .roundedSM
                        .make()),
                GestureDetector(
                  onTap: () async {
                    try {
                      if (await canLaunch(facebookLink)) {
                        launch(facebookLink,
                            forceSafariVC: false,
                            forceWebView: true,
                            enableDomStorage: true,
                            webOnlyWindowName: '_self',
                            enableJavaScript: true);
                      }
                    } catch (e) {
                      print(e);
                    }
                  },
                  child: const FaIcon(
                    FontAwesomeIcons.facebook,
                    size: 30,
                    color: kPrimary,
                  )
                      .pSymmetric(v: 10, h: 15)
                      .box
                      .color(kTertiary)
                      .roundedSM
                      .make(),
                ),
                const FaIcon(
                  FontAwesomeIcons.whatsapp,
                  size: 30,
                  color: kPrimary,
                ).pSymmetric(v: 10, h: 15).box.color(kTertiary).roundedSM.make()
              ],
            ),
          ],
        ),
      ),
    );
  }
}

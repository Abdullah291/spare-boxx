import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:sparebboxx/hive_storage/mobile_storage.dart';
import 'package:sparebboxx/main.dart';
import 'package:sparebboxx/model/listing_model.dart';
import 'package:sparebboxx/service/api_services.dart';
import 'package:sparebboxx/utils/constant.dart';
import 'package:sparebboxx/view/message/chat_intiat.dart';
import 'package:sparebboxx/view/message/chat_screen.dart';
import 'package:url_launcher/url_launcher.dart';



class FabMenuWidget extends StatelessWidget {

  Listing? am;

  FabMenuWidget({this.am});

  MobileStorage? mobileStorage= box?.get("userData");


  @override
  Widget build(BuildContext context) {
    return FabCircularMenu(
        animationDuration: const Duration(microseconds: 1000),
        fabSize: 55,
        fabOpenColor: kPrimary,
        fabCloseColor: kPrimary,
        fabOpenIcon: const Icon(Icons.contact_phone,color: white,),
        fabCloseIcon: const Icon(Icons.contact_phone,color: white,),
        ringColor: kPrimary,
        fabMargin: const EdgeInsets.only(bottom: 15,right:15),
        ringDiameter:mobileStorage?.token != null? 280.0 : 235,
        ringWidth: 60.0,
        children: <Widget>[

            IconButton(splashColor: white,
              iconSize: 30,
              icon: const Icon(FontAwesomeIcons.comment, color: white,),
              onPressed: () {
                InitiateChat(
                  by: mobileStorage?.email,
                  peerId: am?.email,
                ).now().then((value) async {
                  print("image");
                  Get.to(
                      ChatScreen(
                        roomID: value.roomId,
                        userEmail: am?.email,
                        userImage: "$imageStorageLink2${am?.avatar}",
                        userName: am?.name,
                      ),
                      transition: Transition
                          .leftToRightWithFade);
                });
              },),

          IconButton(splashColor: white,iconSize: 30,icon: const Icon(FontAwesomeIcons.phone,color: white,), onPressed: () async{
            try {String phone = "tel:${am?.phoneNo}";
            if (await canLaunch(phone)) {launch(phone);}
            } catch (e) {print(e);}
          }),
          IconButton(splashColor: white,iconSize: 30,icon: const Icon(FontAwesomeIcons.whatsapp,color: white,), onPressed: () {
          }
          ),

        ]
    );
  }
}

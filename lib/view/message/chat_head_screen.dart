import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:sparebboxx/hive_storage/mobile_storage.dart';
import 'package:sparebboxx/model/userProifleData.dart';
import 'package:sparebboxx/service/api_services.dart';
import 'package:sparebboxx/utils/collection.dart';
import 'package:sparebboxx/view/message/chat_controller.dart';
import 'package:sparebboxx/view/message/chat_screen.dart';
import 'package:sparebboxx/widget/message_counter_box.dart';
import 'package:sparebboxx/widget/network_image_widget.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:flutter/material.dart';
import 'package:sparebboxx/utils/constant.dart';
import 'package:sparebboxx/main.dart';

class MessageScreen extends StatelessWidget {
  MessageScreen({Key? key}) : super(key: key);
  MobileStorage? mobileStorage = box?.get("userData");
  ChatController chatController = Get.find<ChatController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          title: "Message"
              .toString()
              .text
              .headline6(context)
              .color(Theme.of(context).canvasColor)
              .make(),
          centerTitle: true,

          ),
      body: StreamBuilder(
          stream: Collection.chatRoom.where(
              "users", arrayContains: mobileStorage?.email)
              .snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const VxZeroList(length: 10,);
            }
            else if (snapshot.hasData) {
              if (snapshot.data?.docs.isEmpty ==true) {
                return Center(
                  child: "No Message History".text.headline1(context).make(),
                );
              } else {
                return SizedBox(
                  child: ListView.builder(
                      itemCount: snapshot.data?.docs.length,
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      itemBuilder: (context, index) {
                        DocumentSnapshot? data = snapshot.data?.docs[index];
                         chatController.userProfileDataShow(
                            email: data?["peerId"]);
                        return GetBuilder<ChatController>(builder: (logic) {
                          UserDatum? userProfileData = chatController.userProfileData?.userData?[0];
                          print(userProfileData?.name);
                          return Column(
                            children: [
                              ListTile(
                                onTap: () {
                                  Get.to(ChatScreen(
                                    roomID: data?.id,
                                    userEmail: data?["peerId"],
                                    userName: userProfileData?.name ?? "",
                                    userImage: '$imageStorageLink${userProfileData
                                        ?.avatar}',
                                  ));
                                },
                                contentPadding: const EdgeInsets.only(bottom: 0),
                                leading: ClipRRect(
                                    borderRadius: borderRadius,
                                    child: NetworkImageChatHeadWidget(
                                      imageUrl: '$imageStorageLink${userProfileData
                                          ?.avatar}',)
                                ),
                                title: (userProfileData?.name ?? "")
                                    .toString()
                                    .text
                                    .headline5(context)
                                    .make(),
                                subtitle: StreamBuilder(
                                    stream: Collection.chat.where(
                                        "room_id", isEqualTo: data?["roomId"])
                                        .snapshots(),
                                    builder: (context, AsyncSnapshot<
                                        QuerySnapshot> lastMessageSnapshot) {
                                      if(lastMessageSnapshot.data?.docs.isNotEmpty == true){

                                      DocumentSnapshot? lastMessage = lastMessageSnapshot.data?.docs.last;
                                      return lastMessage?['type'] == 1 ? Container(child:(lastMessage?["message".toString()] ?? '').toString()
                                          .text.subtitle2(context).maxLines(1).ellipsis
                                          .make()): Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          const Icon(Icons.image,color: Colors.grey,),
                                          " photo".text.gray500.make(),
                                        ],
                                      );
                                      }
                                     return SizedBox();
                                    }),

                                trailing: StreamBuilder(
                                    stream: Collection.chat
                                        .where("receiver_id",
                                        isEqualTo: mobileStorage?.email)
                                        .where("room_id",
                                        isEqualTo: data?["roomId"])
                                        .where('seen', isEqualTo: false)
                                        .snapshots(),
                                    builder: (context, AsyncSnapshot<
                                        QuerySnapshot> unSeenMessageSnapshot) {
                                      return unSeenMessageSnapshot.hasData
                                          ? unSeenMessageSnapshot.data?.docs.isEmpty == true ? const SizedBox.shrink() : MessageCounterBox(
                                          number: unSeenMessageSnapshot.data?.docs
                                              .length.toString() ?? "")
                                          : const SizedBox.shrink();
                                    }),
                              ),
                              Divider(
                                color: kText3Light.withOpacity(0.4),
                                indent: 15,
                                endIndent: 15,
                              ),
                            ],
                          );
                        }).marginOnly(top: 5);
                      }),
                );
              }
            }
            else {
              return const VxZeroList(length: 10,);
            }
          }),
    );
  }
}


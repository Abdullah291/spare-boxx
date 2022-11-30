import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sparebboxx/hive_storage/mobile_storage.dart';
import 'package:sparebboxx/main.dart';
import 'package:sparebboxx/utils/assets.dart';
import 'package:sparebboxx/utils/collection.dart';
import 'package:sparebboxx/utils/constant.dart';
import 'package:sparebboxx/view/message/chat_controller.dart';
import 'package:sparebboxx/widget/network_image_widget.dart';
import 'package:velocity_x/velocity_x.dart';
import 'chat_widget/chat_bubble.dart';


class ChatScreen extends StatefulWidget {
  String? roomID;
  String? userEmail;
  String? userName;
  String? userImage;

  ChatScreen({this.roomID, this.userEmail, this.userName, this.userImage});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  String? selectedRoomId;
  var listMessage;
   ScrollController scrollController =  ScrollController();
  TextEditingController textController=TextEditingController();
  MobileStorage? mobileStorage = box?.get("userData");

  bool loading=false;

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance?.addPostFrameCallback((_) {
      print("yeah cheez");
      scrollController.jumpTo(5);
    });
    batchUpdate();
    textController = TextEditingController();
  }


  Future<void> batchUpdate() {
    WriteBatch batch = FirebaseFirestore.instance.batch();
    return Collection.chat.get().then((querySnapshot) {
      for (var document in querySnapshot.docs) {
        if (document["receiver_id"] == mobileStorage?.email &&
            document["room_id"] == widget.roomID) {
          batch.update(document.reference, {"seen": true});
        }
      }
      return batch.commit();
    });
  }


  ChatController chatController = Get.find<ChatController>();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    textController.dispose();
  }

  final _controller = ScrollController();

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          toolbarHeight: 70,
          leading: GestureDetector(
            onTap: (){
              if(chatController.image!=null){
                chatController.back();
              }
              else {
                Get.back();
              }
              },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(backIcon,width: 30,color: kPrimary,),
              ],
            ),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: NetworkImageWidget(imageUrl: widget.userImage ?? ""),
              ).w(45).h(45)
                  .backgroundColor(Colors.grey.withOpacity(0.2))
                  .cornerRadius(100)
                  .marginOnly(right: 10),
              Flexible(
                child: Text(
                  widget.userName ?? "",
                  style: const TextStyle(fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 18),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ).marginOnly(right: Get.width * 0.2),
        ),
        body: GetBuilder<ChatController>(
            builder: (logic) {
          return SafeArea(
            child: Stack(
              children: [
                Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                          reverse: true,
                          controller: scrollController,
                          child: StreamBuilder(
                        stream: Collection.chat
                            .where("room_id", isEqualTo: widget.roomID)
                        // .orderBy('created_at', descending: false)
                            .snapshots(),
                        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (!snapshot.hasData) {
                            return Container(margin: const EdgeInsets.only(top: 200), child: SizedBox(
                              width: Get.width,
                              child: Column(
                                children: const [
                                  CircularProgressIndicator(),
                                ],
                              ),
                            ));
                          } else if (snapshot.data!.docs.isEmpty) {
                            return SizedBox(height: Get.height * 0.7,
                                child: const Center(child: Text("No conversation history")));
                          } else {
                            listMessage = snapshot.data?.docs;
                            print(listMessage.length);

                            return ListView.builder(
                              controller: scrollController,
                              shrinkWrap: true,
                              physics: const ClampingScrollPhysics(),
                              padding: const EdgeInsets.all(10.0),
                              itemBuilder: (context, index) =>
                                  chatBubble(index, snapshot.data?.docs[index]),
                              itemCount: snapshot.data?.docs.length,
                              // reverse: false,
                            );
                          }
                        },
                      )),),
                    bottomtextnavigation(),
                  ],
                ),
                if(chatController.image != null)...{
                  Positioned.fill(
                    child: Container(
                      color: Colors.black.withOpacity(0.8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Spacer(),
                          Container(
                            margin: const EdgeInsets.only(top: 20),
                            height: Get.height*0.5,
                            width: Get.width,
                            child: Image.file(
                              chatController.image!, fit: BoxFit.cover,),
                          ),
                          const Spacer(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              InkWell(
                                onTap: () async{
                                    loading=true;
                                    setState(() {});
                                    String? images = await chatController.uploadFile(chatController.image);
                                   await onSendMessage(content: images, type: 2);
                                    loading=false;
                                    setState(() {});
                                },
                                child: const Icon(Icons.send, color: white, size: 20,).box.roundedFull.p12
                                    .color(kPrimary).make(),

                              ).marginAll(10),
                            ],
                          ),


                        ],
                      ),
                    ),
                  ),
                  if(loading)...{
                    Positioned.fill(
                        child: Container(
                          color: Colors.black.withOpacity(0.4),
                          child: Column(
                            children: const [
                              Spacer(),
                              CircularProgressIndicator(),
                              Spacer(),
                            ],
                          ),
                        )
                    )
                  }
                }
              ],
            ),
          );
        }),

      ),
    );
  }

  Widget bottomtextnavigation() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Expanded(
          child: Container(
            padding: EdgeInsets.only(
              left: Get.width * .03,
            ),
            alignment: Alignment.centerLeft,
            decoration: const BoxDecoration(color: Colors.white),
            child: TextField(
              cursorColor: kPrimary,
              textAlign: TextAlign.start,
              controller: textController,
              keyboardType: TextInputType.multiline,
              maxLines: 4,
              minLines: 1,
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(
                      horizontal: Get.width * .03,
                      vertical: Get.height * .02),
                  fillColor: Colors.white,
                  filled: true,
                  border: InputBorder.none,
                  hintText: "Type your message...",
                  hintStyle: const TextStyle(
                      fontSize: 14
                  ),
                  suffixIcon: InkWell(
                    child: const Icon(Icons.add_circle_outline, color: kPrimary,),
                    onTap: () {
                      chatController.selectImage();
                    },
                  )
              ),
            ),
          ),
        ),
        InkWell(
          onTap: () {
            setState(() {
              onSendMessage(content: textController.text.trim(),type: 1);
            });
          },
          child: const Icon(Icons.send, color: white, size: 20,).box.roundedFull.p12
              .color(kPrimary).make(),

        ).marginAll(5),
      ],
    ).p2();
  }

  Future onSendMessage({required String content,int? type}) async{
    if (content != '' && type== 1 || type==2) {
      var documentReference = Collection.chat.doc(DateTime
          .now()
          .millisecondsSinceEpoch
          .toString());
      textController.clear();
      FirebaseFirestore.instance.runTransaction((transaction) async {
        transaction.set(
          documentReference,
          {
            'message': content,
            'receiver_id': widget.userEmail,
            'sender_id': mobileStorage?.email,
            'room_id': widget.roomID,
            'created_at': DateTime.now().toUtc(),
            'seen': false,
            'type': type,
          },
        );
      });

      chatController.back();
      _controller.animateTo(0.0, duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
    } else {
      snackBarTop(subtitle: 'Nothing to send');
    }
  }

}

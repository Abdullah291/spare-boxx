import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sparebboxx/hive_storage/mobile_storage.dart';
import 'package:sparebboxx/main.dart';
import 'package:sparebboxx/view/message/chat_widget/recieve_chat_bubble.dart';
import 'package:sparebboxx/view/message/chat_widget/send_chat_bubble.dart';


Widget chatBubble(int index, DocumentSnapshot? document,) {
  MobileStorage? mobileStorage= box?.get("userData");
  print(document?['sender_id']);
  if (document?['sender_id'] == mobileStorage?.email) {
// Right (my message)
    return Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          sendChatBubble(
            index,
            document?['message'],
            document?['type'],
            document?['created_at'].toDate(),
          ),
        ]);
  } else {
// Left (peer message)
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        receivedChatBubble(
          index,
          document?['message'],
          document?["sender_id"],
          document?['created_at'].toDate(),
        ),
      ],
    );
  }
}
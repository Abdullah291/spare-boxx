import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sparebboxx/utils/collection.dart';
import 'chat_model.dart';

class InitiateChat {
  final String? by;
  final String? peerId;

  InitiateChat({required this.by,required this.peerId});

  List<ChatRoomModel> chatRooms = <ChatRoomModel>[];

  DocumentSnapshot? myChatRoom;

  Future<ChatRoomModel> now() async{
    QuerySnapshot querySnapshot= await Collection.chatRoom.get();

    for (var element in querySnapshot.docs) {
      chatRooms.add(ChatRoomModel.fromJson(element));
    }

    if(!EmptyList.isTrue(querySnapshot.docs))
    {
      List<ChatRoomModel> roomInfo=
      chatRooms.where((element) =>
      (element.createdBy== by  || element.createdBy == peerId) &&
          (element.peerId== peerId || element.peerId == by)
      ).toList();
      if(EmptyList.isTrue(roomInfo)){
        myChatRoom = await getRoomDoc(by);
        return ChatRoomModel.fromJson(myChatRoom?.data());
      }
      else {
        return roomInfo[0];
      }

    }

    else
    {
      DocumentSnapshot documentSnapshot= await getRoomDoc(by);
      return ChatRoomModel.fromJson(documentSnapshot);
    }
  }

  Future<DocumentSnapshot> getRoomDoc(String? by) async {
    String docId = DateTime.now().millisecondsSinceEpoch.toString();
    ChatRoomModel chatRoomModel = ChatRoomModel(
      createdAt: Timestamp.now(),
      createdBy: by,
      roomId: docId,
      peerId: peerId,
      users: [by, peerId],
    );
    print(chatRoomModel.toJson());
    await Collection.chatRoom.doc(docId).set(chatRoomModel.toJson());
    DocumentSnapshot chatRoomDoc = await Collection.chatRoom.doc(docId).get();
    return chatRoomDoc;
  }


}

class EmptyList {
  static bool isTrue(List list) {
    if (list.isEmpty) {
      return true;
    } else {
      return false;
    }
  }
}
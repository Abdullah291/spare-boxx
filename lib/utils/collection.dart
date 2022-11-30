import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

class Collection {
  static CollectionReference chatRoom = db.collection('ChatRoom');
  static CollectionReference chat = db.collection('Chat');
}





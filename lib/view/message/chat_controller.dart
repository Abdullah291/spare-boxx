import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sparebboxx/model/userProifleData.dart';
import 'package:sparebboxx/service/chat_service.dart';




class ChatController extends GetxController{

  ChatService chatService= ChatService();

  UserProfileData? userProfileData;

  File? image;


  userProfileDataShow({required String? email}) async{
    try {
      userProfileData = await chatService.chatService(email: email ?? "");
      update();
    } catch(e){
      print(e);
    }
  }


  Future selectImage() async{
    XFile? pickedFile= await ImagePicker().pickImage(source: ImageSource.gallery);
    image =  File(pickedFile!.path);
    update();
  }


  Future<String> uploadFile(File? files) async
  {
    String fileUrl;
    FirebaseStorage storage=FirebaseStorage.instance;
    Reference ref;
    ref = storage.ref().child("user/profileImages/${DateTime.now().toString()}");
    UploadTask uploadTask=ref.putFile(files!);
    TaskSnapshot taskSnapshot=await uploadTask;
    String downloadImageUrl=await taskSnapshot.ref.getDownloadURL();
    fileUrl=downloadImageUrl.toString();
    return fileUrl;
  }


  back(){
    image = null;
    update();
  }


}
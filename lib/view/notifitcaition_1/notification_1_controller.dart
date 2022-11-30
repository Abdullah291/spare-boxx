import 'package:get/get.dart';


class NotificationModel{
  final String? image;
  final String? title;
  final String? subtitle;

  NotificationModel({this.image,this.title,this.subtitle});
}



class NotificationController extends GetxController{


  List<NotificationModel>  list= [
    NotificationModel(image: "assets/Rectangle 30.png",title: "Your shopping no #12424 was completed", subtitle: "7 mins ago"),
    NotificationModel(image: "assets/Rectangle 30 (1).png",title: "Janet has arrived!", subtitle: "4 mins ago"),
    NotificationModel(image: "assets/Rectangle 30 (2).png",title: "Get 50% off when rating our service", subtitle: "1/1/2021"),
    NotificationModel(image: "assets/Rectangle 30 (3).png",title: "Your cleaning no #12343 was completed", subtitle: "1/1/2021"),
    NotificationModel(image: "assets/Rectangle 30 (4).png",title: "Now we got new service for your sofa", subtitle: "1/1/2021"),
  ];

}
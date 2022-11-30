import 'package:get/get.dart';



class Article{
  final String? title;
  final String? body;
Article({this.title,this.body});
}


class SupportController extends  GetxController{


  List supportQuestion = [
    Article(title: "Help",body: "If all of our agents are busy Please wait and we will answer your Question as soon as possible"),
  ];

}
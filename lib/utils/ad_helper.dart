
import 'dart:io';

class AdHelper{

  static String banner1UnitId(){
    if(Platform.isAndroid){
      return 'ca-app-pub-5383735004188156/1453962527';
    }
    else{
      return '';
    }
  }

  static String banner2UnitId(){
    if(Platform.isAndroid){
      return 'ca-app-pub-5383735004188156/9687675764';
    }
    else{
      return '';
    }
  }

  static String detailPageInterstitial(){
    if(Platform.isAndroid){
      return 'ca-app-pub-5383735004188156/6897860890';
    }
    else{
      return '';
    }
  }

}
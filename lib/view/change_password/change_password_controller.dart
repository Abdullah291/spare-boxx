import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sparebboxx/hive_storage/mobile_storage.dart';
import 'package:sparebboxx/main.dart';
import 'package:sparebboxx/model/change_password_model.dart';
import 'package:sparebboxx/service/change_password_service.dart';
import 'package:sparebboxx/utils/constant.dart';

class ChangePasswordController extends GetxController{

  ChangePasswordModel? changePasswordModel;
  ChangePasswordService changePasswordService= ChangePasswordService();

  TextEditingController oldPassword= TextEditingController();
  TextEditingController password= TextEditingController();
  TextEditingController passwordConfirmation= TextEditingController();

  MobileStorage? mobileStorage = box?.get("userData");

  bool loading=false;

  final GlobalKey<FormState> passwordValidate=GlobalKey<FormState>();


 Future<void> changePassword() async{
    if (passwordValidate.currentState!.validate()) {
      if (oldPassword.text.isNotEmpty && password.text.isNotEmpty &&
          passwordConfirmation.text.isNotEmpty) {
        if (password.text.trim() == passwordConfirmation.text.trim()) {
          loading = true;
          update();
          try {
            changePasswordModel = await changePasswordService.changePasswordService(
                oldPassword: oldPassword.text.trim(),
                password: password.text.trim(),
                passwordConfirmation: passwordConfirmation.text.trim());
            oldPassword.clear();
            password.clear();
            passwordConfirmation.clear();
            snackBarSuccessfully(subtitle: "Password changed successfully.");
          } on Exception catch (err) {
            snackBar(subtitle: err.toString());
          } catch (err) {
            snackBar(subtitle: err.toString());
          }
          loading = false;
          update();
        }
        else {
          snackBar(subtitle: "Password and confirm password not matched");
        }
      }
    }
  }
}
import 'package:chat_gpt/app/helpers/snack_bar_helpers.dart';
import 'package:chat_gpt/app/routers/app_routes.dart';
import 'package:chat_gpt/data/database/firebase_auththentication.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final FirebaseAuththentication firebaseAuththentication =
      FirebaseAuththentication();

  final TextEditingController emailLoginController = TextEditingController();
  final TextEditingController passwordLoginController = TextEditingController();
  final TextEditingController emailSignUpController = TextEditingController();
  final TextEditingController passwordSignUpController =
      TextEditingController();
  final TextEditingController passwordComfirmController =
      TextEditingController();

  Rx<bool> checkPassLogin = false.obs;
  Rx<bool> checkPassSignUp = false.obs;
  Rx<bool> checkPassComfirm = false.obs;
  bool isLoggedIn = false;
  bool isSignUp = false;


  Future<bool> login() async {
    String email = emailLoginController.text;
    String password = passwordLoginController.text;

    if (email.trim() == "" || password.trim() == "") {
      SnackBarhelpers.showCustomSnackbar(
          title: 'Cảnh báo',
          message: 'Email và mật khẩu không được để trống',
          icon: Icons.warning_amber_rounded,
          colorIcon: Colors.red,
          backgroundColor: Colors.white);
      return false;
    }
    try {
      final user = await firebaseAuththentication.loginWithEmail(
        email: emailLoginController.text.trim(),
        password: passwordLoginController.text.trim(),
      );
      if (user != null) {
        SnackBarhelpers.showCustomSnackbar(
          title: 'Thành công',
          message: 'Đăng nhập thành công',  
          );
        isLoggedIn = true;
        return true;
      }
    } catch (e) {
      SnackBarhelpers.showCustomSnackbar(
          title: 'Lỗi',
          message: 'Đăng nhập thất bại',
          icon: Icons.warning_rounded,
          colorIcon: Colors.red,
          backgroundColor: Colors.white,);
    }
    return false;
  }

  Future<bool> signUp() async {
    String email = emailSignUpController.text;
    String password = passwordSignUpController.text;
    String passwordComfirm = passwordComfirmController.text;
    if (email.trim() == "" || password.trim() == "" || passwordComfirm.trim() == "") {
      SnackBarhelpers.showCustomSnackbar(
          title: 'Lỗi',
          message: 'Email và mật khẩu không được để trống',
          icon: Icons.warning_rounded,
          colorIcon: Colors.red,
          backgroundColor: Colors.white,);
      return false;
    }
    if (password.trim() != passwordComfirm.trim()) {
      
      SnackBarhelpers.showCustomSnackbar(
          title: 'Lỗi',
          message: 'Mật Khẩu không khớp',
          icon: Icons.warning_rounded,
          colorIcon: Colors.red,
          backgroundColor: Colors.white,);
      return false;
    }

    try {
      await firebaseAuththentication.signUpWithEmail(
          email: email, password: password);
      isSignUp = true;
    } catch (e) {
      rethrow;
    }
    return false;
  }

  void logout() async{
    await firebaseAuththentication.signOut();
    isLoggedIn = false;
    Get.offAllNamed(AppRoutes.loginPage); // Điều hướng về màn hình đăng nhập
  }
}

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

  @override
  void onClose() {
    emailLoginController.dispose();
    emailSignUpController.dispose();
    passwordLoginController.dispose();
    passwordSignUpController.dispose();
    passwordComfirmController.dispose();

    super.onClose();
  }

  Future<void> login() async {
    String email = emailLoginController.text;
    String password = passwordLoginController.text;

    if (email.trim() == "" || password.trim() == "") {
      Get.snackbar(
        'Lỗi',
        'Email và mật khẩu không được để trống',
        backgroundColor: const Color.fromRGBO(143, 148, 251, 1),
        colorText: Colors.black,
      );
      return;
    }
    try {
      await firebaseAuththentication.loginWithEmail(
          email: email, password: password);
      isLoggedIn = true;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> signUp() async {
    String email = emailSignUpController.text;
    String password = passwordSignUpController.text;
    try {
      await firebaseAuththentication.signUpWithEmail(
          email: email, password: password);
      isSignUp = true;
    } catch (e) {
      rethrow;
    }
  }

  void logout() {
    isLoggedIn = false;
    Get.offAllNamed(AppRoutes.loginPage); // Điều hướng về màn hình đăng nhập
  }
}

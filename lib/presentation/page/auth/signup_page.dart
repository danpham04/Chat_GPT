import 'package:chat_gpt/presentation/controller/auth/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupPage extends GetView<AuthController> {
  const SignupPage({super.key});


  @override
  Widget build(BuildContext context) {

    return Scaffold(
    appBar: AppBar(title: Text('SignupPage')),

    body: SafeArea(
      child: Text('SignupPageController'))
    );
  }
}
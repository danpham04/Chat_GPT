import 'package:animate_do/animate_do.dart';
import 'package:chat_gpt/app/config/app_icon.dart';
import 'package:chat_gpt/app/config/app_path.dart';
import 'package:chat_gpt/app/routers/app_routes.dart';
import 'package:chat_gpt/presentation/controller/auth/auth_controller.dart';
import 'package:chat_gpt/presentation/page/auth/widgets/custom_fade_text.dart';
import 'package:chat_gpt/presentation/page/auth/widgets/custom_fedein_img.dart';
import 'package:chat_gpt/presentation/widgets/text_field_app.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPage extends GetView<AuthController> {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Obx(
      () => Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 400,
                child: Stack(
                  children: <Widget>[
                    CustomFedeinImg(
                      pathImg: AppPath.background,
                      top: -40,
                      height: 400,
                      width: width,
                      duration: const Duration(seconds: 1),
                      fit: BoxFit.fill,
                    ),
                    CustomFedeinImg(
                      pathImg: AppPath.background2,
                      height: 400,
                      width: width + 20,
                      duration: const Duration(milliseconds: 1000),
                      fit: BoxFit.fill,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const CustomFadeText(
                      text: "Login",
                      fontWeight: FontWeight.bold,
                      size: 30,
                      color: Color.fromRGBO(49, 39, 79, 1),
                      duration: Duration(milliseconds: 1500),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    FadeInUp(
                      duration: const Duration(milliseconds: 1700),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          border: Border.all(
                              color: const Color.fromRGBO(196, 135, 198, .3)),
                          boxShadow: const [
                            BoxShadow(
                              color: Color.fromRGBO(196, 135, 198, .3),
                              blurRadius: 20,
                              offset: Offset(0, 10),
                            )
                          ],
                        ),
                        child: Column(
                          children: <Widget>[
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: const BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: Color.fromRGBO(196, 135, 198, .3),
                                  ),
                                ),
                              ),
                              child: TextFieldApp(
                                  controller: controller.emailLoginController,
                                  hintText: "Vui lòng nhập tên tài khoản",
                                  icon: Image.asset(
                                    AppIcons.user,
                                    width: 25,
                                  ),
                                  border: InputBorder.none,
                                  color: Colors.grey.shade700),
                            ),
                            Container(
                              padding: const EdgeInsets.all(10),
                              child: TextFieldApp(
                                controller: controller.passwordLoginController,
                                hintText: "Vui lòng nhập mật khẩu của bạn",
                                border: InputBorder.none,
                                keyboardType: TextInputType.number,
                                obscureText: controller.checkPassLogin.value,
                                icon: controller.checkPassLogin.value
                                    ? Image.asset(
                                        AppIcons.lock,
                                        width: 25,
                                      )
                                    : Image.asset(
                                        AppIcons.lockOpen,
                                        width: 25,
                                      ),
                                onPressed: () {
                                  controller.checkPassLogin.value =
                                      !controller.checkPassLogin.value;
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: CustomFadeText(
                        text: "Forgot Password?",
                        onPressed: () {
                          //TODO:
                        },
                        color: const Color.fromRGBO(196, 135, 198, 1),
                        duration: const Duration(milliseconds: 1700),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    FadeInUp(
                      duration: const Duration(milliseconds: 1900),
                      child: MaterialButton(
                        onPressed: () async {
                          await controller.login();
                          if (controller.isLoggedIn) {
                            Get.toNamed(AppRoutes.homescreen);
                          }
                        },
                        color: const Color.fromRGBO(49, 39, 79, 1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        height: 50,
                        child: const Center(
                          child: Text(
                            "Login",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Center(
                      child: CustomFadeText(
                        text: "Create Account",
                        duration: const Duration(milliseconds: 2000),
                        color: const Color.fromRGBO(49, 39, 79, .6),
                        onPressed: () {
                          //TODO
                          Get.toNamed(AppRoutes.signUp);
                        },
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

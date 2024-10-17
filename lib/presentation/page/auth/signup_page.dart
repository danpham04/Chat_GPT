import 'package:animate_do/animate_do.dart';
import 'package:chat_gpt/app/config/app_icon.dart';
import 'package:chat_gpt/app/config/app_paths.dart';
import 'package:chat_gpt/app/routers/app_routes.dart';
import 'package:chat_gpt/presentation/controller/auth/auth_controller.dart';
import 'package:chat_gpt/presentation/page/auth/widgets/custom_fade_text.dart';
import 'package:chat_gpt/presentation/page/auth/widgets/custom_fedein_img.dart';
import 'package:chat_gpt/presentation/widgets/text_field_app.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupPage extends GetView<AuthController> {
  const SignupPage({super.key});

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
                      pathImg: AppPaths.background,
                      top: -40,
                      height: 400,
                      width: width,
                      duration: const Duration(seconds: 1),
                      fit: BoxFit.fill,
                    ),
                    CustomFedeinImg(
                      pathImg: AppPaths.background2,
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
                      text: "Sign Up",
                      fontWeight: FontWeight.bold,
                      size: 30,
                      color: Color.fromRGBO(49, 39, 79, 1),
                      duration: Duration(milliseconds: 1500),
                    ),
                    const SizedBox(
                      height: 20,
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
                                  controller: controller.emailSignUpController,
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
                                controller: controller.passwordSignUpController,
                                hintText: "Vui lòng nhập mật khẩu của bạn",
                                border: InputBorder.none,
                                keyboardType: TextInputType.number,
                                obscureText: controller.checkPassSignUp.value,
                                icon: controller.checkPassSignUp.value
                                    ? Image.asset(
                                        AppIcons.lock,
                                        width: 25,
                                      )
                                    : Image.asset(
                                        AppIcons.lockOpen,
                                        width: 25,
                                      ),
                                onPressed: () {
                                  controller.checkPassSignUp.value =
                                      !controller.checkPassSignUp.value;
                                },
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(10),
                              child: TextFieldApp(
                                controller:
                                    controller.passwordComfirmController,
                                hintText: "Nhập lại mật khẩu của bạn",
                                border: InputBorder.none,
                                keyboardType: TextInputType.number,
                                obscureText: controller.checkPassComfirm.value,
                                icon: controller.checkPassComfirm.value
                                    ? Image.asset(
                                        AppIcons.lock,
                                        width: 25,
                                      )
                                    : Image.asset(
                                        AppIcons.lockOpen,
                                        width: 25,
                                      ),
                                onPressed: () {
                                  controller.checkPassComfirm.value =
                                      !controller.checkPassComfirm.value;
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
                    const SizedBox(
                      height: 30,
                    ),
                    FadeInUp(
                      duration: const Duration(milliseconds: 1900),
                      child: MaterialButton(
                        onPressed: () async {
                          await controller.signUp();
                          if (controller.isSignUp) {
                            Get.toNamed(AppRoutes.loginPage);
                          }
                        },
                        color: const Color.fromRGBO(49, 39, 79, 1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        height: 50,
                        child: const Center(
                          child: Text(
                            "Create Account",
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
                        text: "Login Account",
                        duration: const Duration(milliseconds: 2000),
                        color: const Color.fromRGBO(49, 39, 79, .6),
                        onPressed: () {
                          Get.offNamed(AppRoutes.loginPage);
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

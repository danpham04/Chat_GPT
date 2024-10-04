import 'package:animate_do/animate_do.dart';
import 'package:chat_gpt/app/config/app_path.dart';
import 'package:chat_gpt/presentation/controller/auth/auth_controller.dart';
import 'package:chat_gpt/presentation/page/auth/widgets/custom_fedein_img.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPage extends GetView<AuthController> {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
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
                  // Positioned(
                  //   top: -40,
                  //   height: 400,
                  //   width: width,
                  //   child: FadeInUp(
                  //       duration: const Duration(seconds: 1),
                  //       child: Container(
                  //         decoration: const BoxDecoration(
                  //             image: DecorationImage(
                  //                 image: AssetImage(
                  //                     'assets/images/background.png'),
                  //                 fit: BoxFit.fill)),
                  //       )),
                  // ),
                  CustomFedeinImg(
                    pathImg: AppPath.background2,
                    height: 400,
                    width: width + 20,
                    duration: const Duration(milliseconds: 1000),
                    fit: BoxFit.fill,
                  ),
                  // Positioned(
                  //   height: 400,
                  //   width: width + 20,
                  //   child: FadeInUp(
                  //     duration: const Duration(milliseconds: 1000),
                  //     child: Container(
                  //       decoration: const BoxDecoration(
                  //           image: DecorationImage(
                  //               image: AssetImage(
                  //                   'assets/images/background-2.png'),
                  //               fit: BoxFit.fill)),
                  //     ),
                  //   ),
                  // )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  FadeInUp(
                      duration: const Duration(milliseconds: 1500),
                      child: const Text(
                        "Login",
                        style: TextStyle(
                            color: Color.fromRGBO(49, 39, 79, 1),
                            fontWeight: FontWeight.bold,
                            fontSize: 30),
                      )),
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
                          ]),
                      child: Column(
                        children: <Widget>[
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: const BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        color: Color.fromRGBO(
                                            196, 135, 198, .3)))),
                            child: TextField(
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Username",
                                  hintStyle:
                                      TextStyle(color: Colors.grey.shade700)),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(10),
                            child: TextField(
                              obscureText: true,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Password",
                                  hintStyle:
                                      TextStyle(color: Colors.grey.shade700)),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  FadeInUp(
                    duration: const Duration(milliseconds: 1700),
                    child: Center(
                      child: TextButton(
                        onPressed: () {},
                        child: const Text(
                          "Forgot Password?",
                          style: TextStyle(
                              color: Color.fromRGBO(196, 135, 198, 1)),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  FadeInUp(
                      duration: const Duration(milliseconds: 1900),
                      child: MaterialButton(
                        onPressed: () {},
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
                      )),
                  const SizedBox(
                    height: 30,
                  ),
                  FadeInUp(
                    duration: const Duration(milliseconds: 2000),
                    child: Center(
                      child: TextButton(
                        onPressed: () {},
                        child: const Text(
                          "Create Account",
                          style:
                              TextStyle(color: Color.fromRGBO(49, 39, 79, .6)),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

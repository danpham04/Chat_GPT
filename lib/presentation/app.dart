import 'package:chat_gpt/app/routers/app_pages.dart';
import 'package:chat_gpt/app/routers/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.loginPage,
      getPages: AppPage.pages,
    );
  }
}

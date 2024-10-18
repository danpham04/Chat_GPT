import 'package:chat_gpt/presentation/app.dart';
import 'package:chat_gpt/presentation/controller/app_controller.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  //  await initServices();
  runApp(const MyApp());
}


initServices() async {
  await Get.put<AppController>(AppController(), permanent: true).init();
}

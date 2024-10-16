import 'package:chat_gpt/app/routers/app_routes.dart';
import 'package:chat_gpt/presentation/controller/auth/auth_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class RedirectMiddleware extends GetMiddleware {

  @override
  RouteSettings? redirect(String? route){
    // Giả sử bạn có một cách để kiểm tra người dùng đã đăng nhập hay chưa.
     final appController =  Get.find<AuthController>();

     bool isLoggedIn = appController.isLoggedIn;
    // Nếu người dùng không đăng nhập và cố gắng truy cập vào màn hình home,
    // chuyển hướng đến trang đăng nhập
    if (!isLoggedIn && route == AppRoutes.homescreen) {
      return RouteSettings(name: AppRoutes.loginPage);
    }
    // Nếu người dùng đã đăng nhập và cố gắng truy cập vào trang đăng nhập,
    // chuyển hướng đến màn hình home
    if (isLoggedIn && route == AppRoutes.loginPage) {
      return RouteSettings(name: AppRoutes.homescreen);
    }
    return null; // Trả về null để không làm gì cả
  }
}
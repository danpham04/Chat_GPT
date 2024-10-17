import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SnackBarhelpers {
  // Hàm hiển thị Snackbar được custom
  static void showCustomSnackbar(
      {required String title,
      required String message,
      Color backgroundColor = Colors.green,
      IconData? icon = Icons.check_circle,
      Duration duration = const Duration(seconds: 3),
      Color? colorIcon,
      Color? colorText,
      double? margin = 10,
      double? radius,
      SnackPosition? snackPosition}) {
    Get.snackbar(
      title, // Tiêu đề của Snackbar
      message, // Nội dung của Snackbar
      backgroundColor: backgroundColor, // Màu nền
      colorText: colorText, // Màu chữ
      icon: Icon(icon, color: colorIcon), // Icon
      snackPosition: snackPosition, // Vị trí hiển thị ở dưới
      borderRadius: radius, // Độ bo tròn
      margin: EdgeInsets.all(margin!), // Khoảng cách mép ngoài
      duration: duration, // Thời gian hiển thị
      isDismissible: true, // Cho phép vuốt để tắt
    );
  }
}

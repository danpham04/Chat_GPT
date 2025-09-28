import 'package:chat_gpt/app/helpers/snack_bar_helpers.dart';
import 'package:chat_gpt/presentation/controller/home/home_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NewChatDialog extends StatelessWidget {
  final TextEditingController _titleController = TextEditingController();

  NewChatDialog({super.key, required this.controller});
  final HomeScreenController controller;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Tạo Chat Mới'),
      content: TextField(
        controller: _titleController,
        decoration: const InputDecoration(
          hintText: 'Nhập tiêu đề chat',
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Get.back();
          },
          child: const Text('Hủy'),
        ),
        TextButton(
          onPressed: () async {
            String title = _titleController.text.trim();
            if (title.isNotEmpty) {
              // Kiểm tra xem title đã tồn tại chưa
              bool exists = await controller
                  .firebaseProvider
                  .checkTitleExists(title);
              if (exists) {
                SnackBarhelpers.showCustomSnackbar(
                    title: 'Cảnh báo',
                    message: "Tiêu đề đã tồn tại. Vui lòng chọn tiêu đề khác.",
                    icon: Icons.warning_amber_rounded,
                    colorIcon: Colors.red,
                    backgroundColor: Colors.white);
              } else {
                controller.startNewChat(title);
                Get.back();
                await controller.newTitlle(title);
              }
            } else {
              SnackBarhelpers.showCustomSnackbar(
                  title: 'Cảnh báo',
                  message: 'Tiêu đề không được để trống!',
                  icon: Icons.warning_amber_rounded,
                  colorIcon: Colors.red,
                  backgroundColor: Colors.white);
            }
          },
          child: const Text('Tạo'),
        ),
      ],
    );
  }
}

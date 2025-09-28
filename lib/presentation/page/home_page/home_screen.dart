import 'package:avatar_glow/avatar_glow.dart';
import 'package:chat_gpt/app/config/app_icon.dart';
import 'package:chat_gpt/app/helpers/snack_bar_helpers.dart';
import 'package:chat_gpt/presentation/controller/home/home_screen_controller.dart';
import 'package:chat_gpt/presentation/page/home_page/widgets/chat_message_ui.dart';
import 'package:chat_gpt/presentation/page/home_page/widgets/drawer_home.dart';
import 'package:chat_gpt/presentation/page/home_page/widgets/new_chat_dia_log.dart';
import 'package:chat_gpt/presentation/widgets/icon_button_app.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends GetView<HomeScreenController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 193, 234, 255),
      drawer: const DrawerHome(),
      appBar: AppBar(
        toolbarHeight: 70,
        centerTitle: true,
        title: const Text(
          'Chat GPT',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.green[400],
        actions: [
          IconButton(
            icon: Image.asset(
              AppIcons.note,
              color: Colors.black,
              width: 35,
            ),
            onPressed: () {
              Get.dialog(NewChatDialog(
                controller: controller,
              ));
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(() {
              if (controller.dataChatApp.isEmpty) {
                return const Center(
                  child: Text("No data available"),
                );
              } else {
                return ListView.builder(
                  controller: controller.scrollController,
                  reverse: true,
                  itemCount: controller.dataChatApp.length,
                  itemBuilder: (context, index) {
                    final chatMessage = controller.dataChatApp[index];
                    // biến kiểm tra xem có phải đoạn chat của người dùng không
                    bool isUser = chatMessage.role == 'user';
                    // So sánh thời gian của tin nhắn hiện tại với tin nhắn tiếp theo
                    bool showTimestamp = true;
                    if (index < controller.dataChatApp.length - 1) {
                      final nextMessage = controller.dataChatApp[index + 1];
                      if (chatMessage.day == nextMessage.day) {
                        showTimestamp = false;
                      }
                    }
                    return ChatMessageUI(
                      messageContent: chatMessage.content,
                      timestamp: chatMessage.day,
                      showTimestamp: showTimestamp,
                      isUserMessage: isUser,
                    );
                  },
                );
              }
            }),
          ),
          _chatInput(),
          Obx(() {
            if (controller.showSnackbar.value) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                SnackBarhelpers.showCustomSnackbar(
                  title: 'Cảnh báo',
                  message: controller.snackbarMessage.value,
                  icon: Icons.warning_amber_rounded,
                  colorIcon: Colors.red,
                  backgroundColor: Colors.white,
                );
                controller.showSnackbar.value = false; // Reset trạng thái
              });
            }
            return const SizedBox
                .shrink(); // Trả về widget rỗng để không chiếm không gian
          }),
        ],
      ),
    );
  }

  Widget _chatInput() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              child: Row(
                children: [
                  IconButtonApp(
                    onPressed: () {
                      Get.defaultDialog(
                        title: "Vui lòng nói vào mic",
                        middleText: "Nói nội dung bạn muốn tìm kiếm",
                        barrierDismissible: true,
                        actions: [
                          AvatarGlow(
                            glowColor: Colors.lightBlue,
                            animate: controller.isListening.value,
                            duration: const Duration(milliseconds: 2000),
                            repeat: true,
                            child: IconButton(
                              onPressed: controller.listen,
                              icon: const Padding(
                                padding: EdgeInsets.all(20.0),
                                child: Icon(
                                  Icons.mic,
                                  size: 30,
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                    icon: Icons.mic,
                    color: Colors.green,
                    size: 26,
                  ),
                  Expanded(
                    child: TextFormField(
                      controller: controller.textChat,
                      decoration: const InputDecoration(
                        hintText: 'Nhập văn bản',
                        border: InputBorder.none,
                        hintStyle: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          MaterialButton(
            minWidth: 0,
            shape: const CircleBorder(),
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
            onPressed: () {
              controller.addMessage();
            },
            color: Colors.green,
            child: const Icon(
              Icons.send,
              color: Colors.white,
              size: 26,
            ),
          )
        ],
      ),
    );
  }
}

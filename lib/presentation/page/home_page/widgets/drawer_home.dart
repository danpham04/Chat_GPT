import 'package:chat_gpt/app/config/app_icon.dart';
import 'package:chat_gpt/app/config/app_paths.dart';
import 'package:chat_gpt/presentation/controller/auth/auth_controller.dart';
import 'package:chat_gpt/presentation/controller/home/home_screen_controller.dart';
import 'package:chat_gpt/presentation/page/home_page/widgets/new_chat_dia_log.dart';
import 'package:chat_gpt/presentation/widgets/list_title_app.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DrawerHome extends StatelessWidget {
  const DrawerHome({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeScreenController controller = Get.find<HomeScreenController>();
    final AuthController authController = Get.find<AuthController>();

    return Drawer(
      backgroundColor: const Color.fromARGB(255, 211, 251, 255),
      child: Obx(() {
        if (controller.titles.isEmpty) {
          return const Center(
            child: Text('Không có chat nào.'),
          );
        } else {
          return Column(
            // dùng để kéo các thuộc tính trong column chiếm hết các chiều dài chiều rộng của column đó
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.amber,
                  image: DecorationImage(
                    image: AssetImage(AppPaths.img),
                    fit: BoxFit
                        .cover, // Điều chỉnh để hình ảnh phủ toàn bộ không gian
                  ),
                ),
                child: Text(
                  'Danh sách Chat',
                  style: TextStyle(color: Colors.black, fontSize: 24),
                ),
              ),
              ListTitleApp(
                radius: 10,
                textTitle: 'New chat',
                widgetLeading: const Icon(Icons.add),
                colorOne: const Color.fromARGB(28, 224, 224, 224),
                colorTwo: const Color.fromARGB(31, 255, 255, 255),
                border: Border.all(width: 1),
                onTap: () {
                  Get.dialog(NewChatDialog(controller: controller,));
                },
              ),
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: controller.titles.length,
                  itemBuilder: (context, index) {
                    // Các ListTile cho mỗi title
                    final title = controller.titles[index];
                    return ListTitleApp(
                      radius: 10,
                      textTitle: title,
                      colorText: Colors.black,
                      sizeText: 20,
                      onTap: () {
                        controller.loadChatByTitle(title);
                        Get.back(); // Đóng drawer
                      },
                      colorOne: const Color.fromARGB(255, 224, 224, 224),
                      colorTwo: Colors.white,
                      widgetTrailing: IconButton(
                        icon: Image.asset(
                          AppIcons.delete,
                          color: Colors.red,
                          width: 33,
                        ),
                        onPressed: () {
                          _showDeleteConfirmation(context, controller, title);
                        },
                      ),
                    );
                  },
                ),
              ),
              ListTitleApp(
                onTap: () {
                  authController.logout();
                },
                textTitle: 'Log out',
                sizeText: 20,
                radius: 10,
                widgetTrailing: IconButton(
                  icon: Image.asset(
                    AppIcons.logout,
                    color: Colors.black,
                    width: 33,
                  ),
                  onPressed: () {},
                ),
              )
            ],
          );
        }
      }),
    );
  }

  void _showDeleteConfirmation(
      BuildContext context, HomeScreenController controller, String title) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Xác nhận'),
          content: Text('Bạn có chắc chắn muốn xóa chat "$title"?'),
          actions: [
            TextButton(
              onPressed: () => Get.back(),
              child: const Text('Hủy'),
            ),
            TextButton(
              onPressed: () async {
                await controller.deleteChat(title);
                Get.back();
              },
              child: const Text('Xóa'),
            ),
          ],
        );
      },
    );
  }
}

import 'package:chat_gpt/presentation/controller/auth/auth_controller.dart';
import 'package:get/get.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(()=> AuthController());
  }

}
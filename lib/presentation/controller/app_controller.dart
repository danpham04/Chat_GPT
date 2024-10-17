import 'package:chat_gpt/app/util/dependency.dart';
import 'package:get/get.dart';

class AppController extends GetxController {
  init() async{
    setupLocator();
  }

  @override
  void onClose() {
    // Close all service
    Get.reset();
    super.onClose();
  }
  
  
  
}
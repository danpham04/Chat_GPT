import 'package:chat_gpt/data/repositories/chat_services.dart';
import 'package:chat_gpt/domain/repository/chat_repository.dart';
import 'package:get/get.dart';

Future<void> setupLocator() async {
  //Setup services
  Get.put(ChatServices());
  //Setup repository
  Get.put(ChatRepository());
  
}

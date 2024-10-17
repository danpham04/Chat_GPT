
import 'package:chat_gpt/data/repositories/chat_services.dart';
import 'package:chat_gpt/domain/models/request/chat_message_request.dart';
import 'package:chat_gpt/domain/models/response/message_chatgpt_model.dart';
import 'package:chat_gpt/domain/repository/base_repository.dart';

class ChatRepository extends BaseRepository {

  final ChatServices _chatServices = ChatServices();

  //lấy dữ liệu trả về với việc lấy một nmodel
  @override
  Future<MessageChatgptModel?> chatGPTMessage(ChatMessageRequest message) async{
    final response = await _chatServices.chatMessage(message);
    final data = response.message;
    return data;
  }
  
  

}
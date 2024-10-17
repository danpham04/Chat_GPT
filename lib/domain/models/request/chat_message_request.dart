import 'package:chat_gpt/domain/models/request/message_request_model.dart';

class ChatMessageRequest {
final List<MessageRequestModel> listMessage;

ChatMessageRequest({
  required this.listMessage
});

dynamic toMap() {
    List<Map<String, dynamic>> chatList = listMessage.map((chat) => chat.toMap()).toList();
    return  chatList;
    
  }

}
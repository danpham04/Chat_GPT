
import 'package:chat_gpt/domain/models/request/chat_message_request.dart';
import 'package:chat_gpt/domain/models/response/message_chatgpt_model.dart';

abstract class BaseRepository {
   Future<MessageChatgptModel?> chatGPTMessage(ChatMessageRequest message);
}

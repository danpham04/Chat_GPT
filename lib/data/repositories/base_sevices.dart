import 'package:chat_gpt/domain/models/request/chat_message_request.dart';
import 'package:chat_gpt/domain/models/response/choices_model.dart';

abstract class BaseSevices {
  // Future<ChoicesModel> chatMessage(List<MessageRequestModel> message);
  Future<ChoicesModel> chatMessage(ChatMessageRequest message);

}
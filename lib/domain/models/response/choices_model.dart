import 'package:chat_gpt/domain/models/response/message_chatgpt_model.dart';

class ChoicesModel {
  int index;
  MessageChatgptModel message;
  String? logprobs;
  String finishReason;

  ChoicesModel({
    required this.index,
    required this.message,
    required this.logprobs,
    required this.finishReason,
  });

  factory ChoicesModel.fromMap(Map<String, dynamic> map) {
    return ChoicesModel(
      index: map['index'],
       // Chuyển đổi 'message' từ Map<String, dynamic> thành MessageChatgptModel
      message: MessageChatgptModel.fromMap(map['message']),
      logprobs: map['logprobs'],
      finishReason: map['finish_reason']
      
    );
  }

 
  Map<String, dynamic> toMap() {
    return {
      'index': index,
      'message': message.toMap(),
      'logprobs': logprobs,
      'finish_reason': finishReason
    };
  }
}
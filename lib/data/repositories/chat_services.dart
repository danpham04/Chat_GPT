
import 'package:chat_gpt/data/repositories/base_sevices.dart';
import 'package:chat_gpt/data/rest_client.dart';
import 'package:chat_gpt/domain/models/request/chat_message_request.dart';
import 'package:chat_gpt/domain/models/response/choices_model.dart';

class ChatServices extends BaseSevices {
  final RestClient _restClient =
      RestClient(baseUrl: 'https://api.openai.com/v1');

  @override
  Future<ChoicesModel> chatMessage(ChatMessageRequest message) async {
    try {
      final data = {'model': 'gpt-3.5-turbo', 'messages': message.toMap()};
      final response = await _restClient.post('/chat/completions', data: data);
      // Trích xuất danh sách 'choices' từ phản hồi
      final choicesList = response['choices'] as List<dynamic>;
      
      if (choicesList.isEmpty) {
        throw Exception('Không có lựa chọn nào trong phản hồi từ API.');
      }
      // Lấy phần tử đầu tiên từ danh sách 'choices'
      final firstChoice = choicesList[0] as Map<String, dynamic>;

      // Chuyển đổi phần tử đầu tiên thành ChoicesModel
      ChoicesModel dataResponse = ChoicesModel.fromMap(firstChoice);

      final dataChoices = dataResponse;

      return dataChoices;
    } catch (e) {
      rethrow;
    }
  }
}

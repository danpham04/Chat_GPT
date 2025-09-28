import 'package:chat_gpt/app/helpers/snack_bar_helpers.dart';
import 'package:chat_gpt/data/database/data_firebase_provider.dart';
import 'package:chat_gpt/domain/models/request/chat_message_request.dart';
import 'package:chat_gpt/domain/models/request/message_request_model.dart';
import 'package:chat_gpt/domain/models/response/chat_mesage_response.dart';
import 'package:chat_gpt/domain/models/response/message_chatgpt_model.dart';
import 'package:chat_gpt/domain/repository/chat_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class HomeScreenController extends GetxController {
  final ChatRepository _chatRepository = ChatRepository();
  final DataFirebaseProvider firebaseProvider =
      DataFirebaseProvider(); // gọi firestore

  RxList<MessageRequestModel> data = <MessageRequestModel>[].obs;
  RxList<ChatMessageResponse> dataChatApp = <ChatMessageResponse>[].obs;
  List<Map<String, dynamic>> listMessage = <Map<String, dynamic>>[].obs;

  late TextEditingController textChat;
  late ScrollController scrollController;

  RxString currentTitle = ''.obs;
  RxList<String> titles = <String>[].obs; // Danh sách các titles

  // speech to text
  late stt.SpeechToText speechToText; // Khai báo SpeechToText
  RxBool isListening = false.obs; // Trạng thái lắng nghe
  RxDouble confidence = 1.0.obs;

  String? previousMessageTime;

  RxString snackbarMessage = ''.obs;
  RxBool showSnackbar = false.obs;
  RxString snackbarTitle = ''.obs;

  @override
  void onInit() {
    textChat = TextEditingController();
    scrollController = ScrollController();
    speechToText = stt.SpeechToText();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollController.hasClients) {
        scrollController.jumpTo(scrollController
            .position.maxScrollExtent); // Cuộn xuống dưới nếu cần
      }
      fetchTitles();
    });

    super.onInit();
  }

  @override
  void onClose() {
    speechToText.stop();
    textChat.dispose();
    scrollController.dispose();
    super.onClose();
  }

  // Hàm để fetch titles từ Firebase
  Future<void> fetchTitles() async {
    try {
      List<String> fetchedTitles = await firebaseProvider.readTitles();
      titles.assignAll(fetchedTitles);
    } catch (e) {
      //TODO:
      SnackBarhelpers.showCustomSnackbar(
          title: 'Lỗi',
          message: 'Không thể lấy danh sách tiêu đề!',
          icon: Icons.error_rounded,
          colorIcon: Colors.red,
          backgroundColor: Colors.white);
    }
  }

  void startNewChat(String title) {
    currentTitle.value = title;
    dataChatApp.clear();
    listMessage.clear();
  }

  Future<void> addMessage() async {
    // Kiểm tra xem người dùng có nhập tin nhắn không
    if (textChat.text.trim().isEmpty) {
      snackbarMessage.value = 'Bạn phải nhập thông tin';
      showSnackbar.value = true;
      snackbarTitle.value = 'Cảnh báo';
    }

    // Tạo list message từ người dùng
    else {
      MessageRequestModel messageSend =
          MessageRequestModel(role: 'user', content: textChat.text);
      data.add(messageSend);
      DateTime now = DateTime.now();
      // định dạng ngày giờ kiểu giời hiện tại và tháng
      String formattedDate = '${DateFormat('HH:mm').format(now)} T${now.month}';
      // Tạo ChatMessageResponse cho tin nhắn của người dùng
      ChatMessageResponse userMessage = ChatMessageResponse(
        role: 'user',
        content: messageSend.content,
        day: formattedDate,
      );

      dataChatApp.insert(0, userMessage); // Thêm vào danh sách

      textChat.clear(); // Xóa text sau khi gửi

      // 1 list cac message từ người dùng
      ChatMessageRequest listChat = ChatMessageRequest(listMessage: data);
      try {
        // Gửi tin nhắn đến repository và nhận phản hồi
        MessageChatgptModel? responseChat =
            await _chatRepository.chatGPTMessage(listChat);

        if (responseChat != null && responseChat.content.isNotEmpty) {
          // Lấy thời gian hiện tại cho phản hồi
          DateTime responseTime = DateTime.now();

          String formattedResponseTime =
              '${DateFormat('HH:mm').format(responseTime)} T${responseTime.month}';

          // Tạo ChatMessageResponse cho phản hồi từ ChatGPT
          ChatMessageResponse botResponse = ChatMessageResponse(
            role: 'bot',
            content: responseChat.content, // lấy content mà chat trả về
            day: formattedResponseTime,
          );

          dataChatApp.insert(0, botResponse);

          listMessage.insert(0, {
            "chatBot": botResponse.toJson(),
            "user": userMessage.toJson()
            
          }); // Thêm vào danh sách
        }
        await firebaseProvider.create(currentTitle.value, listMessage);
      } catch (e) {
        if (e.toString() == 'Exception: no_title' && currentTitle.value == '') {
          snackbarTitle.value = 'Thông báo';
          snackbarMessage.value =
              'Bạn hãy tạo một chủ đề để lưu trữ đoạn chat!';
          showSnackbar.value = true;
        } else {
          if (e is FirebaseException) {
            snackbarTitle.value = 'Lỗi';
            snackbarMessage.value = 'Đã có lỗi sảy ra tại firebase + $e';
            showSnackbar.value = true;
          } else {
            snackbarTitle.value = 'Lỗi';
            snackbarMessage.value = 'Đã có lỗi sảy ra + $e';
            showSnackbar.value = true;
          }
        }
      }
    }
  }

  Future<void> newTitlle(String title) async {
    await firebaseProvider.create(currentTitle.value, listMessage);
    await fetchTitles();
  }

  // Hàm để tải lại chat từ một title đã lưuba
  Future<void> loadChatByTitle(String title) async {
    currentTitle.value = title;
    dataChatApp.clear();
    listMessage.clear();

    try {
      List<Map<String, dynamic>> messages =
          await firebaseProvider.readMessages(title);
      for (var msg in messages) {
        dataChatApp.add(ChatMessageResponse.fromJson(msg['chatBot']));
        dataChatApp.add(ChatMessageResponse.fromJson(msg['user']));
        listMessage.add(msg);
      }
    } catch (e) {
      SnackBarhelpers.showCustomSnackbar(
          title: 'Lỗi',
          message: 'Không thể tải đoạn chat!',
          icon: Icons.error_rounded,
          colorIcon: Colors.red,
          backgroundColor: Colors.white);
    }
  }

  // Hàm để xóa một chat
  Future<void> deleteChat(String title) async {
    try {
      await firebaseProvider.deleteChat(title);
      dataChatApp.clear();
      currentTitle.value = '';
      // Cập nhật lại danh sách titles sau khi xóa
      await fetchTitles();
    } catch (e) {
      SnackBarhelpers.showCustomSnackbar(
          title: 'Lỗi',
          message: 'Không thể xóa đoạn chat!',
          icon: Icons.error_rounded,
          colorIcon: Colors.red,
          backgroundColor: Colors.white);
    }
  }

  void listen() async {
    if (!isListening.value) {
      bool available = await speechToText.initialize();
      if (available) {
        isListening.value = true;
        speechToText.listen(onResult: (val) {
          textChat.text = val.recognizedWords;
          if (val.hasConfidenceRating && val.confidence > 0) {
            confidence.value = val.confidence;
          }
        });
      }
    } else {
      isListening.value = false;
      speechToText.stop();
    }
  }
}

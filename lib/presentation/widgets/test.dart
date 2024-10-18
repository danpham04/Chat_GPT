

// class HomeScreenController extends GetxController {
//   final ChatRepository _chatRepository = ChatRepository();
//   // gọi firestore
//   final DataFirebaseProvider firebaseProvider = DataFirebaseProvider();
//   // Chuyển list data này vào trong chatMessage
//   RxList<MessageRequestModel> data = <MessageRequestModel>[].obs;

//   // Tạo một list model chứa message người dùng, content của chatGPT, và ngày nhập đoạn chat
//   RxList<ChatMessageResponse> dataChatApp = <ChatMessageResponse>[].obs;
//   List<Map<String, dynamic>> listMessage = <Map<String, dynamic>>[].obs;

//   late TextEditingController textChat;
//   late ScrollController scrollController;

//   RxString currentTitle = ''.obs;
//   // Danh sách các titles
//   RxList<String> titles = <String>[].obs;

//   // speech to text
//   late stt.SpeechToText speechToText; // Khai báo SpeechToText
//   RxBool isListening = false.obs; // Trạng thái lắng nghe
//   RxDouble confidence = 1.0.obs;

//   String? previousMessageTime;

//   @override
//   void onInit() {
//     textChat = TextEditingController();
//     scrollController = ScrollController();
//     speechToText = stt.SpeechToText();
//     fetchTitles();
//     super.onInit();
//   }

//   @override
//   void onClose() {
//     speechToText.stop();
//     textChat.dispose();
//     scrollController.dispose();
//     super.onClose();
//   }

//   // Hàm để fetch titles từ Firebase
//   Future<void> fetchTitles() async {
//     try {
//       List<String> fetchedTitles = await firebaseProvider.readTitles();
//       titles.assignAll(fetchedTitles);
//     } catch (e) {
//       SnackBarhelpers.showCustomSnackbar(
//           title: 'Lỗi',
//           message: 'Không thể lấy danh sách tiêu đề!',
//           icon: Icons.error_rounded,
//           colorIcon: Colors.red,
//           backgroundColor: Colors.white);
//     }
//   }

//   void startNewChat(String title) {
//     currentTitle.value = title;
//     dataChatApp.clear();
//     listMessage.clear();
//   }

//   Future<void> addMessage() async {
//     // if (currentTitle.value.isEmpty) {
//     //   Get.snackbar("Cảnh báo", "Bạn phải tạo một chat mới trước khi gửi tin nhắn.");
//     //   return;
//     // }
//     // Lấy thời gian hiện tại và định dạng nó
//     DateTime now = DateTime.now();
//     // định dạng ngày giờ kiểu giời hiện tại và tháng
//     String formattedDate = '${DateFormat('HH:mm').format(now)} T${now.month}';

//     // Kiểm tra xem người dùng có nhập tin nhắn không
//     if (textChat.text.trim().isEmpty) {
//       SnackBarhelpers.showCustomSnackbar(
//           title: 'Cảnh báo',
//           message: 'Bạn phải nhập thông tin',
//           icon: Icons.warning_amber_rounded,
//           colorIcon: Colors.red,
//           backgroundColor: Colors.white);
//       return;
//     }

//     // Tạo list message từ người dùng
//     MessageRequestModel messageSend =
//         MessageRequestModel(role: 'user', content: textChat.text);
//     data.add(messageSend);

//     // Tạo ChatMessageResponse cho tin nhắn của người dùng
//     ChatMessageResponse userMessage = ChatMessageResponse(
//       role: 'user',
//       content: messageSend.content,
//       day: formattedDate,
//     );

//     dataChatApp.insert(0, userMessage); // Thêm vào danh sách
//     listMessage.insert(0, userMessage.toJson());

//     // Thêm vào danh sách

//     textChat.clear(); // Xóa text sau khi gửi

//     // 1 list cac message từ người dùng
//     ChatMessageRequest listChat = ChatMessageRequest(listMessage: data);

//     try {
//       // Gửi tin nhắn đến repository và nhận phản hồi
//       MessageChatgptModel? responseChat =
//           await _chatRepository.chatGPTMessage(listChat);

//       if (responseChat != null && responseChat.content.isNotEmpty) {
//         // Lấy thời gian hiện tại cho phản hồi
//         DateTime responseTime = DateTime.now();
        
//         String formattedResponseTime =
//             '${DateFormat('HH:mm').format(responseTime)} T${responseTime.month}';

//         // Tạo ChatMessageResponse cho phản hồi từ ChatGPT
//         ChatMessageResponse botResponse = ChatMessageResponse(
//           role: 'bot',
//           content: responseChat.content, // lấy content mà chat trả về
//           day: formattedResponseTime,
//         );

//         dataChatApp.insert(0, botResponse);

//         listMessage.insert(0, botResponse.toJson()); // Thêm vào danh sách
//       await firebaseProvider.create(currentTitle.value, listMessage);
//       // Cập nhật lại danh sách titles sau khi lưu
//       await fetchTitles();
//       } else {
//         /// cục này thì check bên ui nếu mà responseChat null hoặc empty thì show ra lỗi 
//         SnackBarhelpers.showCustomSnackbar(
//             title: 'Lỗi',
//             message: 'Phản hồi từ server rỗng.!',
//             icon: Icons.error_rounded,
//             colorIcon: Colors.red,
//             backgroundColor: Colors.white);
//       }

//     } catch (e) {
//        String title= "Lỗi";
//        String message= "Có lỗi xảy ra";
//        // sau đó check case nếu e<error> trả ra từ firebase thì gán lại 
//        ///title="Lỗi firebase"
//        ///message="Lỗi từ firebase"
//        ///Nếu lỗi từ api thì gán lại mong muốn
//       SnackBarhelpers.showCustomSnackbar(
//           title: title,
//           message: message,
//           icon: Icons.error_rounded,
//           colorIcon: Colors.red,
//           backgroundColor: Colors.white);
//     }
   
//   }
//   //TODO: để chung tro

//   } catch (e) {
//        String title= "Lỗi";
//        String message= "Có lỗi xảy ra";
//        // sau đó check case nếu e<error> trả ra từ firebase thì gán lại 
//        ///title="Lỗi firebase"
//        ///message="Lỗi từ firebase"
//        ///Nếu lỗi từ api thì gán lại mong muốn
//       SnackBarhelpers.showCustomSnackbar(
//           title: title,
//           message: message,
//           icon: Icons.error_rounded,
//           colorIcon: Colors.red,
//           backgroundColor: Colors.white);
//     }
   
//   }
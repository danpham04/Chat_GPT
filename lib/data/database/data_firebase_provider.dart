import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DataFirebaseProvider {
  // khởi tạo firestore
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final User? _user = FirebaseAuth.instance.currentUser;

  //luu du lieu vao firebase
  Future<void> create(
    String title, // Tên tài liệu
    // String listChatDay,     // Ngày để lưu (có thể là ngày tạo)
    List<Map<String, dynamic>> listMessage,
    // Danh sách tin nhắn (Map)
  ) async {
    try {
      // Thực hiện lưu dữ liệu vào Firestore
      await _firestore
          .collection('user') // tạo một folderc có tên là 'user'
          .doc(_user!.uid) // Tài liệu người dùng với UID cụ thể
          .collection('message') // folder con của 'user' có tên là 'message'
          .doc(title) // Tiêu đề đoạn chat do người dùng nhập vào 'title'
          .set(
              {
            // Lưu thông tin tin nhắn vào Firestore
            'listChatDay': listMessage,
            'createdAt': FieldValue.serverTimestamp(), // thời gian tạo
          },
              // SetOption sử dụng để hợp nhất dữ liệu mà ko phải ghi đè lên toàn bộ dữ liệu
              SetOptions(merge: true));
    } catch (e) {
      print('Error saving messages: $e');
      rethrow; // Bắn lỗi ra nếu cos
    }
  }
// đọc tiêu đề đã lưu

  Future<List<String>> readTitles() async {
    if (_user == null) {
      throw Exception("User not authenticated");
    }

    try {
      QuerySnapshot snapshot = await _firestore
          .collection('user')
          .doc(_user.uid.toString())
          .collection('message')
          .get();

      List<String> titles = snapshot.docs.map((doc) => doc.id).toList();
      print('Danh sách: $titles');
      return titles;
    } catch (e) {
      print('hiển thị lỗi: $e');
      rethrow;
    }
  }

  // Đọc tin nhắn từ một tiêu đề cụ thể
  Future<List<Map<String, dynamic>>> readMessages(String title) async {
    try {
      DocumentSnapshot doc = await _firestore
          .collection('user')
          .doc(_user!.uid)
          .collection('message')
          .doc(title)
          .get();

      if (doc.exists) {
        List<dynamic> messages = doc.get('listChatDay') ?? [];
        return List<Map<String, dynamic>>.from(messages);
      } else {
        return [];
      }
    } catch (e) {
      print('Error reading messages: $e');
      rethrow;
    }
  }

  Future<void> deleteChat(String title) async {
    if (_user == null) {
      throw Exception("User not authenticated");
    }

    try {
      await _firestore
          .collection('user')
          .doc(_user.uid)
          .collection('message')
          .doc(title)
          .delete();
    } catch (e) {
      print('Error deleting chat: $e');
      rethrow;
    }
  }

  // Kiểm tra xem title đã tồn tại chưa
  Future<bool> checkTitleExists(String title) async {
    if (_user == null) {
      throw Exception("User not authenticated");
    }

    try {
      DocumentSnapshot doc = await _firestore
          .collection('user')
          .doc(_user.uid)
          .collection('message')
          .doc(title)
          .get();
      return doc.exists;
    } catch (e) {
      print('Error checking title: $e');
      rethrow;
    }
  }
}

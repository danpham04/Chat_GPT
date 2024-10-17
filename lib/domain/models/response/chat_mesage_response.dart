class ChatMessageResponse {
  final String role;    // Đổi từ 'message' thành 'role' để phản ánh đúng dữ liệu
  final String content;
  final String day;

  ChatMessageResponse({
    required this.role,
    required this.content,
    required this.day,
  });

  factory ChatMessageResponse.fromJson(Map<String, dynamic> map) {
    return ChatMessageResponse(
      role: map['role'] ?? 'user',        // Đảm bảo có giá trị mặc định nếu 'role' không tồn tại
      content: map['content'] ?? '',
      day: map['day'] ?? '',              // Đảm bảo có giá trị mặc định nếu 'day' không tồn tại
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'role': role,                       
      'content': content,
      'day': day,
    };
  }
}

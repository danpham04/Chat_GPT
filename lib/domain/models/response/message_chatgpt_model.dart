class MessageChatgptModel {
  String role;
  String content;
  String? refusal;

  MessageChatgptModel({
    required this.role,
    required this.content,
    this.refusal,
  });

  factory MessageChatgptModel.fromMap(Map<String, dynamic> map) {
    return MessageChatgptModel(
        role: map['role'], content: map['content'], refusal: map['refusal']);
  }

  Map<String, dynamic> toMap() {
    return {'role': role, 'content': content, 'refusal': refusal};
  }
}

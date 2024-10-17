class MessageRequestModel {
  String role;
  String content;
  
  MessageRequestModel({
    required this.role,
    required this.content,
    
  });

  factory MessageRequestModel.fromMap(Map<String, dynamic> map) {
    return MessageRequestModel(
      role: map['role'],
      content: map['content']
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'role': role,
      'content': content
      
    };
  }
}
class ChatModel {
  final int userId;
  final int chatId;
  final String message;

  const ChatModel({
    required this.message,
    required this.userId,
    required this.chatId,
  });

  factory ChatModel.fromJson(Map<String, dynamic> json) {
    return ChatModel(
      chatId: json['id'] as int,
      userId: json['userId'] as int,
      message: json['body'] as String,
    );
  }
}

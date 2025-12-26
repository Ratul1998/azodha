import 'package:chat_api/api.dart';

abstract class ChatState {
  final int chatId;

  const ChatState({required this.chatId});
}

class ChatLoadingState extends ChatState {
  const ChatLoadingState({required super.chatId});
}

class ChatStateLoaded extends ChatState {
  final List<MessageModel> messages;

  const ChatStateLoaded({required this.messages, required super.chatId});
}

class ChatErrorState extends ChatState {
  final Object error;
  final StackTrace? str;

  const ChatErrorState({required this.error, required super.chatId, this.str});
}

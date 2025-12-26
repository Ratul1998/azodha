import 'package:chat_api/api.dart';

abstract class ChatInteractor {
  Future<List<ChatModel>> getUserChat();

  Future<List<UserModel>> getUsers();

  Future<List<MessageModel>> getMessages(int chatId);
}

import 'package:chat_api/api.dart';
import 'package:dio/dio.dart';

class ChatService {
  static const _userEndpoint = '/users';
  static const _chatEndpoint = '/posts';
  static const _messagesEndpoint = '/comments';

  final Dio _dio;
  const ChatService({required Dio dio}) : _dio = dio;

  Future<List<UserModel>> getUsers() async {
    final users = await _dio.get(_userEndpoint);

    return (users.data as List<dynamic>)
        .map((map) => UserModel.fromJson(map))
        .toList();
  }

  Future<List<ChatModel>> getChats() async {
    final chats = await _dio.get(_chatEndpoint);

    return (chats.data as List<dynamic>)
        .map((map) => ChatModel.fromJson(map))
        .toList();
  }

  Future<List<MessageModel>> getMessages(int chatId) async {
    final messages = await _dio.get(
      _messagesEndpoint,
      queryParameters: {'postId': chatId},
    );

    return (messages.data as List<dynamic>)
        .map((map) => MessageModel.fromJson(map))
        .toList();
  }
}

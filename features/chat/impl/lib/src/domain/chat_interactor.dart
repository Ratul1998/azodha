import 'package:chat_api/api.dart';
import 'package:chat_impl/src/service/chat_service.dart';

class ChatInteractorImpl implements ChatInteractor {
  final ChatService _service;

  const ChatInteractorImpl({required ChatService service}) : _service = service;

  @override
  Future<List<MessageModel>> getMessages(int chatId) =>
      _service.getMessages(chatId);

  @override
  Future<List<ChatModel>> getUserChat() => _service.getChats();

  @override
  Future<List<UserModel>> getUsers() => _service.getUsers();
}

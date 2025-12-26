import 'package:chat_impl/src/service/chat_service.dart';
import 'package:dio/dio.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:test/test.dart';

void main() {
  late Dio dio;
  late DioAdapter dioAdapter;
  late ChatService service;

  setUp(() {
    dio = Dio(BaseOptions(baseUrl: 'https://jsonplaceholder.typicode.com'));
    dioAdapter = DioAdapter(dio: dio);
    service = ChatService(dio: dio);
  });

  group('ChatService', () {
    test('getUsers returns list of UserModel', () async {
      dioAdapter.onGet(
        '/users',
        (server) => server.reply(200, [
          {
            "id": 1,
            "name": "Leanne Graham",
            "username": "Bret",
            "email": "test@test.com",
            "address": {
              "street": "Kulas Light",
              "suite": "Apt. 556",
              "city": "Gwenborough",
              "zipcode": "92998-3874",
              "geo": {"lat": "0", "lng": "0"},
            },
            "phone": "123",
            "website": "test.com",
            "company": {"name": "Company", "catchPhrase": "Catch", "bs": "bs"},
          },
        ]),
      );

      final users = await service.getUsers();

      expect(users, isNotEmpty);
      expect(users.first.name, 'Leanne Graham');
    });

    test('getChats returns list of ChatModel', () async {
      dioAdapter.onGet(
        '/posts',
        (server) => server.reply(200, [
          {"userId": 1, "id": 1, "title": "Chat title", "body": "Last message"},
        ]),
      );

      final chats = await service.getChats();

      expect(chats.length, 1);
      expect(chats.first.message, 'Last message');
    });

    test('getMessages returns list of MessageModel', () async {
      dioAdapter.onGet(
        '/comments',
        queryParameters: {'postId': 1},
        (server) => server.reply(200, [
          {
            "postId": 1,
            "id": 1,
            "name": "Sender",
            "email": "sender@test.com",
            "body": "Hello!",
          },
        ]),
      );

      final messages = await service.getMessages(1);

      expect(messages.length, 1);
      expect(messages.first.body, 'Hello!');
    });
  });
}

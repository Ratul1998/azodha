import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:chat_ui/src/screen/chat/cubit/chat_cubit.dart';
import 'package:chat_ui/src/screen/chat/cubit/chat_state.dart';
import 'package:chat_api/api.dart';

import '../mocks.dart';

void main() {
  late MockChatInteractor interactor;

  setUp(() {
    interactor = MockChatInteractor();
  });

  final messages = [
    MessageModel(
      postId: 1,
      id: 1,
      name: 'Bob',
      email: 'b@test.com',
      body: 'Hello',
    ),
  ];

  group('ChatCubit', () {
    blocTest<ChatCubit, ChatState>(
      'emits [Loading, Loaded] when loadData succeeds',
      build: () {
        when(() => interactor.getMessages(1)).thenAnswer((_) async => messages);

        return ChatCubit(interactor: interactor, chatId: 1);
      },
      act: (cubit) => cubit.loadData(),
      expect: () => [
        isA<ChatStateLoaded>()
            .having((s) => s.messages, 'messages', messages)
            .having((s) => s.chatId, 'chatId', 1),
      ],
      verify: (_) {
        verify(() => interactor.getMessages(1)).called(1);
      },
    );

    blocTest<ChatCubit, ChatState>(
      'emits [Loading, Error] when loadData fails',
      build: () {
        when(
          () => interactor.getMessages(1),
        ).thenAnswer((_) => Future.error(Exception('error')));

        return ChatCubit(interactor: interactor, chatId: 1);
      },
      act: (cubit) => cubit.loadData(),
      expect: () => [
        isA<ChatErrorState>().having((s) => s.chatId, 'chatId', 1),
      ],
    );
  });
}
